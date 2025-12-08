-- ===============================================
-- Smart Farm Crop Health Monitor - Seed Data Script
-- Author: HIRWA Roy (ID: 24174)
-- ===============================================

-- ===============================================
-- 1. Insert sample farms
-- ===============================================
INSERT INTO farms (farm_name, location) VALUES ('Green Valley Farm', 'Kigali, Rwanda');
INSERT INTO farms (farm_name, location) VALUES ('Sunrise Farm', 'Musanze, Rwanda');
INSERT INTO farms (farm_name, location) VALUES ('Lakeview Farm', 'Huye, Rwanda');

-- ===============================================
-- 2. Insert sample crops (linked to farms)
-- ===============================================
INSERT INTO crops (farm_id, crop_name, planting_date) 
VALUES (1, 'Tomato', TO_DATE('2025-03-01', 'YYYY-MM-DD'));

INSERT INTO crops (farm_id, crop_name, planting_date) 
VALUES (1, 'Potatoes', TO_DATE('2025-04-15', 'YYYY-MM-DD'));

INSERT INTO crops (farm_id, crop_name, planting_date) 
VALUES (2, 'Beans', TO_DATE('2025-02-20', 'YYYY-MM-DD'));

-- ===============================================
-- 3. Insert sample sensors
-- ===============================================
INSERT INTO sensors (sensor_type, location) VALUES ('Soil Moisture', 'Greenhouse 1');
INSERT INTO sensors (sensor_type, location) VALUES ('Temperature', 'Greenhouse 1');
INSERT INTO sensors (sensor_type, location) VALUES ('Soil Moisture', 'Field A');
INSERT INTO sensors (sensor_type, location) VALUES ('Temperature', 'Field A');
INSERT INTO sensors (sensor_type, location) VALUES ('Soil Moisture', 'Field B');
INSERT INTO sensors (sensor_type, location) VALUES ('Temperature', 'Field B');

-- ===============================================
-- 4. Insert sample alerts
-- ===============================================
INSERT INTO alerts (crop_id, sensor_id, alert_type, alert_message, alert_date, status) 
VALUES (1, 1, 'Low Moisture', 'Soil moisture too low for Tomato', SYSDATE-1, 'Pending');

INSERT INTO alerts (crop_id, sensor_id, alert_type, alert_message, alert_date, status) 
VALUES (1, 2, 'High Temperature', 'Temperature too high for Tomato', SYSDATE-1, 'Pending');

INSERT INTO alerts (crop_id, sensor_id, alert_type, alert_message, alert_date, status) 
VALUES (2, 3, 'Low Moisture', 'Soil moisture too low for Potatoes', SYSDATE-1, 'Pending');

INSERT INTO alerts (crop_id, sensor_id, alert_type, alert_message, alert_date, status) 
VALUES (3, 5, 'Low Moisture', 'Soil moisture too low for Beans', SYSDATE-1, 'Pending');

-- ===============================================
-- 5. Insert sample sensor readings
-- ===============================================
INSERT INTO sensor_readings (sensor_id, reading_value, reading_date) VALUES (1, 55, SYSDATE-1);
INSERT INTO sensor_readings (sensor_id, reading_value, reading_date) VALUES (2, 30, SYSDATE-1);
INSERT INTO sensor_readings (sensor_id, reading_value, reading_date) VALUES (3, 45, SYSDATE-1);
INSERT INTO sensor_readings (sensor_id, reading_value, reading_date) VALUES (4, 28, SYSDATE-1);
INSERT INTO sensor_readings (sensor_id, reading_value, reading_date) VALUES (5, 60, SYSDATE-1);
INSERT INTO sensor_readings (sensor_id, reading_value, reading_date) VALUES (6, 35, SYSDATE-1);

-- ===============================================
-- 6. Commit all inserts
-- ===============================================
COMMIT;

