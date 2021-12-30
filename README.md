# Pewlett-Hackard-Analysis

## Overview of Pewlett-Hackard-Analysis
Pewlett-Hackard is a company concerned with the number of employees that will soon be reaching retirement age.  In order to plan for the upcoming "silver tsunami" of baby boomers that will be retiring from their company, they need to know how many positions will need to be filled.  Prior to this, all of their data was stored in six separate Excel files, which included the following data:

* Departments - department number and department name
* Employees - employee number, birth date, first name, last name, gender and hire date
* Salaries - employee number, salary, from_date, to_date
* Managers - department number, employee number, from_date, to_date
* Department Employees - department number, employee number, from_date, to_date
* Titles - employee number, title, from_date, to_date

As outlined above, a lot of data is available and much of it is duplicated.  In order to aggregate the data to provide concise information, it was necessary to create a database that would store joined information.  Joining the information into one database would allow specific data to be pulled to prepare for the onslaught of retirees and new positions that would be created.

![Pewlett-Hackard Employee Data](https://github.com/crtallent/Pewlett-Hackard-Analysis/blob/main/Analysis%20Project%20Folder/Pewlett-Hackard-Analysis%20Folder/EmployeeDB.png.png)


## Resources
- Software: PostgreSQL 12, pgAdmin4

## Pewlett-Hackard Analysis Results (Provide bulleted list with four major points from the two analysis deliverables.  Use images.)
After compiling the employee information including the number of employees reaching retirement age, the numbers were staggering.  In order to prepare for the imminent retirement of over 90,000 employees born between 1952 and 1955, it was decided to create a mentorship program so that eligible employees could train newer employees prior to their retirement.  This required getting information for employees born in 1965 as well, so that these employees could mentor newer employees prior to their retirement.

The first step in this process was to determine the number of retiring employees by title.  

* There are 90,398 employees retiring from Pewlett-Hackard within the next few years, as they were born between 1952 and 1955. A table was created to show this information as seen below:

```
--Retrieve emp_no, f_n, and l_n columns from emp table.
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
JOIN titles AS t
ON (t.emp_no=e.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER by e.emp_no, t.title DESC;
--SELECT 41380
--Query returned successfully in 199 msec.
SELECT * FROM retirement_titles;
```

![Retiring Employees](https://github.com/crtallent/Pewlett-Hackard-Analysis/blob/main/Analysis%20Project%20Folder/Pewlett-Hackard-Analysis%20Folder/retirement_titles.png)


* Upon further analysis, employees were duplicated when they changed position titles.  A new table was created with unique titles:

```
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (retirement_titles.emp_no) retirement_titles.emp_no,
retirement_titles.first_name,
retirement_titles.last_name,
retirement_titles.title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY retirement_titles.emp_no, retirement_titles.to_date DESC;
```

![Unique Titles](https://github.com/crtallent/Pewlett-Hackard-Analysis/blob/main/Analysis%20Project%20Folder/Pewlett-Hackard-Analysis%20Folder/unique_titles.png)

* A retiring titles table was created to contain the number of titles filled by employees who are retiring:

```
--Create retiring employees table - retiring titles
SELECT ut.count, rt.title
INTO retiring_titles
FROM unique_titles as ut
LEFT JOIN retirement_titles as rt
ON ut.emp_no = rt.emp_no
GROUP BY rt.title 
ORDER BY ut.count DESC;
```
![Retiring Titles](https://github.com/crtallent/Pewlett-Hackard-Analysis/blob/main/Analysis%20Project%20Folder/Pewlett-Hackard-Analysis%20Folder/retiring_titles.png)

* A list of employees eligible for the mentorship program, born in 1965 was created to prepare for the next "boom" of retirees:

```
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
```
![Eligible Mentors](https://github.com/crtallent/Pewlett-Hackard-Analysis/blob/main/Analysis%20Project%20Folder/Pewlett-Hackard-Analysis%20Folder/mentorship_elig.png)

