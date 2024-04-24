drop database TenCSDL;
-- Tạo cơ sở dữ liệu
CREATE DATABASE TenCSDL;

-- Sử dụng cơ sở dữ liệu
USE TenCSDL;

-- Tạo bảng Department
CREATE TABLE Department
(
    Id   INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    CHECK (LENGTH(Name) >= 6)
);

-- Tạo bảng Levels
CREATE TABLE Levels
(
    Id              INT AUTO_INCREMENT PRIMARY KEY,
    Name            VARCHAR(100) NOT NULL UNIQUE,
    BasicSalary     FLOAT        NOT NULL CHECK (BasicSalary >= 3500000),
    AllowanceSalary FLOAT DEFAULT 500000
);

-- Tạo bảng Employee
CREATE TABLE Employee
(
    Id           INT AUTO_INCREMENT PRIMARY KEY,
    Name         VARCHAR(150) NOT NULL,
    Email        VARCHAR(150) NOT NULL UNIQUE,
    CHECK (Email LIKE '%@%.%'), -- Kiểm tra định dạng email
    Phone        VARCHAR(50)  NOT NULL UNIQUE,
    Address      VARCHAR(255),
    Gender       TINYINT      NOT NULL CHECK (Gender IN (0, 1, 2)),
    BirthDay     DATE         NOT NULL,
    LevelId      INT          NOT NULL,
    DepartmentId INT          NOT NULL,
    FOREIGN KEY (LevelId) REFERENCES Levels (Id),
    FOREIGN KEY (DepartmentId) REFERENCES Department (Id)
);

CREATE TABLE TimeSheets
(
    Id             INT AUTO_INCREMENT PRIMARY KEY,
    AttendanceDate DATETIME       DEFAULT NOW(),
    EmployeeId     INT   NOT NULL,
    `Value`        FLOAT NOT NULL DEFAULT 1 CHECK (Value IN (0, 0.5, 1)),
    FOREIGN KEY (EmployeeId) REFERENCES Employee (Id)
);

-- Tạo bảng Salary
CREATE TABLE Salary
(
    Id          INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeId  INT   NOT NULL,
    BonusSalary FLOAT DEFAULT 0,
    Insurrance  FLOAT NOT NULL,
    FOREIGN KEY (EmployeeId) REFERENCES Employee (Id)
);
INSERT INTO Department (Name)
VALUES ('Department 1'),
       ('Department 2'),
       ('Department 3');
INSERT INTO Levels (Name, BasicSalary, AllowanceSalary)
VALUES ('Level 1', 4000000, 500000),
       ('Level 2', 4500000, 500000),
       ('Level 3', 5000000, 500000);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId)
VALUES ('Employee 1', 'employee1@example.com', '123456789', 'Address 1', 1, '2000-01-01', 1, 1),
       ('Employee 2', 'employee2@example.com', '987654321', 'Address 2', 0, '1995-05-10', 2, 1),
       ('Employee 3', 'employee3@example.com', '456789123', 'Address 3', 1, '1998-07-15', 1, 2),
       ('Employee 4', 'employee4@example.com', '111111111', 'Address 4', 1, '1993-03-25', 3, 1),
       ('Employee 5', 'employee5@example.com', '222222222', 'Address 5', 0, '1990-11-05', 2, 2),
       ('Employee 6', 'employee6@example.com', '333333333', 'Address 6', 1, '1997-09-12', 1, 3),
       ('Employee 7', 'employee7@example.com', '444444444', 'Address 7', 0, '1994-08-18', 2, 1),
       ('Employee 8', 'employee8@example.com', '555555555', 'Address 8', 1, '1991-06-27', 3, 2),
       ('Employee 9', 'employee9@example.com', '666666666', 'Address 9', 1, '1996-02-14', 1, 3),
       ('Employee 10', 'employee10@example.com', '777777777', 'Address 10', 0, '1989-10-22', 2, 1),
       ('Employee 11', 'employee11@example.com', '888888888', 'Address 11', 1, '1994-04-30', 3, 2),
       ('Employee 12', 'employee12@example.com', '999999999', 'Address 12', 0, '1992-03-08', 1, 3),
       ('Employee 13', 'employee13@example.com', '000000000', 'Address 13', 1, '1987-12-16', 2, 1),
       ('Employee 14', 'employee14@example.com', '121212121', 'Address 14', 0, '1993-07-24', 3, 2),
       ('Employee 15', 'employee15@example.com', '555555565', 'Address 15', 0, '1992-12-20', 3, 3);
INSERT INTO Timesheets (AttendanceDate, EmployeeId, Value)
VALUES ('2024-04-01', 1, 1),
       ('2024-04-02', 2, 0.5),
       ('2024-04-03', 3, 1),
       ('2024-04-04', 4, 0),
       ('2024-04-05', 5, 0.5),
       ('2024-04-06', 6, 1),
       ('2024-04-07', 7, 0.5),
       ('2024-04-08', 8, 0),
       ('2024-04-09', 9, 1),
       ('2024-04-10', 10, 0.5),
       ('2024-04-11', 11, 0),
       ('2024-04-12', 12, 1),
       ('2024-04-13', 13, 0.5),
       ('2024-04-14', 14, 0),
       ('2024-04-15', 15, 1),
       ('2024-04-16', 1, 0.5),
       ('2024-04-17', 2, 0),
       ('2024-04-18', 3, 1),
       ('2024-04-19', 4, 0.5),
       ('2024-04-20', 5, 0),
       ('2024-04-21', 6, 1),
       ('2024-04-22', 7, 0.5),
       ('2024-04-23', 8, 0),
       ('2024-04-24', 9, 1),
       ('2024-04-25', 10, 0.5),
       ('2024-04-26', 11, 0),
       ('2024-04-27', 12, 1),
       ('2024-04-28', 13, 0.5),
       ('2024-04-29', 14, 0),
       ('2024-04-30', 15, 1);
INSERT INTO Salary (EmployeeId, BonusSalary, Insurrance)
VALUES (1, 1000000, 400000),
       (2, 500000, 350000),
       (3, 800000, 450000);

alter table employee
    add index index_employee (Name);



# DROP PROCEDURE IF EXISTS getEmployeeCountByDepart;
# DELIMITER //
# CREATE PROCEDURE getEmployeeCountByDepart(IN in_depart VARCHAR(100), OUT out_depart VARCHAR(100), total INT)
# BEGIN
#     SELECT D.Name , COUNT(Employee.Id) INTO out_depart, total
#     FROM employee
#              JOIN Department D ON employee.DepartmentId = D.Id
#     WHERE D.Name = in_depart
#     group by D.Name ;
# END //
# DELIMITER ;
# CALL getEmployeeCountByDepart('Department 1',@out_depart,  @total);
# SELECT @out_depart, @total;

#1.1
select e.id,
       e.name,
       email,
       phone,
       address,
       gender,
       birthday,
       timestampdiff(year, BirthDay, curdate()),
       departmentid,
       L.Name
from employee e
         join Levels L on L.Id = e.LevelId
order by e.Name;
#1.2
select E.Id,
       E.Name,
       Email,
       Phone,
       BasicSalary,
       AllowanceSalary,
       BonusSalary,
       Insurrance,
       (BasicSalary + AllowanceSalary + BonusSalary - Insurrance) TotalSalary
from salary
         join Employee E on salary.EmployeeId = E.Id
         join Levels L on E.LevelId = L.Id;
#1.3
select Department.Id, Department.Name, count(E.Id) TotalEmployee
from department
         join Employee E on department.Id = E.DepartmentId
group by Department.Id;
#1.4

UPDATE Salary
SET BonusSalary = BonusSalary * 1.1
WHERE EmployeeId IN (SELECT EmployeeId
                     FROM TimeSheets
                     WHERE AttendanceDate >= '2024-04-01'
                       AND AttendanceDate <= '2024-04-30'
                     GROUP BY EmployeeId
                     HAVING COUNT(*) >= 2);
#1.5
delete
from department
where Id not in (select id
                 from (select distinct Department.Id
                       from department
                                join Employee E on department.Id = E.DepartmentId) as depNUll);

#2.1
drop view v_getEmployeeInfo;
create view v_getEmployeeInfo as
select Employee.Id,
       Employee.Name,
       email,
       phone,
       address,
       IF(Gender = 0, 'nu', 'nam'),
       birthday,
       D.Name as departmentName,
       L.Name as levelName
from employee
         join Levels L on L.Id = employee.LevelId
         join Department D on D.Id = employee.DepartmentId
order by Employee.Id;
select *
from v_getEmployeeInfo;
#2.2
drop view v_getEmployeeSalaryMax;
create view v_getEmployeeSalaryMax as
select Employee.Id,
       Employee.Name,
       Email,
       Phone,
       Address,
       Gender,
       BirthDay,
       month(AttendanceDate) month,
       sum(Value) as         TotalDay
from employee
         join TimeSheets TS on employee.Id = TS.EmployeeId
group by Employee.Id, month(AttendanceDate)
having count(EmployeeId) >= 2;
select *
from v_getEmployeeSalaryMax;
#3.1
delimiter //
create procedure addEmployeetInfo(Name_IN Varchar(150), Email_IN Varchar(150), Phone_IN Varchar(50),
                                  Address_IN Varchar(255), Gender_IN Tinyint, BirthDay_IN Date, LevelId_IN int,
                                  DepartmentId_IN int)
begin
    insert into Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) value (Name_IN,
                                                                                                       Email_IN,
                                                                                                       Phone_IN,
                                                                                                       Address_IN,
                                                                                                       Gender_IN,
                                                                                                       BirthDay_IN,
                                                                                                       LevelId_IN,
                                                                                                       DepartmentId_IN);
end //
delimiter ;
CALL addEmployeetInfo('John Doe', 'johndoe@example.com', '1234567890', '123 Main Street', 1, '1990-01-01', 1, 1);

#3.2
#Id, EmployeeName, Phone, Email, BaseSalary,  BasicSalary, AllowanceSalary, BonusSalary, Insurrance, TotalDay, TotalSalary
# (trong đó TotalDay là tổng số ngày công, TotalSalary là tổng số lương thực lãnh)
# Khi gọi thủ tục truyền vào id của nhân viên
drop procedure getSalaryByEmployeeId;
delimiter //
create procedure getSalaryByEmployeeId(ID_IN int)
begin
    select E.Id,
           E.Name,
           Email,
           Phone,
           BasicSalary,
           AllowanceSalary,
           BonusSalary,
           Insurrance,
          sum(Value) totalDay,
           (BasicSalary + AllowanceSalary + BonusSalary - Insurrance)* sum(Value)/24 TotalSalary
    from salary
             join Employee E on salary.EmployeeId = E.Id
             join Levels L on E.LevelId = L.Id
            join TimeSheets TS on E.Id = TS.EmployeeId
    where E.Id = ID_IN and month(curdate()) = month(AttendanceDate) and year(CURDATE()) = year(AttendanceDate)
    group by E.id , Salary.BonusSalary,Salary.Insurrance;
end ;
delimiter //
call getSalaryByEmployeeId(3);
#3.3: Thủ tục getEmployeePaginate lấy ra danh sách nhân viên có phân trang gồm: Id, Name, Email, Phone, Address, Gender, BirthDay,
# Khi gọi thủ tuc truyền vào limit và page
delimiter //
create procedure getEmployeePaginate(page int , size int)
begin
    declare off_set int ;
    set off_set = page*size;
    select Id, Name, Email,Phone, Address, Gender, BirthDay
    from employee limit off_set,size;
end ;
delimiter //

call getEmployeePaginate(0,3);
# trigger
# 1.	Tạo trigger tr_Check_ Insurrance_value sao cho khi thêm hoặc sửa trên
# bảng Salary nếu cột Insurrance có giá trị != 10% của BasicSalary thì không
# cho thêm mới hoặc chỉnh sửa và in thông báo ‘Giá trị cảu Insurrance phải = 10%
# của BasicSalary’
create trigger tr_Check_Insurrance_value_before_insert
    before insert
    on salary
    for each row
begin
    declare baseSalary float;
    select BasicSalary into baseSalary
    from levels l join  employee e on l.Id = e.levelId
    where e.Id = NEW.employeeId;
    if baseSalary*0.1 <> NEW.Insurrance then
        signal sqlstate '45000' set message_text = 'Giá trị của Insurance phải = 10% của BasicSalary';
    end if;
end ;

insert into salary(employeeId, BonusSalary, Insurrance) VALUE (1,1000000,10000);


# 2.	Tạo trigger tr_check_basic_salary khi thêm mới hoặc chỉnh sửa bảng Levels
# nếu giá trị cột BasicSalary > 10000000 thì tự động dưa về giá trị 10000000 và
# thông báo ‘Lương cơ bản không vượt quá 10 triệu’
create trigger tr_check_basic_salary
    before insert
    on levels
    for each row
begin
    if NEW.BasicSalary > 10000000
    then
        begin
            set NEW.BasicSalary = 10000000;
        end;
    end if;
end;










