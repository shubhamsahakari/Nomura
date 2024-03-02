#!/usr/bin/env python
# coding: utf-8

# In[1]:


pip install pandas sqlalchemy matplotlib pymysql


# In[33]:


from sqlalchemy import create_engine #setting up a connection to a MySQL database using SQLAlchemy
#imports the create_engine function from the SQLAlchemy library, which is used to create a connection engine to the database.
#defining variables with mysql credentials
username = 'root'
password = 'password'
host = 'localhost' # the database host
port = '3306' # the port number
database = 'citibikez'

# Creating the connection URL: constructs the database connection URL string using the previously defined variables
connection_url = f'mysql+pymysql://{username}:{password}@{host}:{port}/{database}'

# Creating the database engine
engine = create_engine(connection_url)#using the create_engine function along with the connection URL to create an SQLAlchemy engine


# In[42]:



import pandas as pd

# Question 1: Which 2 stations are most used by riders?
# I'm using UNION ALL in this query to get the count of start station and end station in total
#The reason is it would be better than looking at two different table to figure out the popularity.
#Query-->
query1 = """
SELECT station_name, SUM(total_uses) AS total_uses
FROM (
    SELECT `start station name` AS station_name, COUNT(*) AS total_uses
    FROM citibike
    GROUP BY `start station name`
    UNION ALL
    SELECT `end station name`, COUNT(*)
    FROM citibike
    GROUP BY `end station name`
) AS combined
GROUP BY station_name
ORDER BY total_uses DESC
LIMIT 3;
"""

# Executing query 1
df_stations = pd.read_sql_query(query1, engine) # loading the result from the SQL query into the dataframe

print(df_stations) # printing out our dataframe


# In[29]:


query_2 = """
SELECT EXTRACT(MONTH FROM starttime) AS month, COUNT(*) AS total_rides
FROM citibike
GROUP BY month
ORDER BY total_rides DESC
LIMIT 1;
"""

busiest_month = pd.read_sql_query(query_2, engine) 
print(busiest_month)


# In[28]:


query_3 = """
SELECT AVG(tripduration) / 60 AS average_ride_time_minutes
FROM citibike;
"""

average_ride_time = pd.read_sql_query(query_3, engine)
print(average_ride_time)


# In[30]:



query_4 = """
SELECT COUNT(*) AS same_origin_destination_rides
FROM citibike
WHERE `start station id` = `end station id`;
"""

# Execute Query 4
df_same_origin_destination = pd.read_sql_query(query_4, engine)

# Display the count of rides with the same origin and destination
print(df_same_origin_destination)


# In[ ]:




