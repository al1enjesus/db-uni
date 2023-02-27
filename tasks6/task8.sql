CREATE OR REPLACE PROCEDURE add_new_patient(
    p_surname varchar,
    p_first_name varchar,
    p_middle_name varchar,
    p_address varchar DEFAULT NULL,
    p_phone varchar DEFAULT NULL
) 
LANGUAGE plpgsql
AS $$
DECLARE
    new_id int;
BEGIN
    SELECT MAX(N_CARD) + 1 INTO new_id
    FROM H_PATIENT;
    CASE
        WHEN p_address LIKE '%Артемовск'
            OR p_address LIKE '%Черноморск'
            OR p_address LIKE '%Верхнехолмск'
            OR p_address LIKE '%Южногорск'
        THEN
            -- 1 uch --
            INSERT INTO H_PATIENT VALUES (new_id, p_surname, p_first_name, p_middle_name, p_address, p_phone);
        WHEN p_address LIKE '%Бердянск'
            OR p_address LIKE '%Прокопьевск'
            OR p_address LIKE '%Криворуков'
            OR p_address LIKE '%Урюпинск'
        THEN
            -- 2 uch --
            INSERT INTO H_PATIENT VALUES (new_id, p_surname, p_first_name, p_middle_name, p_address, p_phone);
        ELSE
            -- 3 uch --
            INSERT INTO H_PATIENT VALUES (new_id, p_surname, p_first_name, p_middle_name, p_address, p_phone);
    END CASE;
END;
$$;
