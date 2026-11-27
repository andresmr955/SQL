-- 420-2C5-MA BD1
-- Groupes 0001 et 0002 A026
-- TP3 - Script de création de la base de données
-- Prof. Nader Chaabouni

-- Création de la base de données
USE master;
GO

DROP DATABASE IF EXISTS TP3_GYM;
GO

CREATE DATABASE TP3_GYM;
GO

USE TP3_GYM;
GO

-- =============================================
-- Table Abonnements
-- =============================================
CREATE TABLE Abonnements (
    AbonnementID INT PRIMARY KEY,
    TypeAbonnement VARCHAR(50) NOT NULL,
    DureeJours INT NOT NULL,
    Prix DECIMAL(10, 2) NOT NULL,
    Description VARCHAR(200)
);

-- =============================================
-- Table Membres
-- =============================================
CREATE TABLE Membres (
    MembreID INT PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Prenom VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    Telephone VARCHAR(15),
    DateNaissance DATE NOT NULL,
    DateInscription DATE NOT NULL,
    Ville VARCHAR(50) NOT NULL,
    Statut VARCHAR(20) NOT NULL
);

-- =============================================
-- Table Inscriptions
-- =============================================
CREATE TABLE Inscriptions (
    InscriptionID INT PRIMARY KEY,
    MembreID INT NOT NULL,
    AbonnementID INT NOT NULL,
    DateDebut DATE NOT NULL,
    DateFin DATE NOT NULL,
    Montant DECIMAL(10, 2) NOT NULL,
    StatutPaiement VARCHAR(30) NOT NULL,
    FOREIGN KEY (MembreID) REFERENCES Membres(MembreID),
    FOREIGN KEY (AbonnementID) REFERENCES Abonnements(AbonnementID)
);

-- =============================================
-- Table Cours
-- =============================================
CREATE TABLE Cours (
    CoursID INT PRIMARY KEY,
    NomCours VARCHAR(80) NOT NULL,
    Instructeur VARCHAR(80) NOT NULL,
    Horaire VARCHAR(50) NOT NULL,
    Capacite INT NOT NULL,
    Salle VARCHAR(30),
    TypeCours VARCHAR(50) NOT NULL
);

-- =============================================
-- Table Participations
-- =============================================
CREATE TABLE Participations (
    ParticipationID INT PRIMARY KEY,
    MembreID INT NOT NULL,
    CoursID INT NOT NULL,
    DateParticipation DATE NOT NULL,
    Present VARCHAR(3) NOT NULL,
    FOREIGN KEY (MembreID) REFERENCES Membres(MembreID),
    FOREIGN KEY (CoursID) REFERENCES Cours(CoursID)
);

-- =============================================
-- Insertion des données - Abonnements
-- =============================================
INSERT INTO Abonnements (AbonnementID, TypeAbonnement, DureeJours, Prix, Description) VALUES
(1, 'Mensuel Basic', 30, 39.99, 'Accès salle de musculation uniquement'),
(2, 'Mensuel Premium', 30, 59.99, 'Accès complet + cours collectifs'),
(3, 'Trimestriel Basic', 90, 99.99, 'Accès salle de musculation - 3 mois'),
(4, 'Trimestriel Premium', 90, 149.99, 'Accès complet + cours - 3 mois'),
(5, 'Annuel Basic', 365, 349.99, 'Accès salle de musculation - 1 an'),
(6, 'Annuel Premium', 365, 499.99, 'Accès complet + cours - 1 an'),
(7, 'Étudiant Mensuel', 30, 29.99, 'Tarif réduit étudiants'),
(8, 'Passe Journalier', 1, 15.00, 'Accès pour une journée');

-- =============================================
-- Insertion des données - Membres
-- =============================================
INSERT INTO Membres (MembreID, Nom, Prenom, Email, Telephone, DateNaissance, DateInscription, Ville, Statut) VALUES
(1, 'Tremblay', 'Sophie', 'sophie.t@email.com', '514-555-1001', '1995-03-15', '2023-01-10', 'Montreal', 'Actif'),
(2, 'Gagnon', 'Marc', 'marc.g@email.com', '514-555-1002', '1988-07-22', '2023-02-15', 'Montreal', 'Actif'),
(3, 'Roy', 'Julie', 'julie.r@email.com', '450-555-1003', '1992-11-08', '2023-03-20', 'Laval', 'Actif'),
(4, 'Côté', 'Alexandre', 'alex.c@email.com', '514-555-1004', '1990-05-30', '2023-04-12', 'Montreal', 'Suspendu'),
(5, 'Leblanc', 'Catherine', 'cat.leblanc@email.com', '418-555-1005', '1997-01-18', '2023-05-08', 'Quebec', 'Actif'),
(6, 'Martin', 'Pierre', 'pierre.m@email.com', '514-555-1006', '1985-09-25', '2023-06-05', 'Montreal', 'Actif'),
(7, 'Dubois', 'Marie', 'marie.d@email.com', '450-555-1007', '1993-04-12', '2023-07-18', 'Longueuil', 'Actif'),
(8, 'Lavoie', 'David', 'david.l@email.com', NULL, '1991-12-03', '2023-08-22', 'Montreal', 'Inactif'),
(9, 'Fortin', 'Isabelle', 'isabelle.f@email.com', '514-555-1009', '1989-06-19', '2023-09-10', 'Montreal', 'Actif'),
(10, 'Bergeron', 'Luc', 'luc.b@email.com', '418-555-1010', '1994-10-28', '2023-10-05', 'Quebec', 'Actif'),
(11, 'Gauthier', 'Nathalie', 'nat.g@email.com', '514-555-1011', '1996-02-14', '2024-01-12', 'Montreal', 'Actif'),
(12, 'Bouchard', 'François', 'francois.b@email.com', '450-555-1012', '1987-08-07', '2024-02-20', 'Laval', 'Actif');

-- =============================================
-- Insertion des données - Inscriptions
-- =============================================
INSERT INTO Inscriptions (InscriptionID, MembreID, AbonnementID, DateDebut, DateFin, Montant, StatutPaiement) VALUES
(1, 1, 2, '2024-01-10', '2024-02-09', 59.99, 'Payé'),
(2, 2, 5, '2024-01-15', '2025-01-14', 314.99, 'Payé'),
(3, 3, 1, '2024-02-01', '2024-03-02', 39.99, 'Payé'),
(4, 4, 3, '2024-02-10', '2024-05-10', 99.99, 'En retard'),
(5, 5, 7, '2024-03-01', '2024-03-31', 29.99, 'Payé'),
(6, 6, 6, '2024-03-15', '2025-03-14', 449.99, 'Payé'),
(7, 7, 2, '2024-04-01', '2024-05-01', 59.99, 'Payé'),
(8, 1, 2, '2024-02-10', '2024-03-11', 59.99, 'Payé'),
(9, 9, 4, '2024-04-20', '2024-07-19', 134.99, 'Payé'),
(10, 10, 7, '2024-05-01', '2024-05-31', 29.99, 'Payé'),
(11, 11, 1, '2024-05-15', '2024-06-14', 39.99, 'En attente'),
(12, 3, 2, '2024-03-03', '2024-04-02', 49.99, 'Payé');

-- =============================================
-- Insertion des données - Cours
-- =============================================
INSERT INTO Cours (CoursID, NomCours, Instructeur, Horaire, Capacite, Salle, TypeCours) VALUES
(1, 'Yoga Matinal', 'Annie Tremblay', 'Lundi 7h00', 20, 'Studio A', 'Bien-être'),
(2, 'Spinning Intensif', 'Marc Gagnon', 'Mardi 18h00', 25, 'Studio B', 'Cardio'),
(3, 'Zumba', 'Julie Roy', 'Mercredi 19h00', 30, 'Studio A', 'Danse'),
(4, 'CrossFit', 'Pierre Martin', 'Jeudi 17h00', 15, 'Zone CrossFit', 'Force'),
(5, 'Pilates', 'Sophie Leblanc', 'Vendredi 12h00', 18, 'Studio A', 'Bien-être'),
(6, 'BoxeFit', 'David Fortin', 'Samedi 10h00', 20, 'Studio B', 'Cardio'),
(7, 'Yoga du Soir', 'Annie Tremblay', 'Lundi 19h00', 20, 'Studio A', 'Bien-être'),
(8, 'Abdos-Fessiers', 'Catherine Côté', 'Mardi 12h00', 25, 'Studio B', 'Renforcement'),
(9, 'Stretching', 'Sophie Leblanc', 'Mercredi 13h00', 22, 'Studio A', 'Bien-être'),
(10, 'HIIT', 'Marc Gagnon', 'Jeudi 06h00', 18, 'Studio B', 'Cardio');


-- =============================================
-- Insertion des données - Participations
-- =============================================
INSERT INTO Participations (ParticipationID, MembreID, CoursID, DateParticipation, Present) VALUES
(1, 1, 1, '2024-01-15', 'Oui'),
(2, 1, 7, '2024-01-22', 'Oui'),
(3, 2, 2, '2024-01-16', 'Oui'),
(4, 2, 4, '2024-01-18', 'Non'),
(5, 3, 3, '2024-02-07', 'Oui'),
(6, 3, 5, '2024-02-09', 'Oui'),
(7, 5, 1, '2024-03-04', 'Oui'),
(8, 6, 4, '2024-03-21', 'Oui'),
(9, 6, 6, '2024-03-23', 'Oui'),
(10, 7, 3, '2024-04-03', 'Non'),
(11, 7, 8, '2024-04-09', 'Oui'),
(12, 9, 2, '2024-04-23', 'Oui'),
(13, 9, 9, '2024-04-24', 'Non'),
(14, 10, 6, '2024-05-04', 'Oui'),
(15, 11, 5, '2024-05-17', 'Oui'),
(16, 1, 1, '2024-01-29', 'Oui'),
(17, 3, 3, '2024-02-14', 'Non'),
(18, 9, 4, '2024-05-02', 'Oui');

GO


