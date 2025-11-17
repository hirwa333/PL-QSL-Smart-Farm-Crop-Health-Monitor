-- ===============================================
-- Trigger: Auto Risk Alert
-- ===============================================

CREATE OR REPLACE TRIGGER trg_check_crop_health
AFTER INSERT ON crop_health_readings
FOR EACH ROW
DECLARE
    v_score NUMBER;
    v_risk VARCHAR2(10);
BEGIN
    v_score := calculate_health_score(:NEW.crop_id);
    v_risk  := get_risk_level(:NEW.crop_id);

    IF v_risk IN ('Medium', 'High') THEN
        INSERT INTO alerts (
            alert_id, crop_id, sensor_id, alert_type, alert_message, alert_date, status
        )
        VALUES (
            alerts_seq.NEXTVAL,
            :NEW.crop_id,
            :NEW.sensor_id,
            'Risk Level: ' || v_risk,
            'Crop health warning. Score: ' || v_score,
            SYSDATE,
            'Pending'
        );
    END IF;
END;
/
