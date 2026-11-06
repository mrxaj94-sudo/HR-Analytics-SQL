select * from attendance;
select * from departments;
select * from salaries;
select * from employees;
select * from performance_reviews;



-- Q11. Calculate Salary Statistics for Each Department
select 
	d.department_name,
	count(distinct e.employee_id) as employee_count,
	round(avg(s.salary),2) as avg_salary,
	min(s.salary) as min_salary,
	max(s.salary) as max_salary
from 
	employees e 
join 
	departments d on d.department_id = e.department_id
join
	salaries s on e.employee_id = s.employee_id
where 
	effective_to is null	
group by 
    d.department_id,
	d.department_name
order by 
	employee_count desc;


-- Q12. Find Employees Earning Above Their Department's Average Salary
with avg_depth_salary as(
select
    d.department_id,
	d.department_name ,
	round(avg(s.salary),2) as avg_depth_salary
from 
   departments d 
join 
	employees e on d.department_id = e.department_id
join 
	salaries s on s.employee_id = e.employee_id
where 
	effective_to is null
group by 
     d.department_id,
	 d.department_name

	
)

select
   concat(e.first_name , ' ', e.last_name) as emp_name,
   d.department_name,
   ads.avg_depth_salary,
     s.salary
from 
	employees e 
join 
	salaries s on e.employee_id = s.employee_id
join 
	avg_depth_salary ads on e.department_id = ads.department_id
join 
	departments d on e.department_id = d.department_id
where
    effective_to is null and 
	s.salary > ads.avg_depth_salary 
order by 
	d.department_name;



-- Q13. Calculate Employee Tenure
select 
	concat(first_name , ' ' , last_name) as employee_name,
	hire_date,
	age(current_date, hire_date) as years_of_service
from 
	employees
group by
	employee_id,
	first_name,
	last_name,
	hire_date
;


-- Q14. Calculate Employee Attendance Percentage
select
	concat(e.first_name , ' ' , e.last_name) as employee_name,
	round(count(a.status) 
	filter(where a.status = 'Present')* 100.0 
	/ nullif(count(a.status),0),2) as attendance_rate
from
	employees e
left join
	attendance a on e.employee_id = a.employee_id
group by 
    e.employee_id,
	e.first_name,
	e.last_name
order by 
	attendance_rate desc nulls last;



-- Q15. Calculate Average Working Hours by Department
select 
	d.department_name,
	round(avg(a.working_hours),2) as average_working_hours
from 
	departments d
join 
	employees e on  e.department_id = d.department_id
join 
	attendance a on e.employee_id = a.employee_id
group by 
	d.department_name
order by 
	average_working_hours desc;

	

-- Q16. Find Employees with an Average Performance Rating Above 4
select 
	concat(e.first_name , ' ' , e.last_name) as employee_name,
	round(avg(pr.rating),2) as emp_rating
from 
	employees e
join
	performance_reviews pr on 
	e.employee_id = pr.employee_id
group by 
	e.employee_id ,
	e.first_name,
	e.last_name
having
	avg(pr.rating) > 4.0
order by 
	emp_rating desc
;



-- Q17. Find employees whose salary has increased at least once.
select
	e.employee_id,
	concat(e.first_name , ' ', e.last_name) as employee_name
from 
	employees e 
join 
	salaries s1 on e.employee_id = s1.employee_id
join 
	salaries s2 on e.employee_id = s2.employee_id
where
	s2.effective_from > s1.effective_from
	and s2.salary > s1.salary
group by 
	e.employee_id,
	first_name,
	last_name
order by
	employee_id ;




-- Q18. Find Employees Hired Within the Last Two Years
select 
    employee_id,
	concat(first_name , ' ' , last_name) as employee_name,
    hire_date 
from 
	employees 
where
	hire_date >=(current_date - Interval '2 year')
order by 
    hire_date desc;



-- Q19. Find Managers and Count Their Direct Reports
select
	concat(m.first_name, ' ', m.last_name) as manager_name,
	count(e.employee_id) as number_of_direct_reports
from 
    employees e
 join
	employees m on e.manager_id = m.employee_id
group by 
	e.manager_id,
	m.first_name,
	m.last_name
order by 
	number_of_direct_reports desc;



-- Q20. Find Departments with at Least Five Reviewed Employees
select
     d.department_name ,
	 round(avg(pr.rating),2) as avg_performance_rating,
	 count(distinct e.employee_id) as employee_count
from 
    departments d 
join 
	employees e on d.department_id = e.department_id
join
	performance_reviews pr on e.employee_id = pr.employee_id
group by 
	d.department_name
having 
     count(distinct pr.employee_id) >= 5

	

	
	 
  	
	



	
	


	











	