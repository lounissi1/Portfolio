INSERT INTO Client (pClient,nNoPermis,cNom,cPrenom,nCivique,cRue,cCity,cCodePostal,nPhone) VALUES (1,'VI5443321','Dufour','Vincent',219,'Rue Henri','Montreal','H5L 2F6','5144458857');
INSERT INTO Client (pClient,nNoPermis,cNom,cPrenom,nCivique,cRue,cCity,cCodePostal,nPhone) VALUES (2, 'LA4678321', 'Lachapelle', 'Sophie', 310, 'Rue Londres', 'Montreal', 'H7L 2P6', '5144458858');
INSERT INTO Client (pClient,nNoPermis,cNom,cPrenom,nCivique,cRue,cCity,cCodePostal,nPhone) VALUES (3, 'KU9443321', 'Kumon', 'Pascal', 54, 'Rue Oxford', 'Laval', 'H2L 9F6', '5144458850');

INSERT INTO Client
    (pClient,nNoPermis,cNom,cPrenom,nCivique,cRue,cCity,cCodePostal,nPhone)
VALUES
    (4, 'KU9443821', 'Des Jardins', 'David', '444', 'Rue Montpellier', 'Laval', 'H9L 1F6', '5144458670');

INSERT INTO  Route
    (pRoute,cRoute,nLatOri,nLongOri,nLatDes,nLongDes,nDistance)
VALUES
    (40, 'MTl_QC', 45, 73, 46, 71, 255);
INSERT INTO  Route
    (pRoute,cRoute,nLatOri,nLongOri,nLatDes,nLongDes,nDistance)
VALUES
    (5, 'MTl_Toronto', 45, 73, 43, 79, 540);
INSERT INTO  Route
    (pRoute,cRoute,nLatOri,nLongOri,nLatDes,nLongDes,nDistance)
VALUES
    (6, 'MTl_Ottawa', 45, 73, 45, 75, 200);

INSERT INTO Chargement
    (pChargement,nLenght,nWidht,nHeight,nQuantity,nWeight,nHours,nValue,date_chargement)
VALUES
    (7, 10, 10, 10, 20, 350, 1, 1500, '2019-10-01');
INSERT INTO Chargement
    (pChargement,nLenght,nWidht,nHeight,nQuantity,nWeight,nHours,nValue,date_chargement)
VALUES
    (8, 12, 10, 23, 15, 420, 2, 2300, '2019-10-02');
INSERT INTO Chargement
    (pChargement,nLenght,nWidht,nHeight,nQuantity,nWeight,nHours,nValue,date_chargement)
VALUES
    (9, 10, 10, 11, 20, 350, 2.3, 2300, '2019-10-05');


INSERT INTO TypeEquipement
VALUES
    (10, 'DRYVAN', 120);
INSERT INTO TypeEquipement
VALUES
    (11, 'FLATBED', 140);

INSERT INTO  Equipement
    (pEquipement,nCapacite,nLargeur,nLongueur,nHauteur,pTypeEquipement)
VALUES
    (12, 45000, 96, 45, 102, 10);
INSERT INTO  Equipement
    (pEquipement,nCapacite,nLargeur,nLongueur,nHauteur,pTypeEquipement)
VALUES
    (13, 60000, 102, 48, 100, 11);


INSERT INTO Tracteur (pTracteur,cTracteur) VALUES (14,'FORD');
INSERT INTO Tracteur (pTracteur,cTracteur) VALUES(15, 'FIAT');
INSERT INTO Tracteur (pTracteur,cTracteur) VALUES (16,'DODGE');


INSERT INTO Compagnie
    (pcompagnie,cCompagnie)
VALUES
    (17, 'Discount');
INSERT INTO Compagnie
    (pCompagnie,cCompagnie)
VALUES
    (19, 'U-HAUl');
INSERT INTO Compagnie
    (pCompagnie,cCompagnie)
VALUES
    (20, 'Sauvageau');

INSERT INTO Camion (pCamion,pTracteur,pEquipement,pCompagnie,consommation_par_litre) VALUES (22, 14,12,17,20);
INSERT INTO Camion (pCamion,pTracteur,pEquipement,pCompagnie,consommation_par_litre) VALUES (23, 15,13,19,23);
INSERT INTO Camion (pCamion,pTracteur,pEquipement,pCompagnie,consommation_par_litre) VALUES (24, 16,13,20,25);

INSERT INTO Position (pPosition,cPosition,nLat,nLong,bDisponible,pCamion) VALUES (25,'position1',45,73,1,22);
INSERT INTO Position (pPosition,cPosition,nLat,nLong,bDisponible,pCamion) VALUES (26,'position2',45,75,1,23);
INSERT INTO Position (pPosition,cPosition,nLat,nLong,bDisponible,pCamion) VALUES (27,'position3',43,79,1,24);
INSERT INTO Position (pPosition,cPosition,nLat,nLong,bDisponible,pCamion) VALUES (28,'position4',46,71,1,24);
INSERT INTO Position (pPosition,cPosition,nLat,nLong,bDisponible,pCamion) VALUES (29,'position5',43,68,0,22);

INSERT INTO Soumission
    (pSoumission, pClient, pChargement, pCamion, pRoute, dateSoumission,nPrixCarburant,nConsCarb)
VALUES
    (30, 1, 7, 23, 40, '2019-09-30', 1.22, 50);

INSERT INTO Soumission
    (pSoumission, pClient, pChargement, pCamion, pRoute, dateSoumission,nPrixCarburant,nConsCarb)
VALUES
    (31, 2, 8, 22, 5, '2019-09-30', 1.12, 70);

INSERT INTO Soumission
    (pSoumission, pClient, pChargement, pCamion, pRoute, dateSoumission,nPrixCarburant,nConsCarb)
VALUES
    (32, 3, 9, 24, 6, '2019-09-25', 1.35, 95);

INSERT INTO Soumission
    (pSoumission, pClient, pChargement, pCamion, pRoute, dateSoumission,nPrixCarburant,nConsCarb)
VALUES
    (34, 4, 9, 22, 6, '2019-09-30', 1.40, 100);

INSERT INTO Soumission
    (pSoumission, pClient, pChargement, pCamion, pRoute, dateSoumission,nPrixCarburant,nConsCarb)
VALUES
    (35, 4, 7, 23, 6, '2019-09-30', 1.35, 110);