### WHO Alcohol total per capita consumption rate

In this directory you should find the following csv file:

```
WHOAlcoholTotalPerCapita_2021-09-20v2.csv
```

The file contains information from the World Health Organization. I downloaded the csv file from Kaggle's collection of datasets. You can find all the information about the creator of the dataset, the copyright information, and the license to use the dataset in the following links:

* [Link to the Kaggle page for the dataset](https://www.kaggle.com/datasets/mikekzan/who-alcohol-total-per-capita-consumption-rate). 
* [Link to license for the dataset](https://creativecommons.org/licenses/by-nc-sa/3.0/igo/)

The goal of this activity is to do the following:

* Import the csv file into a SQLite database.
* Normalize the database:
  * First design the normalization (by hand or in LucidChart)
  * Second implement the normalization (in SQLite)

### Importing the csv file into SQLite

To import the csv file into SQLite we first create an empty database. Use the methods we learned last time start up a SQLite3 session and open (i.e. create and connect to) a database called ``whoAlcohol.db``. 

To import the csv file we first change the mode to csv:

```
sqlite> .mode csv
```

Next, we use the ``.import`` command to import the data from the csv file into a table in our database. The format for the ``.import`` command is the following:

```
sqlite> .import  CSV_FILENAME TABLE_NAME
```

We can pick whatever we want for the table name. I'll use ``raw_data`` since we will be splitting it into a collection of tables soon when we get to normalizing. 

After performing the ``.import`` command, write a few queries to see what sort of data is in the table. 

We can see the exact CREATE code the ``.import`` command used to create the table using the ``.schema`` command:

```
sqlite> .schema
```

This is a good way to see a summary of the attributes in any database! 

### Normalization

##### Part 1: Design 

There are plenty of things we should change about the database. Think about the following questions:

 * What are the current data types? What should the data types be?
 * What are the current primary and foreign keys? What should they be?
 * Is the database normalized? If not, how would you go about normalizing it?

__TODO 1:__ Draw an ER diagram for a database that properly normalizes the given data. Be sure to include the appropriate data types, keys, and crow's feet.

##### Part 2: Implement

Once you have a design you're happy with (get it checked!) you can start implementing your new design into SQLite. 

__TODO 2:__ Implement your design into SQLite via the following steps:

1. Write and run the appropriate CREATE statements to get your new tables into the database. If you used LucidChart for your design, then you can extract SQL code to create your new tables, although you'll have to modify the code a bit since __LucidChart won't include foreign keys__ in the CREATE statements it generates.

2. Copy the existing data from ``raw_data`` into your new tables as appropriate. We learned how to do this in the Runestone assignment ``SQL - ALTER``. If you haven't finished that assignment yet, go do that first. When you move your data from the ``raw_data`` table to your new table, you'll want to convert the types of some columns. To do this you can use SQLite's CAST function which can converts the type of a value. For example, 
    ```
    CAST('2.3' AS REAL)
    ``` 
    converts the string ``'2.3'`` into the real number ``2.3``. 

3. Once all of your data is properly stored in your new tables, DROP the table ``raw_data`` from the database. 
 

### Querying your new database

Now that you have a beautifully normalized database with all the right data types, you should play with it. 

__TODO 3:__ Write queries to answer the following questions:

1. Which years are present in the database?

2. How many countries are represented?

3. What are the regions?

4. Which region has the fewest countries? What are the counties in that region? 

5. Which country and year had the highest alcohol consumption (per capita)?

6. Which region had the highest average alcohol consumption over all the years? What if you restrict to most recent year?

7. How many countries have all of their alcohol consumption listed as 0.0 (i.e. for every year)?  

