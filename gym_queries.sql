----------------------------------------------------------------------------------------------------
--[select]
----------------------------------------------------------------------------------------------------
--Display the service ID, name, and status
select id, Name ,Status
from Service
--Display the Expired subscriptions
select *
from subscription s
where s.EndDate< GETDATE()
--Display the staff whose salary is greater than or equal to 9000
select s.Name,s.Position,s.Salary
from Staff s
where s.Salary >=9000
--Show services 
SELECT Name, Price
FROM Service
----------------------------------------------------------------------------------------------------
--[join functions]
----------------------------------------------------------------------------------------------------
--Display all services in each membership and the status of each service 
select m.Type as MemberShip_Type,s.Name as service_Name,s.Status as Service_Status
from MemberShip m,MemberShip_Service ms,Service s
where m.ID=ms.MemberShipID and s.ID=ms.ServiceID
order by m.ID,s.ID
--Display all service names, their status, and their sessions if they exist 
select s.Name as service_Name,s.Status as Service_Status,ses.Date ,ses.StartTime
from Service s left join Session ses
on s.ID=ses.ServiceID
order by s.ID,ses.Date,ses.StartTime
--View all members 
SELECT Name, BirthDate, Phone
FROM Member , Member_Phone
where ID=MemberID
--View sessions with service name and trainer--
SELECT S.ID, SV.Name AS ServiceName, ST.Name AS CoachName, S.Date, S.StartTime
FROM Session S ,Service SV ,Staff ST
where  S.ServiceID = SV.ID
and S.StaffID = ST.ID;
--View all sections and the number of devices in each
SELECT 
    D.Name AS DepartmentName,
    COUNT(E.ID) AS TotalEquipment
FROM Department D
LEFT JOIN Equipment E ON D.ID = E.DepartmentID
GROUP BY D.Name;
--Display the employee details along with their phone number
SELECT S.ID, S.Name, S.Position, S.Salary, SP.Phone
FROM Staff S
INNER JOIN Staff_Phone SP
ON S.ID = SP.StaffID;
--Display the number of sessions for each employee
SELECT S.Name, COUNT(SE.ID) TotalSessions
FROM Staff S
LEFT JOIN Session SE ON S.ID = SE.StaffID
GROUP BY S.Name;
----------------------------------------------------------------------------------------------------
--[Aggregate functions]
----------------------------------------------------------------------------------------------------
--Display the number of active subscriptions 
select count(*) as Active_Subscription
from subscription s
where GETDATE() < s.EndDate
--Display the number of staff with salary between 5000 and 9000 for each yea
select year(s.HireDate) as year,count(*) as Number_of_Staff
from Staff s
where s.Salary between 5000and 9000
group by year(s.HireDate)
--Average price of services , highest price and minimum price--
SELECT 
    AVG(Price) AS AvgPrice,
    MAX(Price) AS MaxPrice,
    MIN(Price) AS MinPrice
FROM Service;
--Number of sessions per trainer--
SELECT ST.Name, COUNT(S.ID) AS TotalSessions
FROM Staff ST
LEFT JOIN Session S ON ST.ID = S.StaffID
GROUP BY ST.Name;
--Number of sessions per service--
SELECT SV.Name, COUNT(S.ID) AS TotalSessions
FROM Service SV
LEFT JOIN Session S 
ON SV.ID = S.ServiceID
GROUP BY SV.Name;
--Count the number of members in the system
SELECT COUNT(*)  TotalMembers
FROM Member;
--Calculate the average salary of employees
SELECT AVG(Salary)  AvgSalary
FROM Staff;
