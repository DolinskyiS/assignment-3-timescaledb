import psycopg2

conn = psycopg2.connect(
    dbname="postgres",
    user="postgres",
    password="password",
    host="localhost",
    port="55432"
)

cur = conn.cursor()
cur.execute("""
    SELECT reservation_id, skipass_id, hour_bucket, scans
    FROM telemetry_scan_summary
    ORDER BY hour_bucket DESC
    LIMIT 10
""")

rows = cur.fetchall()
for row in rows:
    print(f"Reservation {row[0]}, Skipass {row[1]}: {row[3]} scans in hour {row[2]}")

cur.close()
conn.close()
