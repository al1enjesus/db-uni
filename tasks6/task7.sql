CREATE OR REPLACE FUNCTION add_new_doctor(
    d_surname varchar,
    d_first_name varchar,
    d_middle_name varchar,
    d_spec varchar DEFAULT NULL
) RETURNS VOID AS $$
DECLARE
    new_id INTEGER;
BEGIN
    SELECT COALESCE(MAX(ID_DOCTOR), 0) + 1 INTO new_id FROM H_DOCTOR;
    
    IF d_spec IS NULL THEN
        INSERT INTO H_DOCTOR (ID_DOCTOR, SURNAME, FIRST_NAME, MIDDLE_NAME, CODE_SPEC, DUMMY)
        VALUES (new_id, d_surname, d_first_name, d_middle_name, 1408, 0);
        
        UPDATE H_DOCTOR
        SET CODE_SPEC = (
            SELECT H.CODE_SPEC
            FROM H_SPECIALITY
            JOIN H_DOCTOR H on H_SPECIALITY.CODE_SPEC = H.CODE_SPEC
            GROUP BY H.CODE_SPEC
            HAVING COUNT(*) = (
                SELECT MIN(count)
                FROM (
                    SELECT COUNT(*) AS count
                    FROM H_DOCTOR
                    GROUP BY CODE_SPEC
                ) AS subq
            )
        )
        WHERE ID_DOCTOR = (
            SELECT H_SPECIALITY.CODE_SPEC
            FROM H_SPECIALITY
            JOIN H_DOCTOR HD on H_SPECIALITY.CODE_SPEC = HD.CODE_SPEC
            WHERE H_SPECIALITY.CODE_SPEC = 1408
        );
    ELSE
        IF NOT EXISTS (SELECT 1 FROM H_SPECIALITY WHERE CODE_SPEC = d_spec) THEN
            INSERT INTO H_SPECIALITY (CODE_SPEC, NAME_SPEC) VALUES ((SELECT COALESCE(MAX(CODE_SPEC), 0) + 1 FROM H_SPECIALITY), d_spec);
        END IF;
        
        INSERT INTO H_DOCTOR (ID_DOCTOR, SURNAME, FIRST_NAME, MIDDLE_NAME, CODE_SPEC, DUMMY)
        VALUES (new_id, d_surname, d_first_name, d_middle_name, d_spec, 0);
    END IF;
    
END;
$$ LANGUAGE plpgsql;
