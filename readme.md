Database assignment 3

Rastislav Kollár 24/1/0855/019
Sviatoslav Dolinskyi 24/1/0855/043

Requirements:
Docker with TimescaleDB
pip install psycopg2-binary

To see our hypertable chunking use:

SELECT show_chunks('telemetry');


The documentation of how we can export schema and data from your database from assignment part 2, and import it to a timescale database:



Step 1:
Run this command in the terminal which gets all schems and data from database assignment_2 and turns it into .sql file:

mysqldump -u root -p --databases assignment_2 > assignment_2_dump.sql



Step 2:
Manually edit the sql file into PostgreSQL supported one, by changing: 
Turning AUTO_INCREMENT into SERIAL

Turning PK settings to this: reservation_id SERIAL PRIMARY KEY, instead of this: PRIMARY KEY (`reservation_id`),

Turning UNIQUE settings to this: email VARCHAR(100) UNIQUE,, instead of this: UNIQUE KEY `email` (`email`),

removing maridb commands or comments that are in the file, like: ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci, LOCK TABLES, UNLOCK TABLES

Turning INSERT INTO 'Customer' VALUES ... into INSERT INTO Customer (customer_id, first_name, second_name, etc) VALUES ...

Dropping somewhere '' entirely



Step 3:
if you already have a Timescale container(according to the documentation description you do), import all the dump with this command:

psql -U postgres -d postgres -h localhost -f assignment_2_dump.sql




