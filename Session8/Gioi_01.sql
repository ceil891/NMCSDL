create table employees (
emp_id (SERIAL PRIMARY KEY)
emp_name (VARCHAR(100))
job_level (INT)
salary (NUMERIC)
)
/*
Tạo Procedure adjust_salary(p_emp_id INT, OUT p_new_salary NUMERIC) để:
Nhận emp_id của nhân viên
Cập nhật lương theo quy tắc trên */
CREATE OR REPLACE PROCEDURE adjust_salary(
    IN p_emp_id INT,
    OUT p_new_salary NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_job_level INT;
    v_salary NUMERIC;
BEGIN
    -- Lấy level và lương hiện tại
    SELECT job_level, salary
    INTO v_job_level, v_salary
    FROM employees
    WHERE emp_id = p_emp_id;

    -- Nếu không tìm thấy nhân viên
    IF v_salary IS NULL THEN
        RAISE EXCEPTION 'Nhân viên không tồn tại';
    END IF;

    -- Tính lương mới theo level
    IF v_job_level = 1 THEN
        p_new_salary := v_salary * 1.05;
    ELSIF v_job_level = 2 THEN
        p_new_salary := v_salary * 1.10;
    ELSIF v_job_level = 3 THEN
        p_new_salary := v_salary * 1.15;
    ELSE
        -- Nếu level khác 1-3 thì giữ nguyên
        p_new_salary := v_salary;
    END IF;

    -- Cập nhật lương mới
    UPDATE employees
    SET salary = p_new_salary
    WHERE emp_id = p_emp_id;

END;
$$;
