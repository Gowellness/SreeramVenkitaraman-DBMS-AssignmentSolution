Create table if not exists PASSENGER(Passenger_name varchar(50) PRIMARY KEY,Category varchar(50) NOT NULL,Gender varchar(50) NOT NULL,Boarding_City varchar(50) NOT NULL,Destination_City varchar(50) NOT NULL,Distance int(10) NOT NULL,Bus_Type varchar(50) NOT NULL);
insert into PASSENGER values("Sejal","AC", "F", "Bengaluru","Chennai",350,"Sleeper"); 
insert into PASSENGER values("Anmol","Non-AC", "M", "Mumbai","Hyderabad",700,"Sitting"); 
insert into PASSENGER values("Pallavi","AC", "F", "Panaji","Bengaluru",600,"Sleeper"); 
insert into PASSENGER values("Khusboo","AC", "F", "Chennai","Mumbai",1500,"Sleeper"); 
insert into PASSENGER values("Udit","Non-AC", "M", "Trivandrum","Panaji",1000,"Sleeper"); 
insert into PASSENGER values("Ankur","AC", "M", "Nagpur","Hyderabad",500,"Sitting"); 
insert into PASSENGER values("Hemant","Non-AC", "M", "Panaji","Mumbai",700,"Sleeper"); 
insert into PASSENGER values("Manish","Non-AC", "M", "Hyderabad","Bengaluru",500,"Sitting"); 
insert into PASSENGER values("Piyush","AC", "M", "Pune","Nagpur",700,"Sitting"); 
select * from PASSENGER;

CREATE TABLE PRICE (
  Bus_Type VARCHAR(50) NULL,
  Distance int(10) NOT NULL,
  Price int(10));
INSERT into PRICE values("Sleeper",350,770);
INSERT into PRICE values("Sleeper",500,1100);
INSERT into PRICE values("Sleeper",600,1320);
INSERT into PRICE values("Sleeper",700,1540);
INSERT into PRICE values("Sleeper",1000,2200);
INSERT into PRICE values("Sleeper",1200,2640);
INSERT into PRICE values("Sleeper",1500,2700);
INSERT into PRICE values("Sitting",500,620);
INSERT into PRICE values("Sitting",600,744);
INSERT into PRICE values("Sitting",700,868);
INSERT into PRICE values("Sitting",1000,1240);
INSERT into PRICE values("Sitting",1200,1488);
INSERT into PRICE values("Sitting",1500,1860);
select * from PRICE;

/3/How many females and how many male passengers travelled for a minimum distance of 600 KM s?

select Gender,count(Passenger_name) as count from PASSENGER where Distance >=600 group by Gender;

/4/Find the minimum ticket price for Sleeper Bus

select min(Price) from PRICE where Bus_Type="Sleeper";

/5/Select passenger names whose names start with character 'S'

select * from PASSENGER where Passenger_name like 'S%';

/6/Calculate price charged for each passenger displaying Passenger name, Boarding City,Destination City, Bus_Type, Price in the output

SELECT pa.Passenger_Name, pa.Boarding_City, pa.Destination_City, pa.Bus_Type, pr.Price 
FROM PASSENGER pa LEFT JOIN PRICE pr ON pa.Bus_Type = pr.Bus_Type 
WHERE pa.Distance = pr.Distance;

/7/What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KM s

SELECT Passenger_name,Distance,Price
FROM PASSENGER JOIN PRICE ON (PASSENGER.Bus_Type = PRICE.Bus_Type AND PASSENGER.Distance = PRICE.Distance)
WHERE PASSENGER.Distance = 1000 AND PRICE.Bus_Type = "Sitting";

/8/What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?

SELECT pa.Passenger_Name, pr.Bus_Type, pr.Price
FROM PASSENGER pa INNER JOIN PRICE pr ON pa.Distance = pr.Distance AND pa.Bus_Type = pr.Bus_Type
WHERE pa.Passenger_Name = 'Pallavi' AND pa.Bus_Type IN ('Sleeper', 'Sitting');

/9/List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order. Not showing 2 values - 500 and 700 because it is appearing more than once

SELECT Distance 
FROM PASSENGER 
GROUP BY Distance 
HAVING COUNT(Distance) = 1 
ORDER BY Distance DESC;

/10/Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables

SELECT Passenger_Name, FLOOR(( Distance / TotalDistance ) * 100) AS PercentageOfDistance
FROM PASSENGER 
INNER JOIN (SELECT SUM(Distance) AS TotalDistance FROM PASSENGER) AS TOTAL;

/11/Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500

SELECT Distance, Price,
CASE
WHEN Price >= 1000 THEN 'Expensive'
WHEN Price BETWEEN 500 AND 1000 THEN 'Average Cost'
ELSE 'Cheap' END AS Category
FROM PRICE;