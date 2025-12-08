-- ===============================================
-- Smart Farm Crop Health Monitor - Procedures Script
-- Author: HIRWA Roy (ID: 24174)
-- ===============================================

-- 1. Add New Reading
CREATE OR REPLACE PROCEDURE add_crop_reading (
    p_crop_id       IN NUMBER,   -- optional if needed for logic
    p_sensor_id     IN NUMBER,
    p_reading_value IN NUMBER
)
IS
BEGIN
    -- Insert reading into sensor_readings
    INSERT INTO sensor_readings(sensor_id, reading_value, reading_date)
    VALUES (p_sensor_id, p_reading_value, SYSDATE);

    COMMIT;
END;
/
-- -------------------------------------------------

-- 2. Generate Alert Manually
CREATE OR REPLACE PROCEDURE generate_alert (
    p_crop_id       IN NUMBER,
    p_sensor_id     IN NUMBER,
    p_alert_type    IN VARCHAR2,
    p_alert_message IN VARCHAR2
)
IS
BEGIN
    INSERT INTO alerts (
        crop_id, sensor_id, alert_type, alert_message, alert_date, status
    )
    VALUES (
        p_crop_id, p_sensor_id, p_alert_type, p_alert_message, SYSDATE, 'Pending'
    );

    COMMIT;
END;
/
-- -------------------------------------------------

-- 3. Check Crop Health Automatically
CREATE OR REPLACE PROCEDURE check_crop_health
IS
BEGIN
    FOR rec IN (
        SELECT r.reading_id, r.sensor_id, r.reading_value, s.sensor_type, c.crop_id
        FROM sensor_readings r
        JOIN sensors s ON r.sensor_id = s.sensor_id
        JOIN crops c ON s.sensor_id = r.sensor_id   -- assuming each sensor is linked to a crop
        WHERE r.reading_date >= TRUNC(SYSDATE)
    ) LOOP

        -- Temperature Alert
        IF rec.sensor_type = 'Temperature' AND rec.reading_value > 35 THEN
            generate_alert(rec.crop_id, rec.sensor_id, 'High Temperature', 'Temperature exceeded safe limit');
        END IF;

        -- Soil Moisture Alert
        IF rec.sensor_type = 'Soil Moisture' AND rec.reading_value < 30 THEN
            generate_alert(rec.crop_id, rec.sensor_id, 'Low Moisture', 'Moisture is below minimum threshold');
        END IF;

        -- Optional: Add pH or other sensor types if you add them later

    END LOOP;
END;
/

