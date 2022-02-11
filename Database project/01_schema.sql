SET sqlblanklines ON

DROP TABLE Soumission;
DROP TABLE Position;
DROP TABLE Camion;
DROP TABLE Compagnie;
DROP TABLE Tracteur;
DROP TABLE Equipement;
DROP TABLE TypeEquipement;
DROP TABLE Chargement;
DROP TABLE Route;
DROP TABLE Client;


CREATE TABLE Client
(
  pClient NUMBER NOT NULL PRIMARY KEY,
  nNoPermis VARCHAR2(50) NOT NULL,
  cNom VARCHAR2(50) NOT NULL,
  cPrenom VARCHAR2(50) NOT NULL,
  nCivique NUMERIC NOT NULL,
  cRue VARCHAR2(50) NOT NULL,
  cCity VARCHAR2(50) NOT NULL,
  cCodePostal VARCHAR2(50) NOT NULL,
  nPhone VARCHAR2(50) NOT NULL
);

CREATE TABLE Route
(
  pRoute NUMBER NOT NULL PRIMARY KEY,
  cRoute VARCHAR2(30) NOT NULL,
  nLatOri NUMERIC (8,5) NOT NULL,
  nLongOri NUMERIC (8,5) NOT NULL,
  nLatDes NUMERIC (8,5) NOT NULL,
  nLongDes NUMERIC(8,5) NOT NULL,
  nDistance NUMERIC (8,5) NOT NULL
);

CREATE TABLE Chargement
(
  pChargement NUMBER NOT NULL PRIMARY KEY,
  nLenght NUMERIC NOT NULL,
  nWidht NUMERIC  NOT NULL,
  nHeight NUMERIC NOT NULL,
  nQuantity NUMERIC NOT NULL,
  nWeight NUMERIC NOT NULL,
  nHours NUMERIC NOT NULL,
  nValue NUMERIC NOT NULL,
  date_chargement DATE NOT NULL
);

CREATE TABLE TypeEquipement
(
  pTypeEquipement NUMBER NOT NULL PRIMARY KEY,
  cTypeEquipement VARCHAR2(30) NOT NULL,
  nCout NUMERIC (8,2) NOT NULL
);

CREATE TABLE Equipement
(
  pEquipement NUMBER NOT NULL,
  nCapacite NUMERIC NOT NULL,
  nLargeur NUMERIC NOT NULL,
  nLongueur NUMERIC NOT NULL ,
  nHauteur NUMERIC NOT NULL,
  pTypeEquipement NUMBER NOT NULL,
  PRIMARY KEY (pEquipement),
  CONSTRAINT FK_TypeEquipement FOREIGN KEY (pTypeEquipement) REFERENCES TypeEquipement (pTypeEquipement)
);

CREATE TABLE Tracteur
(
  pTracteur NUMBER NOT NULL PRIMARY KEY,
  cTracteur VARCHAR2(50) NOT NULL
);

CREATE TABLE Compagnie
(
  pCompagnie NUMBER NOT NULL PRIMARY KEY,
  cCompagnie VARCHAR2(50) NOT NULL
);

CREATE TABLE Camion
(
  pCamion NUMBER NOT NULL PRIMARY KEY,
  pTracteur NUMBER NOT NULL,
  pEquipement NUMBER NOT NULL,
  pCompagnie NUMBER NOT NULL,
  consommation_par_litre NUMERIC NOT NULL,
  CONSTRAINT FK_ptracteur FOREIGN KEY (pTracteur) REFERENCES Tracteur (pTracteur),
  CONSTRAINT FK_pEquipement FOREIGN KEY (pEquipement) REFERENCES Equipement (pEquipement),
  CONSTRAINT FK_pCompagnie FOREIGN KEY (pCompagnie) REFERENCES Compagnie (pCompagnie)
);

CREATE TABLE Position
(
  pPosition NUMBER NOT NULL PRIMARY KEY,
  cPosition VARCHAR2 (30) NOT NULL,
  nLat NUMERIC(8,5) NOt NULL,
  nLong NUMERIC(8,5)NOT NULL,
  bDisponible NUMERIC(1) NOT NULL,
  pCamion NUMBER NOT NULL,
  CONSTRAINT FK_pCamion FOREIGN KEY (pCamion) REFERENCES Camion (pCamion)
);

CREATE TABLE Soumission
(
   pSoumission NUMBER NOT NULL PRIMARY KEY,
   pClient NUMBER NOT NULL,
   pChargement NUMBER NOT NULL,
   pCamion NUMBER NOT NULL,
   pRoute NUMBER NOT NULL,
   CONSTRAINT FKK_pClient FOREIGN KEY (pClient) REFERENCES Client (pClient),
   CONSTRAINT FK_pChargement FOREIGN KEY (pChargement) REFERENCES Chargement(pChargement),
  CONSTRAINT FKK_pCamion FOREIGN KEY (pCamion) REFERENCES Camion (pCamion),
  CONSTRAINT FK_pRoute FOREIGN KEY (pRoute) REFERENCES Route (pRoute),
  dateSoumission DATE NOT NULL,
  nPrixCarburant NUMERIC NOT NULL,
  nConsCarb NUMERIC NOT NULL
);