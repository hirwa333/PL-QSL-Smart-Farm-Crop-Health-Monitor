-- ===============================================
-- Trigger: Auto Risk Alert (Corrected)
-- ===============================================

CREATE OR REPLACE TRIGGER trg_check_crop_health
AFTER INSERT ON sensor_readings
FOR EACH ROW
DECLARE
    v_score NUMBER;
    v_risk  VARCHAR2(10);
    v_crop_id NUMBER;
BEGIN
    -- Get the crop_id for this sensor
    SELECT crop_id INTO v_crop_id
    FROM crops c
    JOIN sensors s ON c.crop_id = s.sensor_id
    WHERE s.sensor_id = :NEW.sensor_id;

    -- Calculate health score and risk
    v_score := calculate_health_score(v_crop_id);
    v_risk  := get_risk_level(v_crop_id);

    -- Insert alert if Medium or High risk
    IF v_risk IN ('Medium', 'High') THEN
        INSERT INTO alerts (
            crop_id, sensor_id, alert_type, alert_message, alert_date, status
        )
        VALUES (
            v_crop_id,
            :NEW.sensor_id,
            'Risk Level: ' || v_risk,
            'Crop health warning. Score: ' || v_score,
            SYSDATE,
            'Pending'
        );
    END IF;
END;
/
