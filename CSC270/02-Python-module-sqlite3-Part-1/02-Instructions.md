# The Python Module sqlite3

This document is an introduction to using the Python module sqlite3. For more details on the module you should check out the [api for the sqlite3 module](https://docs.python.org/3/library/sqlite3.html).

#### The database

To illustrate how to use the sqlite3 module, we will work with the database ``potter_family_tree.db`` which contains the entities ``Person`` and ``ParentChild`` that you have worked with in Runestone. Open a sqlite3 session in the Terminal and make sure you can see the current data in the database.

## The basics of the sqlite3 module

To get started with the python module, create a new file called ``potter_database.py``. Put the following import statement in that file in order to use the module:

```python
import sqlite3
```

Next, add the following line to connect to the database:

```python
conn = sqlite3.connect('potter_family_tree.db')
```

Now we create a cursor object which will allow use to execute SQL commands. Add the following line to the .py file:

```python
cur = conn.cursor()
```

We can run SQL commands on the database using the cursor's ``execute`` method. For example, to turn on foreign key constraints we could use the following:

```python
cur.execute("PRAGMA foreign_keys = ON;")
```

After that, we can add a new person to the database as follows:

```python
cur.execute("INSERT INTO Person(firstName, lastName) VALUES ('Albus', 'Dumbledore');")
```

Before running the Python program, we should commit (i.e. save) the changes we've made by adding the following line:

```python
conn.commit()
```

Finally, we should always close the connection when we are done by adding the following:

```python
conn.close()
```

At this point your ``potter_database.py`` file should look something like the following:

```python
import sqlite3

# Create a connection to the database
conn = sqlite3.connect('potter_family_tree.db')

# Create a cursor object
cur = conn.cursor()

# Turn on foreign key constraints:
cur.execute("PRAGMA foreign_keys = ON;")

# Add Dumbledore to the database:
cur.execute("INSERT INTO Person(firstName, lastName) VALUES ('Albus', 'Dumbledore');")

# Commit (i.e. save) the changes
conn.commit()

# Close the connection
conn.close()

```

#### Running the Python code

Recall that we can run the Python code by entering the following in the Terminal:

```shell
python3 potter_database.py
```

After running the command above, you should see a new row of data in the ``Person`` table. Write a query in a sqlite3 session to verify this.

#### Passing SQL code as a docstring

Since we are interacting with the database by passing SQL code as a string to the ``execute()`` method, and SQL code can get quite lengthy, it is common to pass SQL code as a docstrings (triple quotes). In particular, this allows for line breaks in our execute step. For example, the following code is equivalent to the similar execute statement above:

```python
cur.execute('''
    INSERT INTO Person (firstName, lastName)
    VALUES ('Albus', 'Dumbledore');
    ''')
```

#### Execute with variables

According to the sqlite3 module's API:

>To insert a variable into a query string, use a placeholder in the string, and substitute the actual values into the query by providing them as a tuple of values to the second argument of the cursor’s execute() method

In other word's, the execute command we used above to INSERT Albus Dumbledore into the database is equivalent to the following:

```python
first = 'Albus'
last = 'Dumbledore'
cur.execute('''
    INSERT INTO Person (firstName, lastName) 
    VALUES (?, ?);
    ''', (first, last))
```

#### Execute many

If you replace ``.execute`` with ``.executemany`` you can give a sequence (like a list) as the second argument. For example, the following should insert three people into the table:

```python
names = [('Draco', 'Malfoy'), 
         ('Narcisa', 'Black'), 
         ('Lucio', 'Malfoy')]
cur.executemany('''
    INSERT INTO Person (firstName, lastName)
    VALUES (?, ?);
    ''', names)
```

#### Let's make a function

We can use define a Python function named ``add_person`` to call whenever we want to add a person to our database. Here's what the entire ``potter_database.py`` file should look like after doing that:

```python
import sqlite3

def add_person(first, last):
    '''
    adds a person to the database with the 
    given first and last name
    '''
    
    # Create a connection to the database
    conn = sqlite3.connect('potter_family_tree.db')

    # Create a cursor object
    cur = conn.cursor()
    
    # Turn on foreignkey constraints:
    cur.execute("PRAGMA foreign_keys = ON;")

    # insert the person into the database:
    cur.execute('''
        INSERT INTO Person (firstName, lastName)
        VALUES (?, ?);
        ''', (first, last))

    # Commit (i.e. save) the changes
    conn.commit()

    # Close the connection
    conn.close()
```

You can now call this function to add a new person to our database. For example, the following will add Sirius Black to our database.

```python
add_person('Sirius', 'Black')
```

#### More functions!

We can create lots of function to modify the database via inserting, deleting, updating, etc. With each new function definition, we include all the setup (creating a connection, a cursor, and turning foreign key constraints on), then we execute some SQL, and then we commit and close the connection. Here are two more examples:

```python
def add_parent_child(parent_key, child_key):
    '''
    adds a parent child relationship
    to the database according to the given keys
    '''
    
    # Create a connection to the database
    conn = sqlite3.connect('potter_family_tree.db')

    # Create a cursor object
    cur = conn.cursor()
    
    # Turn on foreignkey constraints:
    cur.execute("PRAGMA foreign_keys = ON;")

    # insert the person into the database:
    cur.execute('''
        INSERT INTO ParentChild (parentKey, childKey)
        VALUES (?, ?);
        ''', (parent_key, child_key))

    # Commit (i.e. save) the changes
    conn.commit()

    # Close the connection
    conn.close()
```

```python
def remove_person(person_key):
    '''Removes a person from the database with the given person key'''
    
    # Create a connection to the database
    conn = sqlite3.connect('potter_family_tree.db')

    # Create a cursor object
    cur = conn.cursor()
    
    # Turn on foreign_key constraints
    cur.execute("PRAGMA foreign_keys = ON;")

    # insert the person into the database:
    cur.execute("DELETE FROM Person WHERE personKey = ?;", (person_key,))

    # Commit (i.e. save) the changes
    conn.commit()

    # Close the connection
    conn.close()
```

__Note:__ The ``execute`` method is expecting a tuple as it's second parameter. If we were to pass just ``person_key`` or ``(person_key)`` we would be passing an integer, which will raise the following error when we try to use the function:

```shell
ValueError: parameters are of unsupported type
```

This is the reason for the strange looking ``(person_key,)`` which is how you define a tuple with only one element. 

## A Simple Python App

We can use the sqlite3 module to create a (very simple) application to allow a user to interact with the database. A reasonable way to organize things is have two ``.py`` files:

* ``potter_database.py`` should include the three functions defined above. We can add more functions to it later, but we will reserve this file for functions that use the sqlite3 module to directly modify the database. 

* ``potter_app.py`` where we implement code to allow a user to interact. This file will not include any sqlite3 code; instead it will import the functions from the ``potter_database.py``. In this way, ``potter_database.py`` will act as a *proxy* for the database. 

The file ``potter_app.py`` has already been written. Open it up to see how it interacts with ``potter_database.py``. Then run the application by entering the following into the terminal:

```shell
python3 potter_app.py
```

Of course, it would be nice if the user could use the app to view some of the data. We will implement that next time when we see how  to use the sqlite3 module to *fetch* values from the database.

