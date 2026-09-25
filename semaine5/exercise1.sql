USE AgregationDonnes;
GO

DROP TABLE IF EXISTS eleves;

CREATE TABLE eleves_exercise1 (
    id INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    sexe char(1) CHECK(sexe IN ('F','M')),
    programme VARCHAR(100),
    noteExamen1 DECIMAL(5, 2),
    noteExamen2 DECIMAL(5, 2)
   
);

INSERT INTO eleves_exercise1 (id, nom, sexe, programme, noteExamen1, noteExamen2) 
VALUES 
    (1, 'Alice Dupont', 'F', 'Informatique', 66.5, 80.5),
    (2, 'Bob Martin', 'M', 'Génie électrique', 55.0, 73.0),
    (3, 'Claire Lemaire', 'F', 'Multimedia', 86.0, 78.5),
    (4, 'David Durand', 'M', 'Informatique', 92.0, 83.5),
    (5, 'Eva Lambert', 'F', 'Informatique', 68.5, 84.0),
    (6, 'Annie Leroy', 'F', 'Multimedia', 90.0, 87.5),
    (7, 'Valdislav Koval', 'M', 'Informatique', 84.5, 87.0),
    (8, 'Niko Petra', 'F', 'Informatique', 73.0, 71.0);

-- 1- Sélectionner tous les élèves et afficher leur nom et leur NoteFinale=
-- (noteExamen1+ noteExamen2)/2, avec la NoteFinale arrondie à l'entier le plus proche.
SELECT * FROM eleves_exercise1;

SELECT nom, CAST(ROUND((noteExamen1 + noteExamen2) / 2, 2 )AS DECIMAL(5, 2)) AS NoteFinal
FROM eleves_exercise1

-- 2- Sélectionner tous les élèves et afficher leur nom en majuscules accompagné 
-- de leur NoteFinale .

SELECT UPPER(nom) as Nom,CAST(ROUND((noteExamen1 + noteExamen2) / 2, 2) AS DECIMAL(5, 2)) AS NoteFinal
FROM eleves_exercise1;

SELECT LOWER(LEFT(nom, 1)) + SUBSTRING(nom, 2, LEN(nom)), CAST(ROUND((noteExamen1 + noteExamen2) / 2, 2)AS DECIMAL(5,2)) AS NoteFinal
FROM eleves_exercise1;

-- 3- Afficher toutes les informations de l'élève ayant obtenu la note finale 
-- la plus élevée.

SELECT TOP 1 *, 
CAST(ROUND((noteExamen1 + noteExamen2) / 2, 2) AS DECIMAL(5, 2)) AS NoteFinal
FROM eleves_exercise1
ORDER BY NoteFinal DESC;

SELECT *,
CAST(ROUND((noteExamen1 + noteExamen2) / 2, 2) AS DECIMAL (5,2)) AS NoteFinal
FROM eleves_exercise1
WHERE CAST(ROUND((noteExamen1 + noteExamen2) / 2, 2) AS DECIMAL (5,2)) =
(
SELECT MAX((noteExamen1 + noteExamen2) / 2)
FROM eleves_exercise1
)

DECLARE @NoteMax DECIMAL(5,2);
SET @NoteMax = (SELECT MAX(CAST(ROUND((noteExamen1 + noteExamen2) / 2, 2) AS DECIMAL(5,2))) FROM eleves_exercise1)
SELECT @NoteMax

SELECT *,
CAST(ROUND((noteExamen1 + noteExamen2) / 2, 2) AS DECIMAL(5,2)) AS NoteFinal
FROM eleves_exercise1
WHERE CAST(ROUND((noteExamen)) DECIMAL (5,2))
--Puis je cree un variable avec un recherche pour ne pas repèter?


