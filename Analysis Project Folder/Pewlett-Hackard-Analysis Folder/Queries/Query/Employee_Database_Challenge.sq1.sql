DROP TABLE retirement_titles;
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
JOIN titles AS t
ON (t.emp_no=e.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER by e.emp_no

SELECT * FROM retirement_titles;
DROP TABLE unique_titles;

SELECT DISTINCT ON (retirement_titles.emp_no)retirement_titles.emp_no,
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
SELECT COUNT (ut.emp_no),ut.title
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;

SELECT COUNT (ut.emp_no)
FROM unique_titles as ut


--Create retiring employees table - retiring titles
SELECT ut.count, ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title 
ORDER BY ut.count DESC;

SELECT * FROM retiring_titles;
