CREATE DATABASE ExerciceInnerJoin;
GO

USE ExerciceInnerJoin;
GO

CREATE TABLE Departements (
    DepartementID INT PRIMARY KEY,
    NomDepartement VARCHAR(50),
    Ville VARCHAR(50)
);

CREATE TABLE Employes (
    EmployeID INT PRIMARY KEY,
    Nom VARCHAR(50),
    Poste VARCHAR(50),
    Salaire DECIMAL(10,2),
    DepartementID INT,
    FOREIGN KEY (DepartementID)
        REFERENCES Departements(DepartementID)
);


INSERT INTO Departements
(DepartementID, NomDepartement, Ville)
VALUES
(1, 'Informatique', 'Montreal'),
(2, 'Comptabilite', 'Laval'),
(3, 'Ressources humaines', 'Longueuil'),
(4, 'Marketing', 'Montreal');

INSERT INTO Employes
(EmployeID, Nom, Poste, Salaire, DepartementID)
VALUES
(1, 'Andres', 'Developpeur', 55000, 1),
(2, 'Sophie', 'Administratrice BD', 62000, 1),
(3, 'Marc', 'Comptable', 48000, 2),
(4, 'Julie', 'Recruteuse', 51000, 3),
(5, 'David', 'Designer', 53000, 4),
(6, 'Carlos', 'Technicien', 45000, 1);


SELECT * FROM Employes
SELECT * FROM Departements

SELECT Employes.Nom, Departements.NomDepartement 
FROM Employes 
INNER JOIN Departements 
	ON Employes.DepartementID = Departements.DepartementID


SELECT Employes.Nom, Employes.Poste, Departements.Ville
FROM Employes 
INNER JOIN Departements 
	ON Employes.DepartementID = Departements.DepartementID


SELECT Employes.Nom, Employes.Poste, Departements.Ville
FROM Employes 
INNER JOIN Departements 
	ON Employes.DepartementID = Departements.DepartementID
WHERE Departements.NomDepartement = 'Informatique'

SELECT Departements.NomDepartement, Employes.Nom
FROM Departements
INNER JOIN Employes
	ON Departements.DepartementID = Employes.DepartementID


CREATE TABLE Clients (
    ClientID INT PRIMARY KEY,
    Nom VARCHAR(50),
    Ville VARCHAR(50)
);

CREATE TABLE Commandes (
    CommandeID INT PRIMARY KEY,
    DateCommande DATE,
    Montant DECIMAL(10,2),
    ClientID INT,
	FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
   
);

INSERT INTO Clients (ClientID, Nom, Ville)
VALUES
(1, 'Andres', 'Montreal'),
(2, 'Sophie', 'Laval'),
(3, 'Marc', 'Longueuil'),
(4, 'Julie', 'Montreal'),
(5, 'David', 'Quebec');

INSERT INTO Commandes
(CommandeID, DateCommande, Montant, ClientID)
VALUES
(101, '2026-10-01', 150.00, 1),
(102, '2026-10-02', 250.00, 2),
(103, '2026-10-03', 89.99, 1),
(104, '2026-10-04', 450.00, 3),
(105, '2026-10-05', 120.00, 4),
(106, '2026-10-06', 300.00, 2),
(107, '2026-10-07', 75.00, 3);

-- Ejercicio 1. Mostrar el nombre de cada cliente y el número de su pedido (CommandeID).
SELECT Clients.Nom, Commandes.CommandeID
FROM Clients
INNER JOIN Commandes
	ON Clients.ClientID = Commandes.ClientID
ORDER BY Clients.Nom

-- Ejercicio 2. Mostrar el nombre del cliente, la fecha del pedido y su importe (Montant).
SELECT Clients.Nom, Commandes.DateCommande, Commandes.Montant
FROM Clients
INNER JOIN Commandes
	ON Clients.ClientID = Commandes.ClientID
ORDER BY Clients.Nom

-- Ejercicio 3. Mostrar el nombre de los clientes que realizaron pedidos superiores a 200 $.

SELECT Clients.Nom
FROM Clients
INNER JOIN Commandes
	ON Clients.ClientID = Commandes.ClientID
WHERE Montant > 200
ORDER BY Clients.Nom

-- Ejercicio 4. Mostrar todos los pedidos realizados por clientes que viven en Montreal.

SELECT Commandes.CommandeID, Clients.Ville
FROM Commandes
INNER JOIN Clients
	ON Commandes.ClientID = Clients.ClientID
WHERE Clients.Ville = 'Montreal'

-- Ejercicio 5. Mostrar el nombre del cliente y el importe de cada pedido, 
-- únicamente para los clientes cuyo nombre sea Sophie.

SELECT Clients.Nom, Commandes.Montant
FROM Clients
INNER JOIN Commandes
	ON Clients.ClientID = Commandes.ClientID
WHERE Clients.Nom = 'Sophie'