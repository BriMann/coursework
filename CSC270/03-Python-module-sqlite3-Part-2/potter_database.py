import sqlite3

def add_person(first, last):
    '''Adds a person to the database with given name'''

    # connect to the database
    conn = sqlite3.connect('potter_family_tree.db')

    # create a cursor
    cur = conn.cursor()

    # Execute some SQL: 
    # turned on foreign key constraints
    cur.execute("PRAGMA foreign_keys = ON;")

    # Add a person 
    cur.execute('''
        INSERT INTO Person(firstName, lastName) 
        VALUES (?, ?);
        ''', (first, last))

    # commit (i.e. save) changes
    conn.commit()

    # close the connection
    conn.close()

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

def get_all_people():
    '''Returns a list of all the data in the Person table'''
    
    # Create a connection to the database
    conn = sqlite3.connect('potter_family_tree.db')

    # Create a cursor object
    cur = conn.cursor()
    
    # Turn on foreign_key constraints
    cur.execute("PRAGMA foreign_keys = ON;")

    # Write a SQL query to get all data from the Person table:
    cur.execute("SELECT * FROM Person;")
    
    # Fetch all the resulting rows into a list
    rows = cur.fetchall()

    # Commit (i.e. save) the changes
    conn.commit()

    # Close the connection
    conn.close()
    
    return rows

def get_people(name):
    '''
    Returns a list of all rows from the Person table
    whose first or last name contains the given parameter.
    '''
    # Create a connection to the database
    conn = sqlite3.connect('potter_family_tree.db')

    # Create a cursor object
    cur = conn.cursor()
    
    # Turn on foreign_key constraints
    cur.execute("PRAGMA foreign_keys = ON;")

    # select all the people
    cur.execute('''
                SELECT * FROM Person
                WHERE firstName LIKE ? OR lastName LIKE ?;
                ''', ('%'+name+'%', '%'+name+'%'))
    
    # Fetch all the resulting rows into a list
    rows = cur.fetchall()

    # Commit (i.e. save) the changes
    conn.commit()

    # Close the connection
    conn.close()
    
    return rows
 
def get_person(person_key):
    '''
    Returns the row from the Person table
    with the given person_key.
    '''
    # Create a connection to the database
    conn = sqlite3.connect('potter_family_tree.db')

    # Create a cursor object
    cur = conn.cursor()
    
    # Turn on foreign_key constraints
    cur.execute("PRAGMA foreign_keys = ON;")

    # select the right person
    cur.execute('''
                SELECT * FROM Person
                WHERE personKey = ?;
                ''', (person_key,))
    
    # Fetch the resulting row as a tuple
    row = cur.fetchone()

    # Commit (i.e. save) the changes
    conn.commit()

    # Close the connection
    conn.close()
    
    return row

def get_parents(person_key):
    '''
    Returns the rows of data in the Person table correspodning 
    to the parents of the given key.
    '''
    # Create a connection to the database
    conn = sqlite3.connect('potter_family_tree.db')

    # Create a cursor object
    cur = conn.cursor()
    
    # Turn on foreign_key constraints
    cur.execute("PRAGMA foreign_keys = ON;")

    # select the parents
    cur.execute('''
                SELECT * FROM Person
                WHERE personKey IN (
                    SELECT parentKey 
                    FROM ParentChild
                    WHERE childKey = ?
                    );
                ''', (person_key,))
    
    # Fetch all the resulting rows into a list
    rows = cur.fetchall()

    # Commit (i.e. save) the changes
    conn.commit()

    # Close the connection
    conn.close()
    
    return rows

def get_first_name(person_key):
    '''Returns the first name of the person with the given key'''
    
    # Create a connection to the database
    conn = sqlite3.connect('potter_family_tree.db')

    # Create a cursor object
    cur = conn.cursor()
    
    # Turn on foreign_key constraints
    cur.execute("PRAGMA foreign_keys = ON;")

    # Write a SQL query to get the first name of the person:
    cur.execute('''
                SELECT firstName 
                FROM Person 
                WHERE personKey = ?;
                ''', (person_key,))
    
    # Fetch the resulting row as a tuple
    row = cur.fetchone()
    
    # Extract the only element (i.e. the first name) from the tuple
    first = row[0]

    # Commit (i.e. save) the changes
    conn.commit()

    # Close the connection
    conn.close()
    
    # don't forget to return the first name!
    return first