-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE `departments` (
    `dept_no` VARCHAR(4)  NOT NULL ,
    `dept_name` VARCHAR  NOT NULL ,
    PRIMARY KEY (
        `dept_no`
    )
);

CREATE TABLE `dept_emp` (
    `emp_no` BIGINT  NOT NULL ,
    `dept_no` VARCHAR(4)  NOT NULL ,
    PRIMARY KEY (
        `emp_no`
    )
);

CREATE TABLE `dept_manager` (
    `dept_no` VARCHAR(4)  NOT NULL ,
    `emp_no` BIGINT  NOT NULL ,
    PRIMARY KEY (
        `emp_no`
    )
);

CREATE TABLE `titles` (
    `title_id` VARCHAR(5)  NOT NULL ,
    `title` VARCHAR  NOT NULL ,
    PRIMARY KEY (
        `title_id`
    )
);

CREATE TABLE `employee` (
    `emp_no` BIGINT  NOT NULL ,
    `title_id` VARCHAR(5)  NOT NULL ,
    `birth_date` DATE  NOT NULL ,
    `first_name` VARCHAR  NOT NULL ,
    `last_name` VARCHAR  NOT NULL ,
    `sex` VARCHAR(1)  NOT NULL ,
    `hire_date` DATE  NOT NULL ,
    PRIMARY KEY (
        `emp_no`
    )
);

CREATE TABLE `salaries` (
    `emp_no` BIGINT  NOT NULL ,
    `salary` BIGINT  NOT NULL ,
    PRIMARY KEY (
        `emp_no`
    )
);

ALTER TABLE `dept_emp` ADD CONSTRAINT `fk_dept_emp_emp_no` FOREIGN KEY(`emp_no`)
REFERENCES `employee` (`emp_no`);

ALTER TABLE `dept_emp` ADD CONSTRAINT `fk_dept_emp_dept_no` FOREIGN KEY(`dept_no`)
REFERENCES `departments` (`dept_no`);

ALTER TABLE `dept_manager` ADD CONSTRAINT `fk_dept_manager_dept_no` FOREIGN KEY(`dept_no`)
REFERENCES `departments` (`dept_no`);

ALTER TABLE `dept_manager` ADD CONSTRAINT `fk_dept_manager_emp_no` FOREIGN KEY(`emp_no`)
REFERENCES `employee` (`emp_no`);

ALTER TABLE `employee` ADD CONSTRAINT `fk_employee_title_id` FOREIGN KEY(`title_id`)
REFERENCES `titles` (`title_id`);

ALTER TABLE `salaries` ADD CONSTRAINT `fk_salaries_emp_no` FOREIGN KEY(`emp_no`)
REFERENCES `employee` (`emp_no`);

