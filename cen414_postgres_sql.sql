import psycopg2
import pandas

conn = psycopg2.connect(host="localhost", port=5432, database="cen414_postgre_sql",
                        user="postgres", password="1234")
# to initiate connection to database

try:
    sql_query = """                  
         CREATE TABLE data(
             ID INT PRIMARY KEY NOT NULL,
             Country TEXT NOT NULL,
             Year INT NOT NULL,
             Item TEXT NOT NULL,
             Value FLOAT NOT NULL
         )
     """  # create table on the connected database
    cur = conn.cursor()

    cur.execute(sql_query)
    conn.commit()
except psycopg2.errors.DuplicateTable:
    pass

cur = conn.cursor()
conn.rollback()  # to avoid the DuplicateTable error


def input_values(data):
    # add values to table
    try:
        for (index, row) in data.iterrows():
            insert_sql_query = f'''
                insert into data(Country, Year, Area , Sex, Citizenship, Status_at_time_of_depature, Record_Type, Reliability, Source_Year, Value)
                values('{index + 1}'
                , '{row['Country_or_Area'].replace("'", " ")}'
                , '{row['Year']}'
                , 'Outflows by Status at Time and Departure and Sex'
				, '{row['Sex']}'
				, '{row['Citizenship']}'
				, '{row['Status_at_time_of_depature']}'	
				, '{row['Record_Type']}'		
				, '{row['Reliability']}'	
				, '{row['Source_Year']}'								   
                , '{row['Value']}')
            '''

            cur.execute(insert_sql_query)

        conn.commit()
    except psycopg2.errors.UniqueViolation:
        print('data already exist, add new data')
        pass


data_csv = pandas.read_csv('Statistics.csv')
input_values(data_csv)

cur.close()
conn.close()