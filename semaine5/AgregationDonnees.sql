--DROP DATABASE IF EXISTS AgregationDonnes;
--CREATE DATABASE AgregationDonnes;
USE AgregationDonnes;
GO
DROP TABLE IF EXISTS eleves;

CREATE TABLE eleves (
    id INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    sexe char(1) CHECK(sexe IN ('F','M')),
    programme VARCHAR(100),
    noteExamen1 DECIMAL(5, 2),
    noteExamen2 DECIMAL(5, 2)
   
);

INSERT INTO eleves (id, nom, sexe, programme, noteExamen1, noteExamen2) 
VALUES 
    (1, 'Alice Dupont', 'F', 'Informatique', 66.5, 80.5),
    (2, 'Bob Martin', 'M', 'Génie électrique', 55.0, 73.0),
    (3, 'Claire Lemaire', 'F', 'Multimedia', 86.0, 78.5),
    (4, 'David Durand', 'M', 'Informatique', 92.0, 83.5),
    (5, 'Eva Lambert', 'F', 'Informatique', 68.5, 84.0),
    (6, 'Annie Leroy', 'F', 'Multimedia', 90.0, 87.5),
    (7, 'Valdislav Koval', 'M', 'Informatique', 84.5, 87.0),
    (8, 'Niko Petra', 'F', 'Informatique', 73.0, 71.0);
-- 1. Sélectionner tous les élèves et afficher leur nom et leur 
-- NoteFinale=(noteExamen1 + noteExamen2)/2, avec la NoteFinale arrondie à 
-- l'entier le plus proche.
SELECT CAST(4.88 AS INT 1)
SELECT nom, CAST(ROUND((noteExamen1 + noteExamen1)/2,0) AS INT)  NoteFinal FROM eleves;
SELECT * FROM eleves;

DECLARE @notemax DECIMAL(5,2)
SELECT @notemax= MAX((noteExamen1 + noteExamen2) /2) FROM eleves;
SELECT @notemax

SELECT * FROM eleves 
WHERE @notemax = CAST((noteExamen1 + noteExamen2) / 2 AS DECIMAL(5,2));

DECLARE @noteLimite decimal(5,2);
SET @noteLimite = 70
SELECT * 
FROM eleves
WHERE noteExamen1 > @noteLimite;
-- 6- Afficher les noms et moyenne des étudiants ayant eu
-- une note finale supérieure à la moyenne générale 

DECLARE @avgGeneral decimal (5,2);
--La media del salon de clases es:
SELECT AVG((noteExamen1 + noteExamen2) / 2.0) FROM eleves;

DECLARE @MoyenneGenerale DECIMAL(5,2);
SET @MoyenneGenerale = (SELECT AVG((noteExamen1 + noteExamen2) / 2.0) FROM eleves);
SELECT @MoyenneGenerale

SELECT nom, CAST(AVG((noteExamen1 + noteExamen2) / 2 )AS DECIMAL(5,2)) AS 'AVG Total' 
FROM eleves 
GROUP BY nom
HAVING AVG((noteExamen1 + noteExamen2) / 2.0) > @MoyenneGenerale 

--7- Afficher le nombre d'étudiants inscrits et la moyenne des notes
--finales de chaque programme 
SELECT 
programme, COUNT(*), AVG((noteExamen1 + noteExamen1) / 2.0) 'Note final'
FROM eleves
GROUP BY programme;
;
--8- Afficher les noms des programmes où la moyenne des notes finales 
-- des étudiants est inférieure à 75.
SELECT programme,
CAST(AVG((noteExamen1 + noteExamen2) / 2 )AS DECIMAL(5,2)) AS 'AVG Total'
FROM eleves
GROUP BY programme
HAVING AVG((noteExamen1 + noteExamen1) / 2.0) < 75;

-- 9- Afficher les noms des programmes où le nombre de femmes est inférieur à 2.
SELECT 
programme, count(*) AS 'NombreFemmes'
FROM eleves
WHERE sexe = 'F'
GROUP BY programme
HAVING count(*) < 2;

;