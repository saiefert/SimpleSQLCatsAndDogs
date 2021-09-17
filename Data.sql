create database DataPets;

use DataPets;

/* script de criação das tabelas e relacionamentos. */

create table Owner(
	Id int IDENTITY(1,1) not null,
	Name varchar(300),
	CONSTRAINT PK_OwnerId PRIMARY KEY (Id)
);

SET IDENTITY_INSERT Owner OFF

create table Cats(
	Id int IDENTITY(1,1) not null PRIMARY KEY,
	Name varchar(300),
	Age int,
	OwnerId int not null,
	CONSTRAINT FK_Cats_OwnerId
	FOREIGN KEY (OwnerId)
	REFERENCES Owner (Id)
);


create table Dogs(
	Id int IDENTITY(1,1) not null PRIMARY KEY,
	Name varchar(300),
	Age int,
	OwnerId int not null,
	CONSTRAINT FK_Dogs_OwnerId
		FOREIGN KEY (OwnerId)
		REFERENCES Owner (Id)
);

/* scripts de inserção dos registros */

INSERT INTO Owner (Name)
VALUES 
	('Adam Smith'),
	('Scott Johnson'),
	('Kimberly Parker');

INSERT INTO Cats (Name, Age, OwnerId)
VALUES 
	('Lily',5,1),
	('Chloe',2,3),
	('Charlie',3,2);

INSERT INTO Dogs (Name, Age, OwnerId)
VALUES 
	('Maggie',1,2),
	('Duke',7,1),
	('Buddy',4,2);

/* query que seleciona apenas os nomes da tabela Cats que comecem com 'c', e os nomes da tabela Dogs que terminem com 'e'. */

SELECT *
FROM Cats
WHERE Name LIKE 'C%'
SELECT *
FROM Dogs
WHERE Name LIKE '%e'

/* Selecione o registro na tabela Dogs com menor Age  */
SELECT *
FROM Dogs
WHERE Age = (SELECT MIN(Age) FROM Dogs)

/* soma da coluna Age da tabela Cats */
SELECT SUM(Age) FROM Cats

/* nomes dos Owner e seus respectivos Cats */

SELECT o.Name AS OwnerName, c.Name AS CatName
FROM Owner o
JOIN Cats c
ON o.Id = c.OwnerId

/* registros da tabela Dogs com maior Age separados por OwnerId */

SELECT o.Id, o.Name AS OwnerName, d.Name AS CatName, d.Age
FROM Owner o
JOIN Dogs d
ON o.Id = d.OwnerId
ORDER BY Age DESC

/* nome do Owner e a respectiva quantidade de animais total */

SELECT Name,
Total = (SELECT COUNT(*) FROM Cats c WHERE o.Id = c.OwnerId)
	+ (SELECT COUNT(*) FROM Dogs d WHERE o.Id = d.OwnerId)
FROM Owner o
