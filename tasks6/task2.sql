CREATE OR REPLACE FUNCTION total_price_for_patient(
card_num int,
start_date date default '1970-01-01',
end_date date default CURRENT_DATE
)
RETURNS numeric AS $$
SELECT COALESCE(SUM(price), 0)
FROM H_VISIT
JOIN H_PATIENT HP on HP.N_CARD = H_VISIT.ID_PATIENT
JOIN H_SERVICES HS on H_VISIT.CODE_SRV = HS.CODE_SRV
WHERE ID_PATIENT = card_num
AND DATE_VISIT BETWEEN start_date AND end_date;
$$ LANGUAGE SQL;
