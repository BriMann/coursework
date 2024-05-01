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


