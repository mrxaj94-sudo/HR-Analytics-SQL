select * from attendance;
select * from departments;
select * from salaries;
select * from employees ;
select * from performance_reviews;




-- Q1. Retrieve all employees who are currently active.
select 
	* from employees
where employment_status ='Active';



-- Q2. Find employees hired after a specified date.
select
	* from employees 
where
	hire_date > '2022-01-01'
order by 
	hire_date desc
;



-- Q3. Retrieve employees working in the IT department.
select 
    e.employee_id,
	concat(e.first_name , ' ', e.last_name) as emp_name,
	d.department_name
from 
	employees e
join
	departments d on e.department_id = d.department_id
where
	d.department_name = 'IT'



-- Q4. Find Employees with Manager in Their Job Title

select 
	* from employees 
where 
	job_title like'%Manager%';



-- Q5. Find the average salary across all employees 
select 
	round(avg(salary),2) as average_emp_salary
from 
	salaries
where effective_to is null
	;

	
-- Q6. Count Employees in Each Department
select 
	d.department_name,
    count(e.employee_id) as employee_count
from 
	departments d
join 
	employees e on d.department_id = e.department_id
group by
 	d.department_name 
order by 
	employee_count desc;


-- Q7. Find Departments with More Than 10 Employees
select 
	d.department_name,
    count(e.employee_id) as employee_count
from 
	departments d
join 
	employees e on d.department_id = e.department_id
group by
 	d.department_name 
having 
	count(e.employee_id) > 10;



-- Q8. Calculate Minimum, Maximum, and Average Working Hours
select 
	min(working_hours) as Minimum_working_hours,
	max(working_hours) as Maximum_working_hours,
	round(avg(working_hours),2) as Average_working_hours
from
	attendance;
	


-- Q9. Count Employees by Employment Status
select 
    employment_status,
	count(employment_status) as employee_count
from 
	employees
group by 
	employment_status;


-- Q10. Find Employees Without Performance Reviews

select 
     e.employee_id,
	 concat(e.first_name, ' ', e.last_name) as emp_name,
	 e.department_id ,
	 e.hire_date
from
	employees e 
left join 
	performance_reviews pr on e.employee_id = pr.employee_id
where 
	pr.employee_id is null
	 
	 
	 
	




	


	
	





	
	










