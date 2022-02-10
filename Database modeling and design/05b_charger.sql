-- Client

CREATE OR REPLACE PROCEDURE p_InsertData_Client (nbrLignes IN NUMBER) IS
BEGIN
   FOR i IN 1..nbrLignes --nbrLignes
   LOOP
       INSERT INTO Client (cClient)
       VALUES (CONCAT('Client-', i));
   END LOOP;
end;

EXECUTE p_InsertData_Client (10);


-- TypeEquipement
INSERT INTO TypeEquipement (cTypeEquipement,nCout) VALUES ('DRYVAN', 120);
INSERT INTO TypeEquipement (cTypeEquipement,nCout) VALUES ('FLATBED', 140);

-- Carburant
INSERT INTO Carburant (cCarburant,nCout) VALUES ('Essence',1.21);
INSERT INTO Carburant (cCarburant,nCout) VALUES ('Diesel',1.15);
INSERT INTO Carburant (cCarburant,nCout) VALUES ('Super',1.30);

--Compagnie 
INSERT INTO Compagnie (cCompagnie,nProfit) VALUES ('Discount',1.18);   --profit 
INSERT INTO Compagnie (cCompagnie,nProfit) VALUES ('U-HAUl',1.18);
INSERT INTO Compagnie (cCompagnie,nProfit) VALUES ('Sauvageau',1.18);

commit;

DECLARE
  TYPE id_type IS VARRAY(100) OF NUMBER;

  TypeEquipement_ids id_type;

begin
  SELECT pTypeEquipement BULK COLLECT INTO TypeEquipement_ids FROM TypeEquipement;

  for elem in 1 .. TypeEquipement_ids.count loop
    dbms_output.put_line(elem || ': ' || TypeEquipement_ids(elem));

    INSERT INTO  Equipement
        (cEquipement,nCapacite,nLongueur,nLargeur,nHauteur,pTypeEquipement) --FK111
    VALUES
        (CONCAT('Equip-', elem), 45000, 96, 45, 102, TypeEquipement_ids(elem)); 
  end loop;
  
END;
/


DECLARE
  TYPE id_type IS VARRAY(100) OF NUMBER;
  Carburant_ids id_type;

-- Insertion Tracteurs
begin

  SELECT pCarburant BULK COLLECT INTO Carburant_ids FROM Carburant;

  for elem in 1 .. Carburant_ids.count loop
  dbms_output.put_line(elem || ': ' || Carburant_ids(elem));
  INSERT INTO Tracteur (cTracteur,nConsommation,bActif,pCarburant) VALUES (CONCAT('Tracteur-', elem),20,1, Carburant_ids(elem));
  end loop;
  
END;
/

DECLARE
  TYPE id_type IS VARRAY(100) OF NUMBER;

  Tracteur_ids id_type;
  Equipement_ids id_type;
  Compagnie_ids id_type;
  
begin

  SELECT pEquipement BULK COLLECT INTO Equipement_ids FROM Equipement;
  SELECT pCompagnie BULK COLLECT INTO Compagnie_ids FROM Compagnie;
  SELECT pTracteur BULK COLLECT INTO Tracteur_ids FROM Tracteur;
  

  for e in 1 .. Equipement_ids.count loop
    for c in 1 .. Compagnie_ids.count loop
        for t in 1 .. Tracteur_ids.count loop
        
    dbms_output.put_line(Equipement_ids(e)|| Compagnie_ids(c) || Tracteur_ids(t));
    INSERT INTO Camion (cCamion,pEquipement,pTracteur,pCompagnie) VALUES (CONCAT('Camion', e), Equipement_ids(e),Tracteur_ids(t),Compagnie_ids(c));
    
        end loop;
    end loop;
  end loop;
  
END;
/
commit;

DECLARE
  TYPE id_type IS VARRAY(1000) OF NUMBER;
  Camion_ids id_type;

begin

  SELECT pCamion BULK COLLECT INTO Camion_ids FROM Camion;

  for c in 1 .. Camion_ids.count loop
  dbms_output.put_line(round(dbms_random.value(40,50)));
  INSERT INTO Position (cPosition,pCamion,nLat,nLong,bDisponible) VALUES (CONCAT('Position-', c),Camion_ids(c),round(dbms_random.value(40,50)),round(dbms_random.value(60,75)),round(dbms_random.value(0,1)));
  end loop;
  
END;
commit;
/

 --Execution d'un chargement


EXECUTE p_demande (42,20,20,20,20,20,20,20,20);
EXECUTE p_demande (2,45, 73, 43, 79, 540,20,20,20);
EXECUTE p_demande (2,45, 73, 45, 75, 200,20,20,20);
EXECUTE p_demande (2,45, 73, 45, 75, 200,20,20,20);
EXECUTE p_demande (4,45, 73, 43, 79, 540,20,20,20);
    
-- Execution d'une soumission
EXECUTE p_soumission(2);
        
-- Execution d'une commande
EXECUTE p_commande(2);
EXECUTE p_commande(6);

-- Route
INSERT INTO  Route
(cRoute,nLatOri,nLongOri,nLatDes,nLongDes,nDistance)
VALUES
('MTl_QC', 20, 20, 20, 20, 20);

INSERT INTO  Route
(cLaroute,nLatOri,nLongOri,nLatDes,nLongDes,nDistance)
VALUES
('MTl_Toronto', 45, 73, 43, 79, 540);

INSERT INTO  Route
(cLaroute,nLatOri,nLongOri,nLatDes,nLongDes,nDistance)
VALUES
('MTl_Ottawa', 45, 73, 45, 75, 200);


    
 
 


