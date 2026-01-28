CREATE TABLE IF NOT EXISTS employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    salary NUMERIC(12,2)
);

CREATE TABLE IF NOT EXISTS employees_log (
    log_id SERIAL PRIMARY KEY,
    employee_id INT,
    operation VARCHAR(10),
    old_data JSONB,
    new_data JSONB,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_employee_changes()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO employees_log(employee_id, operation, old_data, new_data)
        VALUES (NEW.id, 'INSERT', NULL, to_jsonb(NEW));
        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO employees_log(employee_id, operation, old_data, new_data)
        VALUES (NEW.id, 'UPDATE', to_jsonb(OLD), to_jsonb(NEW));
        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO employees_log(employee_id, operation, old_data, new_data)
        VALUES (OLD.id, 'DELETE', to_jsonb(OLD), NULL);
        RETURN OLD;
    END IF;
END;
$$;

CREATE TRIGGER trg_log_employees
AFTER INSERT OR UPDATE OR DELETE
ON employees
FOR EACH ROW
EXECUTE FUNCTION log_employee_changes();

INSERT INTO employees(name, position, salary)
VALUES
('Nguyen Van A', 'Developer', 1000),
('Tran Thi B', 'Tester', 800);

UPDATE employees
SET salary = 1200
WHERE id = 1;

DELETE FROM employees
WHERE id = 2;

SELECT * FROM employees;
SELECT * FROM employees_log;
