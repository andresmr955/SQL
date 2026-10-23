CREATE DATABASE LANGMANIPULATIONDATA
GO

USE LANGMANIPULATIONDATA
GO

-- Code de l'exercice précédent sur l'agence de voyage --
drop Table if exists Sejour;
drop Table if exists Client;
drop Table if exists Activite;
drop Table if exists Station;

--##### Création des tables #####--

-- Table Station
CREATE TABLE Station (
	nomStation VARCHAR(30),
	capacite INT NOT NULL,
	lieu VARCHAR(30) NOT NULL,
	region VARCHAR(30),
	--NUMERIC(a, b) 
	-- a: Le nombre de numéros accepté à gauche de la virgule
	-- b: Le nombre de décimales
	tarif NUMERIC(10, 2) DEFAULT 0,
	PRIMARY KEY (nomStation),
	CONSTRAINT nom_region CHECK (
		region IN ('Ontario', 'Quebec', 'nouveau Brunswick', 'Nouvelle ecosse', 'Colombie Britannique')
	)
);

-- Table Activite
CREATE TABLE Activite (
	nomStation VARCHAR(30),
	libelle VARCHAR(30),
	prix NUMERIC(10, 2) DEFAULT 0,
	PRIMARY KEY (nomStation, libelle)
);

-- Table Client
CREATE TABLE Client (
	id NUMERIC(10),
	nom VARCHAR(30) NOT NULL,
	prenom VARCHAR(30),
	ville VARCHAR(30) NOT NULL,
	region VARCHAR(30),
	solde NUMERIC(10,2) NOT NULL,
	PRIMARY KEY (id)
);

-- Table Sejour
CREATE TABLE Sejour (
	idClient NUMERIC(10),
	station VARCHAR(30),
	debut DATE,
	nbPlaces NUMERIC(4) NOT NULL,
	PRIMARY KEY (idClient, station, debut)
);


--##### Insertion des données #####--

-- Table Station
insert into Station values ('Mont Tremblant', 1300, 'Mont Tremblant', 'Quebec',1200);
insert into Station values ('Saint Sauveur', 1000, 'Saint Sauveur', 'Quebec', 1500);
insert into Station values ('Chutes de Niagara', 1800, 'Chutes de Niagara', 'Ontario', 2000);

-- Table Activite
insert into Activite values('Saint Sauveur', 'Ski de fond', 150);
insert into Activite values('Saint Sauveur', 'Ski Alpin', 120);
insert into Activite values('Chutes de Niagara', 'Voile', 200);
insert into Activite values('Mont Tremblant', 'Moto neige', 90);
insert into Activite values('Chutes de Niagara', 'Plongee', 160);

--Table Client
insert into Client values(10, 'Rezgui', 'Jihene', 'Montreal', 'Quebec', 12690);
insert into Client values(20, 'Bricot', 'Mayka', 'Ottawa', 'Ontario', 6386);
insert into Client values(30, 'Rajhi', 'Najd', 'Toronto', 'Ontario', 9812);
insert into Client values(40, 'Fogg', 'Fred', 'Vancouver', 'Colombie Britannique', 6386);
insert into Client values(50, 'Fili', 'Jean', 'Fredericton', 'Nouveau Brunswick', 2415);
insert into Client values(60, 'coreveau', 'karim', 'Halifax', 'Nouvelle ecosse', 2415);

CREATE TABLE Livre(
	isbn VARCHAR(20) PRIMARY KEY,
	titre VARCHAR(100) NOT NULL,
	auteur VARCHAR(50) NOT NULL, 
	annee_publication INT,
	categorie VARCHAR(30)
);

CREATE TABLE Membre (
	numero_membre INT PRIMARY KEY IDENTITY(1000, 1)
);
