import sqlite3

# Setting up
conn = sqlite3.connect('potter_family_tree.db')
cur = conn.cursor()
cur.execute("PRAGMA foreign_keys = ON;")


# Write a SQL query to get something:
cur.execute('''
            SELECT * FROM Person;
            ''')

# Fetch some data
data = cur.fetchall()


# Closing down
conn.commit()
conn.close()


# print what you fetched:
print(data)
