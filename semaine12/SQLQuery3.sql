-- 1. Creación de tablas
CREATE TABLE etudiants (
    id_etudiant INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    ville VARCHAR(80) NOT NULL
);

CREATE TABLE cours (
    id_cours INT PRIMARY KEY,
    titre VARCHAR(120) NOT NULL,
    departement VARCHAR(80) NOT NULL
);

CREATE TABLE inscriptions (
    id_inscription INT PRIMARY KEY,
    id_etudiant INT NOT NULL,
    id_cours INT NOT NULL,
    statut VARCHAR(20) NOT NULL,
    CONSTRAINT fk_insc_etudiant FOREIGN KEY (id_etudiant) REFERENCES etudiants(id_etudiant),
    CONSTRAINT fk_insc_cours FOREIGN KEY (id_cours) REFERENCES cours(id_cours)
);

CREATE TABLE evaluations (
    id_evaluation INT PRIMARY KEY,
    id_inscription INT NOT NULL,
    type_eval VARCHAR(40) NOT NULL,
    note DECIMAL(5, 2) NOT NULL,
    CONSTRAINT fk_eval_inscription FOREIGN KEY (id_inscription) REFERENCES inscriptions(id_inscription)
);

-- 2. Inserción de datos de prueba
INSERT INTO etudiants (id_etudiant, nom, ville) VALUES
(1, 'Camille Laurent', 'Montréal'),
(2, 'Mateo Rojas', 'Laval'),
(3, 'Sofía Navarro', 'Longueuil'),
(4, 'Lucas Tremblay', 'Montréal'); -- Sin ninguna inscripción

INSERT INTO cours (id_cours, titre, departement) VALUES
(101, 'Bases de données', 'Informatique'),
(102, 'Systèmes d''exploitation', 'Informatique'),
(103, 'Algèbre linéaire', 'Mathématiques'),
(104, 'Rédaction technique', 'Communication'); -- Sin estudiantes inscritos

INSERT INTO inscriptions (id_inscription, id_etudiant, id_cours, statut) VALUES
(10, 1, 101, 'actif'),      -- Camille en Bases de données (con evaluación)
(20, 1, 102, 'abandonne'),  -- Camille en Systèmes d'exploitation (abandonado, sin evaluación)
(30, 2, 101, 'actif'),      -- Mateo en Bases de données (con evaluación)
(40, 3, 103, 'actif');      -- Sofía en Algèbre linéaire (sin evaluación aún)

INSERT INTO evaluations (id_evaluation, id_inscription, type_eval, note) VALUES
(1001, 10, 'Examen intra', 88.50),
(1002, 10, 'Projet final', 92.00),
(1003, 30, 'Examen intra', 76.00);

SELECT E.nom, C.titre, EV.note
FROM etudiants E
INNER JOIN inscriptions I
	ON E.id_etudiant = I.id_etudiant
INNER JOIN cours C
	ON I.id_cours = C.id_cours
INNER JOIN evaluations  EV
	ON I.id_inscription = EV.id_inscription

SELECT *
FROM etudiants E
LEFT JOIN inscriptions I 
	ON E.id_etudiant = I.id_etudiant
WHERE I.id_inscription IS NULL