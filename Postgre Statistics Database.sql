CREATE TABLE Public."Statistics"(Country varchar(100), Years int, Area varchar(100), Sex varchar(100), Citizenship varchar(100), Statustimeofdeparture varchar(200), Record varchar(100), Relaiability varchar(100), SourceYear int, TheValue bigint)

SET default_transaction_read_only = OFF;

copy Public."Statistics" FROM 'C:\Users\DELL\Statistics.csv' DELIMITER ',' CSV HEADER;

select * from Public."Statistics"