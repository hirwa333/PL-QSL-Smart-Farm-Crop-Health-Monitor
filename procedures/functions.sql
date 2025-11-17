-- ===============================================
-- Smart Farm Crop Health Monitor - Functions Script
-- Author: HIRWA Roy (ID: 24174)
-- ===============================================

-- 1. Get Average Reading
CREATE OR REPLACE FUNCTION get_average_reading (
    p_crop_id     IN NUMBER,
    p_sensor_type IN VARCHAR2
) RETURN NUMBER
IS
    v_avg NUMBER;
BEGIN
    SELECT AVG(r.reading_value)
    INTO v_avg
    FROM crop_health_readings r
    JOIN sensors s ON r.sensor_id = s.sensor_id
    WHERE r.crop_id = p_crop_id
      AND s.sensor_type = p_sensor_type;

    RETURN NVL(v_avg, 0);
END;
/

-- 2. Calculate Health Score
CREATE OR REPLACE FUNCTION calculate_health_score (
    p_crop_id IN NUMBER
) RETURN NUMBER
IS
    v_temp NUMBER;
    v_moisture NUMBER;
    v_ph NUMBER;
    v_score NUMBER := 100;
BEGIN
    v_temp     := get_average_reading(p_crop_id, 'Temperature');
    v_moisture := get_average_reading(p_crop_id, 'Soil Moisture');
    v_ph       := get_average_reading(p_crop_id, 'pH');

    IF v_temp > 35 THEN v_score := v_score - 30; END IF;
    IF v_moisture < 30 THEN v_score := v_score - 30; END IF;
    IF v_ph < 5.5 OR v_ph > 7.5 THEN v_score := v_score - 20; END IF;

    RETURN GREATEST(v_score, 0);
END;
/

-- 3. Get Risk Level
CREATE OR REPLACE FUNCTION get_risk_level (
    p_crop_id IN NUMBER
) RETURN VARCHAR2
IS
    v_score NUMBER;
BEGIN
    v_score := calculate_health_score(p_crop_id);

    IF v_score >= 70 THEN RETURN 'Low';
    ELSIF v_score >= 40 THEN RETURN 'Medium';
    ELSE RETURN 'High';
    END IF;
END;
/
