-- ===============================================
-- Smart Farm Crop Health Monitor - Triggers Script
-- Author: HIRWA Roy (ID: 24174)
-- ===============================================

-- =========================
-- 1. Trigger: After Inserting a New Reading
-- Automatically check health score and insert alert if needed
-- =========================
CREATE OR REPLACE TRIGGER trg_check_crop_health
AFTER INSERT ON crop_health_readings
FOR EACH ROW
DECLARE
    v_health_score NUMBER;
    v_risk_level VARCHAR2(10);
BEGIN
    -- Calculate health score for the crop
    v_health_score := calculate_health_score(:NEW.crop_id);

    -- Determine risk level
    v_risk_level := get_risk_level(:NEW.crop_id);

    -- Insert into alerts table if risk is Medium or High
    IF v_risk_level = 'Medium' OR v_risk_level = 'High' THEN
        INSERT INTO alerts(alert_id, crop_id, alert_message, alert_date, risk_level)
        VALUES (
            alerts_seq.NEXTVAL, -- assuming alerts_seq is a sequence for alert_id
            :NEW.crop_id,
            'Crop health alert: Risk level is ' || v_risk_level || '. Current score: ' || v_health_score,
            SYSDATE,
            v_risk_level
        );
    END IF;
END;
/
