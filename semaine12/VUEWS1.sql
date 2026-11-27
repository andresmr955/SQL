-- =====================================================================
-- Cours 9 : Les vues. Script de données commun aux exercices 1 à 4
-- Base : gestionScolaire
--
-- Ce script est RÉEXÉCUTABLE : il supprime les vues et les tables du
-- cours 9, puis les recrée avec les données de départ. Relancez-le si
-- vos tests ont modifié les données.
--
-- Sur SQL Server (SSMS), la première fois seulement : décommentez les
-- 4 lignes suivantes. Travaillez dans une base à part : des tables Cours
-- ou Inscriptions créées au cours 8 empêcheraient ce script de fonctionner.
-- =====================================================================
-- CREATE DATABASE gestionScolaire;
-- GO
-- USE gestionScolaire;
-- GO

-- 1. Supprimer les vues du cours 9 AVANT les tables
--    (une vue WITH SCHEMABINDING empêche de supprimer sa table)

CREATE DATABASE VUUESCLASS
USE VUUESCLASS

DROP VIEW IF EXISTS vw_Bug_A, vw_Bug_B, vw_Bug_C, vw_Bug_D,
    vw_Etudiants_A_Risque, vw_Performance_Etudiants, vw_Etudiants_Cours,
    vw_Etudiants_Actifs, vw_Etudiants_Informatique,
    vw_Cours_Tous, vw_Cours_Credits,
    vw_Test_A, vw_Test_B, vw_Test_C, vw_Test_D, vw_Test_E,
    vw_Livres_Disponibles;
GO

-- 2. Supprimer les tables (Inscriptions d'abord, à cause des clés étrangères)
DROP TABLE IF EXISTS Inscriptions, Cours, Etudiants, Livres;
GO

-- 3. Créer les tables
CREATE TABLE Etudiants (
    EtudiantID    INT PRIMARY KEY,
    Nom           VARCHAR(50) NOT NULL,
    Prenom        VARCHAR(50) NULL,      -- peut être NULL (voir étudiant 12)
    DateNaissance DATE,
    Programme     VARCHAR(50),
    Statut        VARCHAR(20)            -- 'Actif', 'Inactif', 'Diplômé'
);

CREATE TABLE Cours (
    CoursID     INT PRIMARY KEY,
    CodeCours   VARCHAR(20),
    NomCours    VARCHAR(100),
    Credits     INT,
    Departement VARCHAR(50)
);

CREATE TABLE Inscriptions (
    InscriptionID INT PRIMARY KEY,
    EtudiantID    INT,
    CoursID       INT,
    Session       VARCHAR(20),           -- 'H2026', 'A2026'
    Note          DECIMAL(5,2),          -- NULL = note pas encore saisie
    FOREIGN KEY (EtudiantID) REFERENCES Etudiants(EtudiantID),
    FOREIGN KEY (CoursID)    REFERENCES Cours(CoursID)
);

CREATE TABLE Livres (
    LivreID   INT PRIMARY KEY,
    Titre     VARCHAR(200) NOT NULL,
    Auteur    VARCHAR(100) NOT NULL,
    ISBN      VARCHAR(20),
    Statut    VARCHAR(20) NOT NULL,      -- 'Disponible', 'Emprunté', 'En réparation'
    DateAchat DATE
);
GO

-- 4. Données
INSERT INTO Etudiants (EtudiantID, Nom, Prenom, DateNaissance, Programme, Statut) VALUES
(1,  'Tremblay',  'Sophie',    '2003-05-15', 'Informatique', 'Actif'),
(2,  'Gagnon',    'Marc',      '2002-08-22', 'Informatique', 'Actif'),
(3,  'Roy',       'Julie',     '2004-01-10', 'Gestion',      'Actif'),
(4,  'Côté',      'Alexandre', '2001-11-30', 'Informatique', 'Actif'),
(5,  'Bouchard',  'Émilie',    '2003-03-18', 'Gestion',      'Actif'),
(6,  'Lavoie',    'Thomas',    '2002-07-25', 'Informatique', 'Inactif'),
(7,  'Bergeron',  'Isabelle',  '2000-09-12', 'Informatique', 'Diplômé'),
(8,  'Morin',     'David',     '2004-06-08', 'Gestion',      'Actif'),
(9,  'Gauthier',  'Catherine', '1999-12-03', 'Informatique', 'Actif'),
(10, 'Fortin',    'Nicolas',   '2003-04-20', 'Sciences',     'Actif'),
(11, 'Pelletier', 'Léa',       '2005-02-14', 'Informatique', 'Actif'),  -- aucune inscription
(12, 'Nguyen',    NULL,        '2003-09-09', 'Gestion',      'Actif'),  -- prénom inconnu
(13, 'Dubé',      'Samuel',    '2002-10-05', 'Informatique', 'Actif'),  -- moyenne 84,50
(14, 'Ouellet',   'Maya',      '2005-11-30', 'Sciences',     'Actif');

INSERT INTO Cours (CoursID, CodeCours, NomCours, Credits, Departement) VALUES
(1,  'INF101', 'Introduction à la programmation', 3, 'Informatique'),
(2,  'INF201', 'Structures de données',           3, 'Informatique'),
(3,  'INF301', 'Bases de données',                3, 'Informatique'),
(4,  'INF401', 'Développement web',               3, 'Informatique'),
(5,  'GES101', 'Comptabilité de base',            3, 'Gestion'),
(6,  'GES201', 'Marketing',                       3, 'Gestion'),
(7,  'MAT101', 'Mathématiques appliquées',        3, 'Mathématiques'),
(8,  'INF501', 'Sécurité informatique',           3, 'Informatique'),
(9,  'SCI101', 'Physique générale',               3, 'Sciences'),
(10, 'INF601', 'Intelligence artificielle',       3, 'Informatique');

INSERT INTO Inscriptions (InscriptionID, EtudiantID, CoursID, Session, Note) VALUES
(1,  1, 1,  'H2026', 92.50),
(2,  1, 2,  'H2026', 88.00),
(3,  1, 3,  'A2026', 90.00),
(4,  1, 4,  'A2026', 87.50),
(5,  2, 1,  'H2026', 78.00),
(6,  2, 2,  'H2026', 82.00),
(7,  2, 3,  'A2026', 80.50),
(8,  2, 8,  'A2026', 76.00),
(9,  3, 5,  'H2026', 70.00),
(10, 3, 6,  'A2026', 72.50),
(11, 3, 7,  'A2026', 68.00),
(12, 4, 1,  'H2026', 62.00),
(13, 4, 2,  'H2026', 61.50),
(14, 4, 3,  'A2026', 63.00),
(15, 4, 4,  'A2026', 60.00),
(16, 5, 5,  'H2026', 55.00),
(17, 5, 6,  'A2026', 58.00),
(18, 5, 7,  'A2026', 52.00),
(19, 6, 1,  'H2026', 75.00),
(20, 6, 2,  'H2026', 0.00),
(21, 8, 5,  'A2026', 71.00),
(22, 8, 6,  'A2026', 69.50),
(23, 8, 7,  'A2026', 73.00),
(24, 9, 1,  'H2026', 95.00),
(25, 9, 2,  'H2026', 93.50),
(26, 9, 3,  'A2026', 91.00),
(27, 9, 8,  'A2026', 89.00),
(28, 9, 10, 'A2026', 94.50),
(29, 10, 9, 'H2026', 80.00),
(30, 10, 7, 'A2026', 77.50),
(31, 10, 1, 'A2026', 79.00),
(32, 12, 5, 'A2026', 66.00),
(33, 13, 1, 'H2026', 84.00),
(34, 13, 3, 'A2026', 85.00),
(35, 1, 10, 'A2026', NULL),          -- note pas encore saisie
(36, 14, 9, 'A2026', 74.50);

INSERT INTO Livres (LivreID, Titre, Auteur, ISBN, Statut, DateAchat) VALUES
(1, 'Le Petit Prince', 'Antoine de Saint-Exupéry', '978-2070612758', 'Disponible',    '2024-01-15'),
(2, '1984',            'George Orwell',            '978-0451524935', 'Emprunté',      '2024-02-20'),
(3, 'Les Misérables',  'Victor Hugo',              '978-2253096337', 'En réparation', '2023-09-01');
GO

-- Vue A
SELECT COUNT(*) FROM Etudiants;
GO
CREATE VIEW vw_Bug_A AS
SELECT EtudiantID, Nom FROM Etudiants;
GO
SELECT * FROM vw_Bug_A


-- Vue B
CREATE VIEW vw_Bug_B AS
SELECT EtudiantID, Prenom + ' ' + Nom AS NomEtudiants
FROM Etudiants;
GO
SELECT * FROM vw_Bug_B;

-- Vue C
CREATE VIEW vw_Bug_C AS
SELECT EtudiantID, Nom, Programme
FROM Etudiants
--ORDER BY Nom;
GO
SELECT * FROM vw_Bug_C
-- Vue D
CREATE VIEW vw_Bug_D AS
SELECT e.EtudiantID, NomCours, Note
FROM Etudiants e
INNER JOIN Inscriptions i ON e.EtudiantID = i.EtudiantID
INNER JOIN Cours c ON i.CoursID = c.CoursID;
GO

SELECT * FROM vw_Bug_D 

GO 
CREATE VIEW vw_Etudiants_Actifs AS
SELECT E.EtudiantID, CONCAT(E.Prenom,' ', E.Nom) NomComplet, E.Programme, E.DateNaissance
FROM Etudiants E
WHERE E.Statut = 'Actif'

SELECT * FROM vw_Etudiants_Actifs
SELECT * FROM vw_Etudiants_Actifs
WHERE Programme = 'Informatique'