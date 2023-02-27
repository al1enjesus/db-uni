CREATE OR REPLACE FUNCTION delete_visits(
    period_start date,
    period_end date
) RETURNS void AS $$
BEGIN
    CREATE TEMPORARY TABLE deleted_visits AS
    SELECT *
    FROM H_VISIT
    WHERE H_VISIT.DATE_VISIT BETWEEN period_start AND period_end;

    DELETE
    FROM H_VISIT
    WHERE H_VISIT.DATE_VISIT BETWEEN period_start AND period_end;
END;
$$ LANGUAGE plpgsql;
