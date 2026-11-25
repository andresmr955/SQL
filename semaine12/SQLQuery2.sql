CREATE DATABASE ExerciceIntersection;
GO

USE ExerciceIntersection;
GO

CREATE TABLE Auteurs (
    AuteurID INT PRIMARY KEY,
    Nom VARCHAR(50),
    Pays VARCHAR(50)
);

CREATE TABLE Livres (
    LivreID INT PRIMARY KEY,
    Titre VARCHAR(100),
    AuteurID INT,
    FOREIGN KEY (AuteurID)
        REFERENCES Auteurs(AuteurID)
);


INSERT INTO Auteurs (AuteurID, Nom, Pays)
VALUES
(1, 'Victor Hugo', 'France'),
(2, 'Gabriel Garcia Marquez', 'Colombie'),
(3, 'George Orwell', 'Angleterre'),
(4, 'Jules Verne', 'France'),
(5, 'Isabel Allende', 'Chili'),
(6, 'Paulo Coelho', 'Bresil');

INSERT INTO Livres (LivreID, Titre, AuteurID)
VALUES
(101, 'Les Miserables', 1),
(102, 'Notre-Dame de Paris', 1),
(103, 'Cent ans de solitude', 2),
(104, '1984', 3),
(105, 'La Ferme des animaux', 3),
(106, 'Le Tour du monde en 80 jours', 4);

-- Ejercicio 1. Mostrar el nombre de cada autor y el título de sus libros.
	

SELECT Auteurs.Nom, Livres.Titre
FROM Auteurs
INNER JOIN Livres
	ON Auteurs.AuteurID = Livres.AuteurID

-- Ejercicio 2. Mostrar todos los títulos de libros junto con el nombre de su autor.
SELECT Livres.Titre, Auteurs.Nom
FROM Livres
INNER JOIN Auteurs
	ON Livres.AuteurID = Auteurs.AuteurID

-- Ejercicio 3. Mostrar el nombre de los autores que tienen al menos un libro registrado.

SELECT Auteurs.Nom
FROM Auteurs
INNER JOIN Livres
	ON Auteurs.AuteurID = Livres.AuteurID
GROUP BY Auteurs.Nom
HAVING COUNT(Auteurs.Nom) > 1

-- Ejercicio 4. Mostrar el nombre del autor y el título de sus libros, 
-- únicamente para autores franceses.

SELECT Auteurs.Nom, Livres.Titre
FROM Auteurs
INNER JOIN Livres
	ON Auteurs.AuteurID = Livres.AuteurID
WHERE Auteurs.Pays = 'France'


-- Ejercicio 5. Mostrar el nombre del autor y el título de sus libros, 
--únicamente cuando el título sea 1984.

SELECT Auteurs.Nom,
		Livres.titre
FROM Auteurs
INNER JOIN Livres
	ON Auteurs.AuteurID = Livres.AuteurID
WHERE Livres.titre LIKE '%1984%'