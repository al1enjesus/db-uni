--ALTER TABLE H_DOCTOR ADD COLUMN BONUS NUMERIC(9, 2) DEFAULT 0 NOT NULL;

CREATE OR REPLACE PROCEDURE add_bonus_to_doctor(
    doctor_id integer DEFAULT 0,
    doctor_surname varchar DEFAULT '',
    speciality varchar DEFAULT '',
    period_start date DEFAULT '1970-01-01',
    period_end date DEFAULT CURRENT_DATE
) 
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE H_DOCTOR
    SET BONUS = CASE
        WHEN doctor_id IS NOT NULL OR doctor_surname <> '' AND speciality IS NULL THEN (
            SELECT (
                   CASE
                       WHEN SUM(price) < 50 THEN SUM(price) * 1.1
                       WHEN SUM(price) BETWEEN 50 AND 100 THEN SUM(price) * 1.15
                       WHEN SUM(price) BETWEEN 100 AND 400 THEN SUM(price) * 1.3
                       WHEN SUM(price) > 400 THEN SUM(price) * 1.5
                       END)
            FROM H_VISIT
                 JOIN H_PATIENT HP on HP.N_CARD = H_VISIT.ID_PATIENT
                 JOIN H_SERVICES HS on H_VISIT.CODE_SRV = HS.CODE_SRV
            WHERE DATE_VISIT BETWEEN period_start AND period_end
              AND H_VISIT.ID_DOCTOR = doctor_id OR UPPER(HP.SURNAME) = UPPER(doctor_surname)
            )
        WHEN speciality <> '' THEN (
            SELECT (
                       CASE
                           WHEN SUM(price) < 50 THEN SUM(price) * 1.1
                           WHEN SUM(price) BETWEEN 50 AND 100 THEN SUM(price) * 1.15
                           WHEN SUM(price) BETWEEN 100 AND 400 THEN SUM(price) * 1.3
                           WHEN SUM(price) > 400 THEN SUM(price) * 1.5
                           END)
            FROM H_VISIT
                     JOIN H_PATIENT HP on HP.N_CARD = H_VISIT.ID_PATIENT
                     JOIN H_SERVICES HS on H_VISIT.CODE_SRV = HS.CODE_SRV
            WHERE DATE_VISIT BETWEEN period_start AND period_end
                AND CODE_SPEC = speciality
            )
    END
    WHERE ID_DOCTOR = doctor_id OR UPPER(SURNAME) = UPPER(doctor_surname) OR CODE_SPEC = speciality;
END;
$$;
