CREATE OR REPLACE FUNCTION total_bonus(
last_name varchar default '',
doctor_id int default 0
)
RETURNS numeric AS $$
SELECT COALESCE(SUM(bonus), 0)
FROM H_DOCTOR
WHERE H_DOCTOR.SURNAME = last_name OR H_DOCTOR.ID_DOCTOR = doctor_id;
