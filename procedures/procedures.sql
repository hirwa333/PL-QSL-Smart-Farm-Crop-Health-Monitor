-- ===============================================
-- Smart Farm Crop Health Monitor - Procedures Script
-- Author: HIRWA Roy (ID: 24174)
-- ===============================================

-- 1. Add New Reading
CREATE OR REPLACE PROCEDURE add_crop_reading (
    p_crop_id       IN NUMBER,
    p_sensor_id     IN NUMBER,
    p_reading_value IN NUMBER
)
IS
BEGIN
    INSERT INTO crop_health_readings(crop_id, sensor_id, reading_value, reading_date)
    VALUES (p_crop_id, p_sensor_id, p_reading_value, SYSDATE);
END;
/

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
        alert_id, crop_id, sensor_id, alert_type, alert_message, alert_date, status
    )
    VALUES (
        alerts_seq.NEXTVAL,
        p_crop_id,
        p_sensor_id,
        p_alert_type,
        p_alert_message,
        SYSDATE,
        'Pending'
    );
END;
/

-- 3. Check Crop Health Automatically
CREATE OR REPLACE PROCEDURE check_crop_health
IS
BEGIN
    FOR rec IN (
        SELECT r.crop_id, r.sensor_id, r.reading_value, s.sensor_type
        FROM crop_health_readings r
        JOIN sensors s ON r.sensor_id = s.sensor_id
        WHERE r.reading_date >= TRUNC(SYSDATE)
    ) LOOP

        IF rec.sensor_type = 'Temperature' AND rec.reading_value > 35 THEN
            generate_alert(rec.crop_id, rec.sensor_id, 'High Temperature', 'Temperature exceeded safe limit');
        END IF;

        IF rec.sensor_type = 'Soil Moisture' AND rec.reading_value < 30 THEN
            generate_alert(rec.crop_id, rec.sensor_id, 'Low Moisture', 'Moisture is below minimum threshold');
        END IF;

        IF rec.sensor_type = 'pH' AND (rec.reading_value < 5.5 OR rec.reading_value > 7.5) THEN
            generate_alert(rec.crop_id, rec.sensor_id, 'pH Warning', 'pH is out of range');
        END IF;

    END LOOP;
END;
/
