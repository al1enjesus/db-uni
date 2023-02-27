CREATE OR REPLACE FUNCTION max_difference_of_visit_num_in_period(
start_date date default '1970-01-01',
end_date date default CURRENT_DATE
)
RETURNS integer AS $$
SELECT COALESCE(MAX(visit_count) - MIN(visit_count), 0)
FROM (
SELECT COUNT(*) AS visit_count
FROM H_VISIT
JOIN H_PATIENT HP on HP.N_CARD = H_VISIT.ID_PATIENT
JOIN H_DOCTOR HD on HD.ID_DOCTOR = H_VISIT.ID_DOCTOR
WHERE DATE_VISIT BETWEEN start_date AND end_date
GROUP BY HD.ID_DOCTOR
) AS visits;
$$ LANGUAGE SQL;
