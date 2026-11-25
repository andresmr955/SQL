--- Suppression des tables si elles existent déjà
DROP TABLE IF EXISTS TravailleSur;
--GO
DROP TABLE IF EXISTS Employe;
--GO
DROP TABLE IF EXISTS Projet;
--GO
DROP TABLE IF EXISTS  Departement;
GO
SELECT * FROM TravailleSur
SELECT * FROM Employe
SELECT * FROM Projet
SELECT * FROM Departement

-- Création de la table Departement
CREATE TABLE Departement (
    departementID INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

-- Création de la table Employe
-- gestionnaireID : clé étrangère auto-référente (le gestionnaire est lui-même un employé)
CREATE TABLE Employe (
    employeID INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100),
    departementID INT,
    gestionnaireID INT,
    FOREIGN KEY (departementID) REFERENCES Departement(departementID),
    FOREIGN KEY (gestionnaireID) REFERENCES Employe(employeID)
);

-- Création de la table Projet
CREATE TABLE Projet (
    projetID INT PRIMARY KEY,
    nomProjet VARCHAR(100) NOT NULL,
    description VARCHAR(1000)
);

-- Création de la table TravailleSur
CREATE TABLE TravailleSur (
    employeID INT,
    projetID INT,
    role VARCHAR(100),
    PRIMARY KEY (employeID, projetID),
    FOREIGN KEY (employeID) REFERENCES Employe(employeID),
    FOREIGN KEY (projetID) REFERENCES Projet(projetID)
);

-- Insertion de données dans Departement
INSERT INTO Departement (departementID, nom) VALUES
(1, 'Informatique'),
(2, 'Ressources Humaines'),
(3, 'Marketing'),
(4, 'Finance');

-- Insertion de données dans Employe (les gestionnaires d'abord)
INSERT INTO Employe (employeID, nom, prenom, departementID, gestionnaireID) VALUES
(1, 'Dupont', 'Jean', 1, NULL),
(2, 'Martin', 'Alice', 2, NULL),
(3, 'Lefebvre', 'Marie', 1, 1),
(4, 'Bernard', 'Luc', 3, 2),
(5, 'Girard', 'Sophie', 1, 3),
(6, 'Roy', 'Karim', NULL, 2);

-- Insertion de données dans Projet
INSERT INTO Projet (projetID, nomProjet, description) VALUES
(1, 'Projet Alpha', 'Description du Projet Alpha'),
(2, 'Projet Beta', 'Description du Projet Beta'),
(3, 'Projet Gamma', 'Description du Projet Gamma'),
(4, 'Projet Delta', 'Description du Projet Delta');

-- Insertion de données dans TravailleSur
INSERT INTO TravailleSur (employeID, projetID, role) VALUES
(1, 1, 'Chef de projet'),
(2, 2, 'Analyste'),
(3, 1, 'Développeur'),
(3, 2, 'Développeur'),
(3, 3, 'Développeur'),
(5, 3, 'Testeur');

-- Notes sur les données :
-- Le département 4 (Finance) n'a aucun employé.
-- L'employé 6 (Karim Roy) n'a pas de département.
-- Les employés 4 et 6 ne sont associés à aucun projet.
-- Le projet 4 (Projet Delta) n'a aucun employé.
-- Jean Dupont et Alice Martin n'ont pas de gestionnaire (gestionnaireID NULL).

-- Employés et départements (alias, tri)
-- Afficher le prénom, le nom et le nom du département de chaque employé, 
-- triés par département puis par nom. Utilisez des alias de table. 
-- Pourquoi Karim Roy n'apparaît-il pas dans le résultat ?
-- Parce que Karim n'a pas DepartementID
SELECT E.prenom as prenomEmployee, E.nom as nomEmploye, D.nom as NomDepartament
FROM Employe E 
INNER JOIN Departement D
	ON E.departementID = D.departementID
ORDER BY NomDepartament, nomEmploye

-- Nombre d'employés par département
-- Pour chaque département, afficher son nom et son nombre d'employés. 
-- Le département Finance, qui n'a aucun employé, doit afficher 0. 
-- Attention : COUNT(*) compte aussi une ligne remplie de NULL.

SELECT D.nom, COUNT(E.nom) AS NbEmployees 
FROM Departement D
LEFT JOIN Employe E
	ON D.departementID = E.departementID
GROUP BY D.nom

-- Projets sans employés
-- Trouver les projets auxquels aucun employé n'est assigné.

SELECT P.nomProjet, E.nom
FROM Projet P
LEFT JOIN TravailleSur TS
	ON P.projetID = TS.employeID
LEFT JOIN Employe E
	ON TS.employeID = E.employeID
WHERE E.nom IS NULL
