-- ===============================================
-- Smart Farm Crop Health Monitor - Functions Script
-- Author: HIRWA Roy (ID: 24174)
-- ===============================================

-- =========================
-- 1. Function to Get Average Reading for a Crop
-- =========================
CREATE OR REPLACE FUNCTION get_average_reading (
    p_crop_id   IN NUMBER,
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

-- =========================
-- 2. Function to Calculate Crop Health Score
-- Health score is from 0 to 100
-- Example logic: lower score if temperature high, moisture low, pH off
-- =========================
CREATE OR REPLACE FUNCTION calculate_health_score (
    p_crop_id IN NUMBER
) RETURN NUMBER
IS
    v_temp NUMBER;
    v_moisture NUMBER;
    v_ph NUMBER;
    v_score NUMBER := 100;
BEGIN
    v_temp := get_average_reading(p_crop_id, 'Temperature');
    v_moisture := get_average_reading(p_crop_id, 'Moisture');
    v_ph := get_average_reading(p_crop_id, 'pH');

    -- Deduct points for temperature above 35°C
    IF v_temp > 35 THEN
        v_score := v_score - 30;
    END IF;

    -- Deduct points for moisture below 30%
    IF v_moisture < 30 THEN
        v_score := v_score - 30;
    END IF;

    -- Deduct points for pH out of 5.5-7.5 range
    IF v_ph < 5.5 OR v_ph > 7.5 THEN
        v_score := v_score - 20;
    END IF;

    IF v_score < 0 THEN
        v_score := 0;
    END IF;

    RETURN v_score;
END;
/

-- =========================
-- 3. Function to Determine Risk Level of a Crop
-- Risk Level: Low, Medium, High
-- =========================
CREATE OR REPLACE FUNCTION get_risk_level (
    p_crop_id IN NUMBER
) RETURN VARCHAR2
IS
    v_score NUMBER;
    v_risk VARCHAR2(10);
BEGIN
    v_score := calculate_health_score(p_crop_id);

    IF v_score >= 70 THEN
        v_risk := 'Low';
    ELSIF v_score >= 40 THEN
        v_risk := 'Medium';
    ELSE
        v_risk := 'High';
    END IF;

    RETURN v_risk;
END;
/
