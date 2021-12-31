--Retrieve emp_no, f_n, and l_n columns from emp table.
DROP TABLE retirement_titles;
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
JOIN titles AS t
ON (t.emp_no=e.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER by e.emp_no, t.title DESC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (retirement_titles.emp_no) retirement_titles.emp_no,
retirement_titles.first_name,
retirement_titles.last_name,
retirement_titles.title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY retirement_titles.emp_no, retirement_titles.to_date DESC;

SELECT * FROM unique_titles;

--Retrieve # of titles from unique_titles
SELECT COUNT(ut.emp_no), rt.title
FROM unique_titles as ut
LEFT JOIN retirement_titles AS rt
ON ut.emp_no = rt.emp_no
GROUP BY rt.title
ORDER BY count DESC;

--Create retiring employees table - retiring titles
SELECT ut.count, rt.title
INTO retiring_titles
FROM unique_titles as ut
LEFT JOIN retirement_titles as rt
ON ut.emp_no = rt.emp_no
GROUP BY rt.title 
ORDER BY ut.count DESC;

SELECT * FROM retiring_titles;

-- Create membership_eligibility table
SELECT DISTINCT ON (e.emp_no)
    e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
    AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;	

SELECT * FROM mentorship_eligibility;

---New Code Below----

DROP TABLE retirement_titles;
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
JOIN titles AS t
ON (t.emp_no=e.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER by e.emp_no, t.title DESC;

SELECT * FROM retirement_titles;
DROP TABLE unique_titles;

SELECT DISTINCT ON (retirement_titles.emp_no) retirement_titles.emp_no,
retirement_titles.first_name,
retirement_titles.last_name,
retirement_titles.title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY retirement_titles.emp_no, retirement_titles.to_date DESC;

SELECT * FROM unique_titles;
DROP TABLE retiring_titles;

--Retrieve # of titles from unique_titles
SELECT COUNT (ut.title), ut.title
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;

--Create retiring employees table - retiring titles
SELECT ut.count, ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title 
ORDER BY ut.count DESC;

SELECT * FROM retiring_titles;
