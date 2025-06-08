import psycopg2
import random
from datetime import datetime, timedelta

## connecting to timescaledb
conn = psycopg2.connect(
    dbname="postgres",
    user="postgres",
    password="password",
    host="localhost",
    port="5432"
)
cur = conn.cursor()

## lets simulate 5 records
for record in range(5):
    skipass_id = random.randint(11, 20)
    resort_id = random.randint(1, 10)
    time_scanned = datetime.now() - timedelta(minutes=random.randint(0, 60))

    cur.execute("""
    INSERT INTO telemetry (skipass_id, resort_id, time_scanned)
    VALUES (%s, %s, %s)
    """, (skipass_id, resort_id, time_scanned))

    conn.commit()
    print(f"Inserted record {record + 1} at {time_scanned}. Skipass ID: {skipass_id}, Resort ID: {resort_id}")

cur.close()
conn.close()

