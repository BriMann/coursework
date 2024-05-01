# Command Line SQLite and Python

Up to this point we have been learning SQLite in Runestone Academy. You will continue to learn various topics in Runestone, but Runestone really isn't an appropriate place for larger projects. The purpose of this document is to describe how to work with the Linux terminal (i.e. the command line interface) in CoCalc. In particular, we will see how to implement both SQLlite and Python in the terminal. Eventually, we will see how to implement SQLite _within_ a Python program, but that will be covered in a future document.

## The Linux Terminal in Cocalc

To get to the terminal, split the frame either vertically or horizontally and switch the view to the ``Terminal`` (this will be shown in class). From there you can do a variety of wonderful things. For example, if you enter

```
ls
```

you should see a list of the contents in this directory (including this document: ``Command-Line-SQLite-and-Python.md``).

You can navigate to a different directory using ``cd``. For example, the command

```
cd ../
```

will take you to the parent directory of wherever you are. If you do that, enter `ls` again to see the contents of the directory where you landed. You should see a directory called `Airbnb`. Enter the following to see the contents of that folder:

```
ls Airbnb
```

You should see at least one available database, which we'll look at later. Next, let's return to the directory we started in by entering the following:

```
cd 00-Command-Line-SQLite-and-Python
```

__Useful Shortcuts:__

1. When you are typing the name of a file or directory in the terminal, you can hit `TAB` to autocomplete at any point after you have typed enough characters of the name to uniquely identify it. For example, in the cd-command above you could have typed `cd 00` and then hit `TAB` to see the full command autocomplete. Using `TAB` to autocomplete is an extremely useful habit to get into!

2. If you want to reuse commands in the Terminal, you can toggle with your up/down keys to see the recent history of your commands. This is a great way to save time, especially when you are running the same command over and over again to (say) run a Python script.

There are too many other wonderful commands you can execute in the terminal for me to list. We will go over a few other things you can do, but a quick google search will show you many more useful things you can do with the _linux command line_. Here is a short list of the commands I use all the time (google them to learn more):

- ``clear`` - clear the view in the Terminal window
- ``ls`` - list the contents of the current directory
- ``cd PATH`` - change directory
- ``open FILENAME`` - opens a file
- ``rm FILENAME`` - remove (i.e. delete) file
- ``touch FILENAME`` - used to create a new file
- ``mkdir DIRNAME`` - create a new directory (i.e. folder)

## Running Python from the Terminal

To create a Python program and run it from the terminal, we first create a file called `hello.py` where we can write our Python code. To do this in the terminal, enter the following command:

```
touch hello.py
```

Now, if you enter `ls` in the terminal you should see the new file. To open the file, enter the following command:

```
open hello.py
```

This should open up an empty file, that's waiting for you to write some Python code. Let's follow tradition and put the following code into the `hello.py` file:

```
print('Hello, world!')
```

Once that's done, we can run the program from the terminal. To do so, enter the following into the terminal:

```
python3 hello.py
```

You should see the message "Hello, world!" printed in the terminal. If you don't ask for help until you do.

If this is your first time working with Python in the terminal, congratulations!

## SQLite in the Terminal

Next, let's see how to run SQLite in the terminal. To get started, type the following into the terminal:

```
sqlite3
```

You should see some message with some version information, some instructions for getting hints, opening a persistent database, and then finally a new prompt that looks like the following:

```
sqlite3>
```

We can open up an existing database using the `.open` command. To open the database `airbnb.db` that lives in the `Airbnb` folder, we can enter the following:

```
sqlite3> .open ../Airbnb/airbnb.db
```

To see all the tables in the database you can enter the following:

```
sqlite3> .tables
```

We can now write all the usual SQL commands into the terminal to create tables, insert values into them, and run various queries. For example, we can see the first 5 rows in the locations table by entering the following:

```
sqlite3> SELECT * FROM locations LIMIT 5;
```

#### Dot commands

There are a variety of useful dot commands you can use when working with SQLite in the terminal. Here are a few that I find useful:

- `.open DBFILENAME` - connects to an existing database (or creates a new one if the `DBFILENAME` does not already exist).
- ``.tables`` - shows a list of all the tables in the database.
- ``.help`` - shows a list of all the dot commands.
- ``.headers on`` - includes the headers in the output of a query.
- ``.mode columns`` - shows the output of a query in nicely spaced columns instead of separated by |'s.
- ``.output FILENAME`` - writes the results of your queries to a text file.
- ``.quit`` - exit out of sqlite3. Return to the usual command line prompt.

You should play around with these commands to see what they do.

#### SQL scripts

For larger SQL sessions, typing everything into the terminal is a bit painful. Fortunately there are better ways to write and execute our SQL scripts. Soon we'll see how to use Python's ``sqlite3`` module to write SQL code _within_ a Python program. For today, I'd like you to learn how to write a SQL script in a separate file and run it using the terminal. To do so, we first need to exit out of the current sqlite3 session (if you're still in one). The following command will do just that:

```
sqlite3> .quit
```

That should bring you back to the usual command line interface. Next, create a file called ``example.sql`` using the ``touch`` command:

```
touch example.sql
```

Next, open this new file:

```
open example.sql
```

Put the following query in the ``example.sql`` file:

```
SELECT 
    lis.name, 
    loc.neighbourhood_group, 
    loc.neighbourhood
FROM
    locations AS loc
    INNER JOIN listings AS lis ON loc.locID = lis.locID
LIMIT
    10;
```

Now, in the Terminal (**not** in a sqlite3 session) enter the following to execute that code:

```
sqlite3 ../Airbnb/airbnb.db <example.sql
```

You should see 10 rows of data showing the names and neighborhood information of some airbnb listings. You can now create and play with your own SQLite databases!

## Individual TODOs

Complete the following two items before the due date (posted in Canvas). You don't need to submit anything, I can pull your solutions directly out of your CoCalc folder. Just make sure you use the exact filenames specified in the instructions and leave your files in this directory.

__Note:__ your solutions should be completely different than everyone else in class. If your solution looks like one of your classmates, you should both expect to get a score of 0.

1. __Write a Python program:__ 
   Create a new file named ``homework.py``. 
   Write a Python program that involves each of 
   the following:
   - Your program should prompt the user to enter something. 
     For example, if you want to get the user's 
     name you could write
     ```
     name = input("Enter your name.")
     ```

     You should ask the user for something 
     other than their name. 
     Feel free to ask for multiple inputs.

   - The program should do something (interesting) with 
     the user's input(s). 
     You can do whatever you want here. 
     I'd like to learn how much you all know about Python, 
     so please show off your Python skills. 
     If you are new to Python, it's okay to do something very simple. 
     If you have experience with Python, do something fun!

   - Prints a message showing the result of your program.


2. __Create a database:__ 
   Create a new database called ``homework.db``. Write a SQL script in a file you create called ``homework.sql`` to create some 
   tables in the database and fill them with data. In the end your database should have each of the following:
   - At least two tables with meaningful names.
   - At least two of your tables should each have at least two columns
     with meaningful names.
   - At least one foreign key.
   - At least two of your tables should each have at least two rows 
     of appropriate data.

