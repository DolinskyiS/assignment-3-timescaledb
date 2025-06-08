CREATE MATERIALIZED VIEW telemetry_scan_summary
WITH (timescaledb.continuous) AS
SELECT s.reservation_id,t.skipass_id, time_bucket('1 hour', t.time_scanned) AS hour_bucket, COUNT(*) AS scans
FROM telemetry t
JOIN skipass s ON s.skipass_id = t.skipass_id
GROUP BY s.reservation_id, t.skipass_id, hour_bucket;
