-- ===============================================
-- Smart Farm Crop Health Monitor - Procedures Script
-- Author: HIRWA Roy (ID: 24174)
-- ===============================================

-- =========================
-- 1. Procedure to Add a New Crop Health Reading
-- =========================
CREATE OR REPLACE PROCEDURE add_crop_reading (
    p_crop_id       IN NUMBER,
    p_sensor_id     IN NUMBER,
    p_reading_value IN NUMBER
)
IS
BEGIN
    INSERT INTO crop_health_readings(crop_id, sensor_id, reading_value, reading_date)
    VALUES (p_crop_id, p_sensor_id, p_reading_value, SYSDATE);

    COMMIT;
END;
/

-- =========================
-- 2. Procedure to Generate an Alert Based on a Reading
-- =========================
CREATE OR REPLACE PROCEDURE generate_alert (
    p_crop_id       IN NUMBER,
    p_sensor_id     IN NUMBER,
    p_alert_type    IN VARCHAR2,
    p_alert_message IN VARCHAR2
)
IS
BEGIN
    INSERT INTO alerts(crop_id, sensor_id, alert_type, alert_message, alert_date, status)
    VALUES (p_crop_id, p_sensor_id, p_alert_type, p_alert_message, SYSDATE, 'Pending');

    COMMIT;
END;
/

-- =========================
-- 3. Procedure to Check Crop Health and Auto-generate Alerts
-- Example thresholds: Temperature > 35, Moisture < 30
-- =========================
CREATE OR REPLACE PROCEDURE check_crop_health
IS
    v_reading crop_health_readings.reading_value%TYPE;
    v_sensor_type sensors.sensor_type%TYPE;
BEGIN
    FOR rec IN (
        SELECT r.reading_id, r.crop_id, r.sensor_id, r.reading_value, s.sensor_type
        FROM crop_health_readings r
        JOIN sensors s ON r.sensor_id = s.sensor_id
        WHERE r.reading_date = TRUNC(SYSDATE)  -- today’s readings
    )
    LOOP
        v_reading := rec.reading_value;
        v_sensor_type := rec.sensor_type;

        -- Temperature Alert
        IF v_sensor_type = 'Temperature' AND v_reading > 35 THEN
            generate_alert(rec.crop_id, rec.sensor_id, 'High Temperature', 'Temperature exceeds safe limit!');
        END IF;

        -- Moisture Alert
        IF v_sensor_type = 'Moisture' AND v_reading < 30 THEN
            generate_alert(rec.crop_id, rec.sensor_id, 'Low Moisture', 'Moisture below safe threshold!');
        END IF;

        -- pH Alert
        IF v_sensor_type = 'pH' AND (v_reading < 5.5 OR v_reading > 7.5) THEN
            generate_alert(rec.crop_id, rec.sensor_id, 'pH Warning', 'pH out of optimal range!');
        END IF;

    END LOOP;
END;
/

