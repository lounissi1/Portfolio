SET sqlblanklines ON

DROP TABLE CommandeD;
DROP TABLE CommandeE;
DROP TABLE SoumissionD;
DROP TABLE SoumissionE;
DROP TABLE Chargement;
DROP TABLE Position;
DROP TABLE Camion;
DROP TABLE Tracteur;
DROP TABLE Carburant;
DROP TABLE Compagnie CASCADE CONSTRAINTS PURGE;
DROP TABLE Equipement;
DROP TABLE TypeEquipement;
DROP TABLE Route CASCADE CONSTRAINTS PURGE;
DROP TABLE Client; 

CREATE TABLE Client
(
  pClient NUMBER NOT NULL PRIMARY KEY,
  cClient VARCHAR2(50) NULL
);

CREATE TABLE Route
(
  pRoute NUMBER NOT NULL PRIMARY KEY,
  cRoute VARCHAR2(30) NULL,
  nLatOri NUMBER NULL,
  nLongOri NUMBER NULL,
  nLatDes NUMBER  NULL,
  nLongDes NUMBER NULL,
  nDistance NUMBER NULL
);

CREATE TABLE TypeEquipement
(
  pTypeEquipement NUMBER NOT NULL PRIMARY KEY,
  cTypeEquipement VARCHAR2(30) NULL,
  nCout NUMBER (8,2) NULL
);

CREATE TABLE Equipement
(
  pEquipement NUMBER NOT NULL PRIMARY KEY,
  cEquipement VARCHAR2(50) NULL,
  nCapacite NUMBER NULL,
  nLongueur NUMBER NULL ,
  nLargeur NUMBER  NULL,
  nHauteur NUMBER  NULL,
  pTypeEquipement NUMBER NULL,
  CONSTRAINT FK_TypeEquipement FOREIGN KEY (pTypeEquipement) REFERENCES TypeEquipement (pTypeEquipement)
);

CREATE TABLE Compagnie
(
  pCompagnie NUMBER NOT NULL PRIMARY KEY,
  cCompagnie VARCHAR2(50) NULL,
  nProfit NUMBER NULL --
);

CREATE TABLE Carburant
(
pCarburant NUMBER NOT NULL PRIMARY KEY,
cCarburant VARCHAR2(50)  NULL,
nCout NUMBER(8,2) NULL
);

CREATE TABLE Tracteur
(
  pTracteur NUMBER NOT NULL PRIMARY KEY,
  cTracteur VARCHAR2(50)  NULL,
  nConsommation NUMBER NULL,
  bActif NUMERIC(1) NOT NULL CHECK (bActif IN (0,1)), 
  pCarburant NUMBER NULL,
  CONSTRAINT FK_pCarburant FOREIGN KEY (pCarburant) REFERENCES Carburant (pCarburant)
  
);

CREATE TABLE Camion
(
  pCamion NUMBER NOT NULL PRIMARY KEY,
  cCamion VARCHAR2(50) NULL,
  pEquipement NUMBER NULL,
  pTracteur NUMBER NULL,
  pCompagnie NUMBER NULL,
  CONSTRAINT FK_ptracteur FOREIGN KEY (pTracteur) REFERENCES Tracteur (pTracteur),
  CONSTRAINT FK_pEquipement FOREIGN KEY (pEquipement) REFERENCES Equipement (pEquipement),
  CONSTRAINT FK_pCompagnie FOREIGN KEY (pCompagnie) REFERENCES Compagnie (pCompagnie)
);

CREATE TABLE Position
(
  pPosition NUMBER NOT NULL PRIMARY KEY,
  cPosition VARCHAR2 (30) NULL,
  pCamion NUMBER NULL,
  nLat NUMBER(8,5) NULL,
  nLong NUMBER (8,5) NULL,
  bDisponible NUMERIC(1) NOT NULL CHECK (bDisponible IN (0,1)),    --booleen
  CONSTRAINT FK_pCamion FOREIGN KEY (pCamion) REFERENCES Camion (pCamion)
);

CREATE TABLE Chargement
(
  pChargement NUMBER NOT NULL PRIMARY KEY,
  pClient NUMBER  NULL,
  cChargement VARCHAR2 (50),
  nLatOri NUMBER (8,5)  NULL,
  nLongOri NUMBER (8,5)  NULL,
  nLatDes NUMBER (8,5)NULL,
  nLongDes NUMBER(8,5)NULL,
  nLongueur NUMBER NULL,
  nLargeur NUMBER NULL,
  nHauteur NUMBER NULL,
  nPoids NUMBER NULL,  
  CONSTRAINT FKK_pClient FOREIGN KEY (pClient) REFERENCES Client (pClient)
);

CREATE TABLE SoumissionE
(
    pSoumissionE NUMBER NOT NULL PRIMARY KEY, 
    pChargement NUMBER NULL, 
    dSoumission DATE  NULL, 
   CONSTRAINT FK_pChargement FOREIGN KEY (pChargement) REFERENCES Chargement (pChargement) 
);

CREATE TABLE SoumissionD
(
   pSoumissionD NUMBER NOT NULL PRIMARY KEY,
   pSoumissionE NUMBER NULL,
   nPrix NUMBER NULL,
   pCamion NUMBER NULL, 
   CONSTRAINT FK_SoumissionE FOREIGN KEY (pSoumissionE) REFERENCES SoumissionE (pSoumissionE),
   CONSTRAINT FK_SoumissionD_pCamion FOREIGN KEY (pCamion) REFERENCES Camion (pCamion)
);

CREATE TABLE CommandeE
(
pCommandeE NUMBER NOT NULL PRIMARY KEY,
dCommandeE DATE NULL,
pSoumissionD NUMBER NULL,
CONSTRAINT FK_CommandeE_pSoumissionD FOREIGN KEY (pSoumissionD) REFERENCES SoumissionD (pSoumissionD)
);

CREATE TABLE CommandeD
(
pCommandeD NUMBER NOT NULL PRIMARY KEY,
pCommandeE NUMBER NULL,
nPrix NUMBER NULL,
CONSTRAINT FK_CommandeD_pCommandeE FOREIGN KEY (pCommandeE) REFERENCES CommandeE (pCommandeE)
);


