-- ============================================================================
-- SMART FARM CROP HEALTH MONITOR - INSERT SAMPLE DATA
-- Complete data insertion for all tables
-- ============================================================================

-- ============================================================================
-- 1. INSERT INTO FARMERS TABLE
-- ============================================================================
INSERT INTO Farmers (First_Name, Last_Name, Phone, Email, Address)
VALUES ('Jean', 'Mukamana', '+250788123456', 'jean.mukamana@gmail.com', 'Kigali, Rwanda');

INSERT INTO Farmers (First_Name, Last_Name, Phone, Email, Address)
VALUES ('Alice', 'Uwimana', '+250788234567', 'alice.uwimana@gmail.com', 'Kigali, Rwanda');

INSERT INTO Farmers (First_Name, Last_Name, Phone, Email, Address)
VALUES ('Eric', 'Niyonzima', '+250788345678', 'eric.niyonzima@gmail.com', 'Musanze, Rwanda');

COMMIT;

-- ============================================================================
-- 2. INSERT INTO FARMS TABLE
-- ============================================================================
INSERT INTO Farms (Farmer_ID, Farm_Name, Location, Size_Acres, Soil_Type)
VALUES (1, 'Green Valley Farm', 'Kigali', 12.5, 'Loamy');

INSERT INTO Farms (Farmer_ID, Farm_Name, Location, Size_Acres, Soil_Type)
VALUES (2, 'Sunrise Farm', 'Kigali', 8.0, 'Sandy');

INSERT INTO Farms (Farmer_ID, Farm_Name, Location, Size_Acres, Soil_Type)
VALUES (3, 'Highland Farm', 'Musanze', 15.0, 'Clay');

COMMIT;

-- ============================================================================
-- 3. INSERT INTO CROPS TABLE
-- ============================================================================
INSERT INTO Crops (Farm_ID, Crop_Name, Plant_Date, Crop_Status)
VALUES (1, 'Tomatoes', TO_DATE('2025-09-01','YYYY-MM-DD'), 'Healthy');

INSERT INTO Crops (Farm_ID, Crop_Name, Plant_Date, Crop_Status)
VALUES (1, 'Lettuce', TO_DATE('2025-10-01','YYYY-MM-DD'), 'Healthy');

INSERT INTO Crops (Farm_ID, Crop_Name, Plant_Date, Crop_Status)
VALUES (2, 'Carrots', TO_DATE('2025-08-15','YYYY-MM-DD'), 'Diseased');

INSERT INTO Crops (Farm_ID, Crop_Name, Plant_Date, Crop_Status)
VALUES (3, 'Potatoes', TO_DATE('2025-07-10','YYYY-MM-DD'), 'Healthy');

COMMIT;

-- ============================================================================
-- 4. INSERT INTO SENSORS TABLE
-- ============================================================================
INSERT INTO Sensors (Farm_ID, Sensor_Type, Status)
VALUES (1, 'Soil Moisture Sensor', 'Active');

INSERT INTO Sensors (Farm_ID, Sensor_Type, Status)
VALUES (1, 'Temperature Sensor', 'Active');

INSERT INTO Sensors (Farm_ID, Sensor_Type, Status)
VALUES (2, 'Humidity Sensor', 'Active');

INSERT INTO Sensors (Farm_ID, Sensor_Type, Status)
VALUES (3, 'Soil pH Sensor', 'Active');

COMMIT;

-- ============================================================================
-- 5. INSERT INTO SENSOR_READINGS TABLE
-- ============================================================================
INSERT INTO Sensor_Readings (Sensor_ID, Crop_ID, Temperature, Humidity, Soil_Moisture, Health_Index)
VALUES (1, 1, 25.5, 70.0, 40.0, 95.0);

INSERT INTO Sensor_Readings (Sensor_ID, Crop_ID, Temperature, Humidity, Soil_Moisture, Health_Index)
VALUES (2, 2, 22.0, 60.0, 35.0, 90.0);

INSERT INTO Sensor_Readings (Sensor_ID, Crop_ID, Temperature, Humidity, Soil_Moisture, Health_Index)
VALUES (3, 3, 24.0, 80.0, 50.0, 60.0);

INSERT INTO Sensor_Readings (Sensor_ID, Crop_ID, Temperature, Humidity, Soil_Moisture, Health_Index)
VALUES (4, 4, 20.0, 65.0, 45.0, 92.0);

COMMIT;

-- ============================================================================
-- 6. INSERT INTO ALERTS TABLE
-- ============================================================================
INSERT INTO Alerts (Crop_ID, Alert_Type, Alert_Message, Severity)
VALUES (3, 'Pest Infestation', 'Carrots are affected by aphids', 'High');

INSERT INTO Alerts (Crop_ID, Alert_Type, Alert_Message, Severity)
VALUES (2, 'Water Deficiency', 'Lettuce requires more irrigation', 'Medium');

COMMIT;

-- ============================================================================
-- 7. INSERT INTO PEST_CONTROL TABLE
-- ============================================================================
INSERT INTO Pest_Control (Crop_ID, Pesticide_Name, Application_Date, Notes)
VALUES (3, 'Neem Oil', TO_DATE('2025-11-01','YYYY-MM-DD'), 'Applied morning spray');

INSERT INTO Pest_Control (Crop_ID, Pesticide_Name, Application_Date, Notes)
VALUES (2, 'Pyrethrin', TO_DATE('2025-11-03','YYYY-MM-DD'), 'Spot treatment on leaves');

COMMIT;

-- ============================================================================
-- 8. INSERT INTO WEATHER_LOGS TABLE
-- ============================================================================
INSERT INTO Weather_Logs (Farm_ID, Temperature, Humidity, Rainfall, Wind_Speed)
VALUES (1, 26.0, 65.0, 5.0, 12.0);

INSERT INTO Weather_Logs (Farm_ID, Temperature, Humidity, Rainfall, Wind_Speed)
VALUES (2, 24.5, 70.0, 0.0, 8.0);

INSERT INTO Weather_Logs (Farm_ID, Temperature, Humidity, Rainfall, Wind_Speed)
VALUES (3, 22.0, 60.0, 2.0, 10.0);

COMMIT;

-- ============================================================================
-- 9. INSERT INTO PRODUCTIVITY_REPORT TABLE
-- ============================================================================
INSERT INTO Productivity_Report (Crop_ID, Yield_Amount, Harvest_Date, Comments)
VALUES (1, 1200, TO_DATE('2025-11-10','YYYY-MM-DD'), 'Good quality tomatoes, early harvest');

INSERT INTO Productivity_Report (Crop_ID, Yield_Amount, Harvest_Date, Comments)
VALUES (4, 2500, TO_DATE('2025-11-05','YYYY-MM-DD'), 'Healthy potatoes, no pest damage');

COMMIT;

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================
SELECT 'FARMERS' AS Table_Name, COUNT(*) AS Records FROM Farmers
UNION ALL
SELECT 'FARMS', COUNT(*) FROM Farms
UNION ALL
SELECT 'CROPS', COUNT(*) FROM Crops
UNION ALL
SELECT 'SENSORS', COUNT(*) FROM Sensors
UNION ALL
SELECT 'SENSOR_READINGS', COUNT(*) FROM Sensor_Readings
UNION ALL
SELECT 'ALERTS', COUNT(*) FROM Alerts
UNION ALL
SELECT 'PEST_CONTROL', COUNT(*) FROM Pest_Control
UNION ALL
SELECT 'WEATHER_LOGS', COUNT(*) FROM Weather_Logs
UNION ALL
SELECT 'PRODUCTIVITY_REPORT', COUNT(*) FROM Productivity_Report;

PROMPT '=== SAMPLE DATA INSERTED SUCCESSFULLY! ===';
-- ============================================================================
