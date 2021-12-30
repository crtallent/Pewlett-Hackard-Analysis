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

* There are 90,398 employees retiring from Pewlett-Hackard within the next few years, as they were born between 1952 and 1955.

![Retiring Employees](https://github.com/crtallent/Pewlett-Hackard-Analysis/blob/main/Analysis%20Project%20Folder/Pewlett-Hackard-Analysis%20Folder/retirement_titles.png)


* Upon further analysis, employees were duplicated when they changed position titles.  A new table was created with unique titles.

![Unique Titles](https://github.com/crtallent/Pewlett-Hackard-Analysis/blob/main/Analysis%20Project%20Folder/Pewlett-Hackard-Analysis%20Folder/unique_titles.png)

