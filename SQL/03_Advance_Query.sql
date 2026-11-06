select * from attendance;
select * from departments;
select * from salaries;
select * from employees;
select * from performance_reviews;


-- Q.21  Find the highest-paid employee in every department.
with ranked as(
select
	d.department_name,
	concat(e.first_name , ' ', e.last_name) as emp_name,
	s.salary ,
	dense_rank() over(partition by d.department_name order by s.salary desc)
	as salary_rank
from 
	departments d 
join 
	employees e on d.department_id = e.department_id
join 
	salaries s on e.employee_id = s.employee_id
where s.effective_to is null	
)

select 
	department_name,
	emp_name,
	salary,
	salary_rank
from 
	ranked
where salary_rank = 1;
	

-- Q.22 Rank employees by current salary within their department.
select 
	concat(e.first_name , ' ', e.last_name) as emp_name,
	d.department_name,
	s.salary,
	dense_rank() over(partition by d.department_name order by salary desc)
	as salary_rank
from 
	departments d 
join 
	employees e on d.department_id = e.department_id
join
	salaries s on e.employee_id = s.employee_id
where s.effective_to is null 
order by 
	d.department_name;


	

-- Q.23 Find the highest-rated employee in every department
with top_performers as(
select
	concat(e.first_name , ' ', e.last_name) as emp_name,
	d.department_name ,
	round(avg(pr.rating),2) as avg_rating,
	dense_rank() over(partition by d.department_name 
	order by avg(pr.rating) desc) as top_performer_of_depth
from 
	departments d
join 
	employees e on d.department_id = e.department_id
join 
	performance_reviews pr on e.employee_id = pr.employee_id
group by
	d.department_name,
	e.first_name,
	e.last_name
	
)

select
	emp_name,
	department_name,
	avg_rating
	
from 
    top_performers
where 
	top_performer_of_depth = 1;


	
-- Q.24  Calculate Employee Salary Growth and Growth Percentage

with cte as (
	select 
	    employee_id ,
		salary,
		effective_from,
		row_number() over(partition by employee_id order by effective_from ) as first_rank,
		row_number() over(partition by employee_id order by effective_from desc) as last_rank
	from 
		salaries 
		
)


select 
     employee_id,
	 max(salary) filter(where first_rank = 1) as initial_salary,
	 max(salary) filter(where last_rank = 1) as current_salary,
	 max(salary) filter(where last_rank = 1) - max(salary) filter(where first_rank = 1)
	 as salary_increase,
	 round((max(salary) filter(where last_rank = 1) - max(salary) filter(where first_rank = 1))
	 *100.0/nullif(max(salary) filter(where first_rank = 1),0),2) as salary_growth_perc 
from
	cte
group by 
	employee_id;
	
	


-- Q.25 Month-over-Month Hiring Trend
with monthly_hire as(
select
	date_trunc('month', hire_date)::date as months,
	count(employee_id) as new_hire
from 
	employees 
group by 
	 date_trunc('month', hire_date)
	

)
select 
	months,
	new_hire,
	lag(new_hire,1)over(order by months) as previous_month_hire,
	round((new_hire - lag(new_hire,1)over(order by months))*100.0/
	nullif(lag(new_hire,1)over(order by months),0),2) as growth_percent
from 
	monthly_hire
order by 
	months
;



-- Q.26 Employee Performance vs Attendance
with performance_score as(
	select
	    employee_id,
		round(avg(rating),2) as avg_rating
	from 
		performance_reviews
	group by 
		employee_id
),

attendance_score as (
	select 
	    employee_id,
		round(count(status) filter (where status= 'Present')*100.0 / nullif(count(status),0),2)
		as attendance_rate
	from
		attendance
	group by
		employee_id
	
)

select 
    p.employee_id,
    concat(e.first_name , ' ', e.last_name) as emp_name,
    p.avg_rating,
	a.attendance_rate
from 
	performance_score p
join
	attendance_score a on p.employee_id = a.employee_id
join 
	employees e on p.employee_id = e.employee_id
where
	p.avg_rating > 4.0 and a.attendance_rate > 90
order by 
	a.attendance_rate desc,
	p.avg_rating desc;


	


-- Q.27 Department Salary Distribution
select 
    d.department_name,
	sum(s.salary) as total_salary_cost,
	round(avg(s.salary),2) as avg_salary,
	max(s.salary) as highest_salary,
	min(s.salary) as lowest_salary,
	(max(s.salary) - min(s.salary)) as salary_difference,
	round(sum(s.salary)*100.0 /(select
	         sum(salary) from salaries
	      where
	         effective_to is null),2)
	as department_share	
from	
	salaries  s
join 
	employees e on e.employee_id = s.employee_id
join 
	departments d on d.department_id = e.department_id 
where
	effective_to is null
group by 
	d.department_name;


	
	
-- Q.28 Employees Above Department Average + High Performance
with performance_score as(
	select
	    employee_id,
		round(avg(rating),2) as avg_rating
	from 
		performance_reviews
	group by 
		employee_id
),

attendance_score as (
	select 
	    employee_id,
		round(count(status) filter (where status= 'Present')*100.0 / nullif(count(status),0),2)
		as attendance_rate
	from
		attendance
	group by
		employee_id
	
)
,
depth_salary_score as(
	select 
	    d.department_id,
		d.department_name,
		round(avg(s.salary),2) as avg_depth_salary
	from 
		employees e
	join 
		departments d on e.department_id = d.department_id
	join 
		salaries s on e.employee_id = s.employee_id
	where 
		effective_to is null
	group by
	    d.department_id,
		d.department_name
	
),
emp_salary_score as(
	select 
		employee_id,
		salary
	from
		salaries
	where 
		effective_to is null
	
	)

select 
    p.employee_id,
    concat(e.first_name , ' ', e.last_name) as emp_name,
	ds.department_name,
	ds.avg_depth_salary,
    p.avg_rating,
	a.attendance_rate,
	es.salary
from 
	performance_score p
join
	attendance_score a on p.employee_id = a.employee_id
join 
	employees e on p.employee_id = e.employee_id
join 
	depth_salary_score ds on e.department_id = ds.department_id
join 
	emp_salary_score es on e.employee_id = es.employee_id
	
where
	p.avg_rating > 4.0 and a.attendance_rate >90 and es.salary > ds.avg_depth_salary
order by 
	a.attendance_rate desc,
	p.avg_rating desc;


	

-- Q.29 Employee Retention Analysis
select
    d.department_name,
	count(e.employee_id) as total_employees,
	count(e.employee_id) filter(where e.employment_status = 'Active') as active_employees,
	count(e.employee_id) filter(where e.employment_status = 'Inactive') as inactive_employees,
    round(
	      coalesce(count(e.employee_id) filter(where e.employment_status = 'Active')*100.0 
	      / nullIf(count(e.employee_id),0),0),2) as retention_rate
	
from employees e
join
	departments d on e.department_id = d.department_id
group by
	d.department_name
order by
	retention_rate desc;



-- Q.30  Rank Employees Using a Salary, Performance, and Attendance Score

with salary_rank as(
select 
   employee_id,
   salary 
from 
	salaries
where effective_to is null
),

performance_rank as (
	select 
	    employee_id,
		round(avg(rating),2) as performance
	from 
		performance_reviews
	group by
		employee_id
),

attendance_rank as(
	select
	    employee_id ,
		round(count(status)filter(where status='Present')*100.0 /nullif(count(status),0),2)
		as attendance
	from 
		attendance 
	group by employee_id
),

employee_ranks as (
	select 
		s.employee_id,
		dense_rank() over(order by s.salary desc NULLS LAST) as salary_rank,
		dense_rank() over(order by a.attendance desc NULLS LAST) as attendance_rank,
		dense_rank() over(order by p.performance desc NULLS LAST) as performance_rank
	from 
		salary_rank s
	left join
		performance_rank p on s.employee_id = p.employee_id
	left join
		attendance_rank a on s.employee_id = a.employee_id	

),
 composite_ranks as(
select
    employee_id,
	salary_rank,
	performance_rank,
	attendance_rank,
	salary_rank + attendance_rank+ performance_rank as composite_score
from 
	employee_ranks
)

select 
    employee_id,
	salary_rank,
	performance_rank,
	attendance_rank,
	dense_rank() over(order by composite_score ASC) as composite_rank
from 
	composite_ranks
	
