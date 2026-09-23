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
SELECT DISTINCT Departement FROM Employes;

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

SELECT DISTINCT Departement FROM Employes;