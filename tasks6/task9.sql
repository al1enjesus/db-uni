CREATE OR REPLACE FUNCTION reschedule_visit(
    old_date date DEFAULT '1970-01-01',
    new_date date DEFAULT CURRENT_DATE
) 
RETURNS INTEGER AS $$
    DECLARE 
        count_visit INTEGER;
    BEGIN
        SELECT COUNT(*) INTO count_visit
        FROM H_VISIT
        WHERE DATE_VISIT = old_date;

        UPDATE H_VISIT
        SET DATE_VISIT = new_date
        WHERE DATE_VISIT = old_date;

        RETURN count_visit;
    END;
$$ LANGUAGE plpgsql;
