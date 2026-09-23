-- Table unique pour tous les exemples de tri
CREATE DATABASE PRESENTATIONDONNEES;
USE PRESENTATIONDONNEES;
GO;
DROP TABLE IF EXISTS Employes;
GO
CREATE TABLE Employes (
    EmployeID INT PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Poste VARCHAR(50),
    Salaire DECIMAL(10,2),
    Departement VARCHAR(30),
    DateEmbauche DATE
);

INSERT INTO Employes VALUES
(1, 'Martin', 'Jean', 'Développeur', 65000, 'Informatique', '2022-03-15'),
(2, 'Gagnon', 'Marie', 'Analyste', 58000, 'Informatique', '2021-09-01'),
(3, 'Roy', 'Pierre', 'Chef de projet', 75000, 'Informatique', '2020-01-10'),
(4, 'Tremblay', 'Sophie', 'Designer', 52000, 'Marketing', '2023-05-20'),
(5, 'Leblanc', 'Marc', 'Comptable', 48000, 'Finance', '2019-11-30'),
(6, 'Dubois', 'Julie', 'Directrice', 95000, 'Direction', '2018-04-12');

SELECT * FROM Employes;
-- Renommer une colonne simple
SELECT Nom 'Nom de famille' FROM Employes;
-- Plusieurs alias
SELECT Nom 'Nom de famille', 
	   Prenom 'Votre Prenom',
	   Poste AS "Votre Poste",
	   Departement AS [Votre departement]
FROM Employes;

--Alias pour des calculs et concaténations
SELECT nom + ' '+  Prenom AS [Nom Complet], Salaire * 12 "Salaire Annuel" FROM Employes;

--ORDER BY permet de trier les résultats selon une ou plusieurs colonnes.

SELECT * FROM Employes ORDER BY Nom;
SELECT * FROM Employes ORDER BY salaire DESC;
SELECT * FROM Employes ORDER BY DateEmbauche;

SELECT * FROM Employes ORDER BY Departement ASC, Salaire DESC;
SELECT * FROM Employes ORDER BY Poste, DateEmbauche DESC;
SELECT Nom AS 'x nom' FROM Employes ORDER BY [x nom];

--DISTINCT élimine les lignes en double des résultats.

SELECT * FROM Employes;
SELECT DISTINCT Departement, * FROM Employes;
SELECT DISTINCT Departement FROM Employes ORDER BY Departement;

INSERT INTO Employes VALUES
(7, 'Andres', 'Marquez', 'Développeur', 80000 ,'Informatique', '2018-08-12'),
(8, 'Melodie', 'Bareno', 'Analyste', 100000, 'Marketing', '2022-04-12');

SELECT * FROM Employes;

UPDATE Employes
SET Nom = 'Marquez',
	Prenom = 'Andres'
WHERE EmployeId = 7;
SELECT * FROM Employes;

UPDATE Employes
SET Nom = 'Benavides',
	Prenom = 'Melodie'
WHERE EmployeId = 8;
SELECT * FROM Employes;
--DISTINCT sur plusieurs colonnes
DROP TABLE IF EXISTS Employes2;
go
CREATE TABLE Employes2 (
    EmployeID INT PRIMARY KEY,
    Nom VARCHAR(50),
    Departement VARCHAR(30),
    Poste VARCHAR(50)
);

INSERT INTO Employes2 VALUES
(1, 'Martin', 'Informatique', 'Développeur'),
(2, 'Gagnon', 'Informatique', 'Analyste'),
(3, 'Roy', 'Informatique', 'Développeur'),
(4, 'Tremblay', 'Marketing', 'Designer'),
(5, 'Leblanc', 'Marketing', 'Designer');

-- Lister toutes les combinaisons département-poste
SELECT * FROM Employes2;
SELECT DISTINCT Departement, Poste FROM Employes2;

--DISTINCT avec ORDER BY

DROP TABLE IF EXISTS Employes;
GO
CREATE TABLE Employes3 (
    EmployeID INT PRIMARY KEY,
    Nom VARCHAR(50),
    Departement VARCHAR(30),
    Poste VARCHAR(50),
    ville VARCHAR(50)
);

INSERT INTO Employes3 VALUES
(1, 'Martin', 'Informatique', 'Développeur','Montréal'),
(2, 'Gagnon', 'Informatique', 'Analyste','Montréal'),
(3, 'Roy', 'Informatique', 'Chef de projet','Québec'),
(4, 'Tremblay', 'Marketing', 'Designer','Sherbrooke'),
(5, 'Leblanc', 'Finance', 'Comptable','Québec'),
(6, 'Dubois', 'Marketing', 'Designer','Trois-Rivières');

-- Départements triés alphabétiquement

SELECT * FROM Employes3;
SELECT DISTINCT Departement FROM Employes3 ORDER BY Departement;

--DISTINCT avec WHERE
-- Table pour DISTINCT avec WHERE
DROP TABLE IF EXISTS Commande;
GO
CREATE TABLE Commande (
    CommandeID INT PRIMARY KEY,
    Client VARCHAR(100),
    Produit VARCHAR(100)
);

INSERT INTO Commande VALUES
(1, 'Alice Bonnet', 'Casque Bluetooth'),
(2, 'Bob Martin', 'Camera GoPro'),
(3, 'Alain Dupont', 'Enceinte Bluetooth'),
(4, 'Diane Caron', 'Montre connectée'),
(5, 'Alice Bonnet', 'Casque Bluetooth'),
(6, 'Bob Martin', 'Enceinte Bluetooth');

-- Clients ayant commandé des produits Bluetooth
SELECT * FROM Commande;
SELECT Client FROM Commande WHERE Produit LIKE '%Bluetooth%'
SELECT DISTINCT Client FROM Commande WHERE Produit LIKE '%Bluetooth%'
SELECT * FROM Commande;

SELECT DISTINCT Client
FROM Commande
ORDER BY Client;

--TOP limite le nombre de lignes retournées par la requête.

DROP TABLE IF EXISTS Employes4;
GO
CREATE TABLE Employes4 (
    EmployeID INT PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Salaire DECIMAL(10,2),
    DateEmbauche DATE
);

INSERT INTO Employes4 VALUES
(1, 'Martin', 'Jean', 65000, '2022-03-15'),
(2, 'Gagnon', 'Marie', 58000, '2021-09-01'),
(3, 'Roy', 'Pierre', 75000, '2020-01-10'),
(4, 'Tremblay', 'Sophie', 52000, '2023-05-20'),
(5, 'Leblanc', 'Marc', 48000, '2019-11-30'),
(6, 'Dubois', 'Julie', 95000, '2018-04-12'),
(7, 'Lavoie', 'Paul', 62000, '2021-06-10'),
(8, 'Moreau', 'Anne', 71000, '2022-08-25'),
(9, 'Girard', 'Luc', 54000, '2023-01-15'),
(10, 'Caron', 'Sylvie', 67000, '2020-12-08');

-- Les 3 premiers employés (ordre arbitraire)
SELECT * FROM Employes4;
SELECT TOP 3 * FROM Employes4;
-- La moitié de la table
SELECT TOP 50 PERCENT * FROM Employes4;

--TOP avec ORDER BY (Important)
DROP TABLE IF EXISTS Employes;
GO
CREATE TABLE Employes5 (
    EmployeID INT PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Salaire DECIMAL(10,2),
    DateEmbauche DATE
);

INSERT INTO Employes5 VALUES
(1, 'Martin', 'Jean', 65000, '2022-03-15'),
(2, 'Gagnon', 'Marie', 58000, '2021-09-01'),
(3, 'Roy', 'Pierre', 75000, '2020-01-10'),
(4, 'Tremblay', 'Sophie', 52000, '2023-05-20'),
(5, 'Leblanc', 'Marc', 48000, '2019-11-30'),
(6, 'Dubois', 'Julie', 95000, '2018-04-12'),
(7, 'Lavoie', 'Paul', 62000, '2021-06-10'),
(8, 'Moreau', 'Anne', 71000, '2022-08-25'),
(9, 'Girard', 'Luc', 54000, '2023-01-15'),
(10, 'Caron', 'Sylvie', 67000, '2020-12-08');


-- Les 3 employés les mieux payés
SELECT * FROM Employes5
SELECT * FROM Employes5 ORDER BY Salaire DESC;

SELECT TOP 3 * FROM Employes5 ORDER BY Salaire DESC;
-- Les 5 employés embauchés le plus récemment
SELECT TOP 5 * FROM Employes5 ORDER BY DateEmbauche DESC;
SELECT * FROM Employes5
-- Les 20% des employés les mieux payés
SELECT * FROM Employes5 ORDER BY Salaire DESC; 
SELECT TOP 20 PERCENT * FROM Employes5 ORDER BY Salaire DESC; 
-- Égalités : WITH TIES
INSERT INTO Employes5 VALUES (11, 'Bouchard', 'Lise', 71000, '2024-02-01');
SELECT TOP 3 WITH TIES Nom, Salaire FROM Employes5 ORDER BY Salaire DESC; 

--- EXAMPLE COMPLET

-- Table complète pour exemple avancé
DROP TABLE IF EXISTS Commande;
GO
CREATE TABLE Commande1 (
    CommandeID INT PRIMARY KEY,
    Client VARCHAR(100),
    Produit VARCHAR(100),
    Qte INT,
    Prix_U DECIMAL(10,2),
    DateCommande DATE
);

INSERT INTO Commande1 VALUES
(1, 'Alice Bonnet', 'Table Vision 8', 2, 179.99, '2024-01-15'),
(2, 'Bob Martin', 'Camera GoPro', 1, 300.99, '2024-01-20'),
(3, 'Alain Dupont', 'Montre connectée', 3, 69.99, '2024-01-22'),
(4, 'Diane Caron', 'Enceinte Bluetooth', 2, 129.99, '2024-01-25'),
(5, 'Joanne Leroy', 'Casque Premium', 1, 450.99, '2024-01-28'),
(6, 'Paul Martin', 'Tablette Pro', 1, 599.99, '2024-01-30'),
(7, 'Marie Claire', 'Smartphone', 2, 899.99, '2024-02-02');

SELECT  * FROM Commande1;
SELECT  TOP 5
		Client AS 'Nom du client',
		Produit AS 'Produit acheté',
		Qte AS 'Quantité',
		Prix_U AS 'Prix unitaire ($)',
		Prix_U * Qte AS 'Total ($)'
FROM Commande1
WHERE DateCommande >= '2024-01-01'
ORDER BY Prix_U * Qte DESC;

--Exemple 2: Analyse des départements

DROP TABLE IF EXISTS Employes6;
GO
CREATE TABLE Employes6 (
    EmployeID INT PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Departement VARCHAR(30)
);

INSERT INTO Employes6 VALUES
(1, 'Martin', 'Jean', 'Informatique'),
(2, 'Gagnon', 'Marie', 'Informatique'),
(3, 'Roy', 'Pierre', 'Informatique'),
(4, 'Tremblay', 'Sophie', 'Marketing'),
(5, 'Leblanc', 'Marc', 'Finance'),
(6, 'Dubois', 'Julie', 'Marketing');

SELECT * FROM Employes6;
SELECT 
	Departement AS "Departement",
	COUNT(*) AS "Nombre d'employees"
FROM Employes6
GROUP BY Departement
ORDER BY COUNT(*) DESC;

-- Exemple 3: TOP clients
-- Table pour exemple top clients
DROP TABLE IF EXISTS Commande2;
GO
CREATE TABLE Commande2 (
    CommandeID INT PRIMARY KEY,
    Client VARCHAR(100),
    Produit VARCHAR(100),
    Prix_U DECIMAL(10,2)
);

INSERT INTO Commande2 VALUES
(1, 'Alice Bonnet', 'Table Vision 8', 179.99),
(2, 'Bob Martin', 'Camera GoPro', 300.99),
(3, 'Diane Caron', 'Montre Premium', 450.99),
(4, 'Paul Durand', 'Laptop Pro', 1299.99),
(5, 'Marie Claire', 'Smartphone', 899.99),
(6, 'Jean Leblanc', 'Casque Audio', 150.99);

-- Les 3 clients ayant passé les commandes les plus chères (plus de 200 $)
SELECT * FROM Commande2;
SELECT TOP 3 WITH TIES  
	Client AS "Meilleurs clients",
    Prix_U AS "Prix ($)"
FROM Commande2
WHERE Prix_U > 200
ORDER BY Client DESC

UPDATE Commande2
SET Prix_U = 450.99
WHERE CommandeID = 4

UPDATE Commande2
SET Prix_U = 1299.99
WHERE CommandeID = 3