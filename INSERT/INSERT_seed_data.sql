-- ===============================================
-- Smart Farm Crop Health Monitor - Seed Data Script
-- Author: HIRWA Roy (ID: 24174)
-- ===============================================

-- ===============================================
-- Create SEQUENCE for alert_id
-- ===============================================
CREATE SEQUENCE alerts_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- ===============================================
-- 1. Insert sample crops
-- ===============================================
INSERT INTO crops (crop_id, crop_name, planting_date, expected_harvest_date)
VALUES (1, 'Tomato', TO_DATE('2025-03-01', 'YYYY-MM-DD'), TO_DATE('2025-07-01', 'YYYY-MM-DD'));

INSERT INTO crops (crop_id, crop_name, planting_date, expected_harvest_date)
VALUES (2, 'Potatoes', TO_DATE('2025-04-15', 'YYYY-MM-DD'), TO_DATE('2025-06-15', 'YYYY-MM-DD'));

INSERT INTO crops (crop_id, crop_name, planting_date, expected_harvest_date)
VALUES (3, 'Beans', TO_DATE('2025-02-20', 'YYYY-MM-DD'), TO_DATE('2025-08-20', 'YYYY-MM-DD'));


-- ===============================================
-- 2. Insert sample sensors
-- ===============================================
INSERT INTO sensors (sensor_id, crop_id, sensor_type, unit)
VALUES (1, 1, 'Soil Moisture', '%');

INSERT INTO sensors (sensor_id, crop_id, sensor_type, unit)
VALUES (2, 1, 'Temperature', '°C');

INSERT INTO sensors (sensor_id, crop_id, sensor_type, unit)
VALUES (3, 2, 'Soil Moisture', '%');

INSERT INTO sensors (sensor_id, crop_id, sensor_type, unit)
VALUES (4, 2, 'Temperature', '°C');

INSERT INTO sensors (sensor_id, crop_id, sensor_type, unit)
VALUES (5, 3, 'Soil Moisture', '%');

INSERT INTO sensors (sensor_id, crop_id, sensor_type, unit)
VALUES (6, 3, 'Temperature', '°C');


-- ===============================================
-- 3. Insert sample crop health readings
-- ===============================================
INSERT INTO crop_health_readings (reading_id, crop_id, sensor_id, reading_value, reading_date)
VALUES (1, 1, 1, 55, SYSDATE-1);

INSERT INTO crop_health_readings (reading_id, crop_id, sensor_id, reading_value, reading_date)
VALUES (2, 1, 2, 30, SYSDATE-1);

INSERT INTO crop_health_readings (reading_id, crop_id, sensor_id, reading_value, reading_date)
VALUES (3, 2, 3, 45, SYSDATE-1);

INSERT INTO crop_health_readings (reading_id, crop_id, sensor_id, reading_value, reading_date)
VALUES (4, 2, 4, 28, SYSDATE-1);

INSERT INTO crop_health_readings (reading_id, crop_id, sensor_id, reading_value, reading_date)
VALUES (5, 3, 5, 60, SYSDATE-1);

INSERT INTO crop_health_readings (reading_id, crop_id, sensor_id, reading_value, reading_date)
VALUES (6, 3, 6, 35, SYSDATE-1);


-- ===============================================
-- 4. Insert sample alerts (using sequence)
-- ===============================================
INSERT INTO alerts (alert_id, crop_id, alert_message, alert_date, risk_level)
VALUES (alerts_seq.NEXTVAL, 1, 'Initial alert for Tomato', SYSDATE-1, 'Medium');

INSERT INTO alerts (alert_id, crop_id, alert_message, alert_date, risk_level)
VALUES (alerts_seq.NEXTVAL, 2, 'Initial alert for Potatoes', SYSDATE-1, 'Low');

INSERT INTO alerts (alert_id, crop_id, alert_message, alert_date, risk_level)
VALUES (alerts_seq.NEXTVAL, 3, 'Initial alert for Beans', SYSDATE-1, 'High');

COMMIT;
