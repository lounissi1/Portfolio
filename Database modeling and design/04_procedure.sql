-- Procédure pour créer une demande de chargement

CREATE OR REPLACE PROCEDURE p_demande(ppClient IN NUMBER, pnLatOri IN NUMBER, pnLongOri IN NUMBER, pnLatDes IN NUMBER, pnLongDes IN NUMBER, pnPoids IN NUMBER, pnLargeur IN NUMBER, pnLongueur IN NUMBER, pnHauteur IN NUMBER )
IS
vpChargement NUMBER;

begin
	-- On assume aussi que le trigger sur Chargement existe
	INSERT INTO Chargement(pClient, nLatOri, nLongOri, nLatDes, nLongDes, nPoids, nLargeur, nLongueur, nHauteur) 
	VALUES(ppClient ,pnLatOri, pnLongOri, pnLatDes, pnLongDes, pnPoids, pnLargeur, pnLongueur, pnHauteur)
	RETURNING pChargement INTO vpChargement;
    -- cle primaire de chargement stockée dans pChargement
	-- ici on peut insérer pSoumission selon la valeur de pChargement maisce n'est pas demandé dans l'énoncé
END p_demande;
/

-- procédure pour créer une soumission

CREATE OR REPLACE PROCEDURE p_soumission(ppChargement IN NUMBER) IS

vpCamion NUMBER;
vpSoumissionE NUMBER;

BEGIN
	-- On assume aussi que le trigger sur soumission existe
	INSERT INTO SoumissionE(pChargement, dSoumission) 
	VALUES(ppChargement, TO_DATE(sysdate, 'yyyy/mm/dd hh24:mi:ss'))
    RETURNING pSoumissionE INTO vpSoumissionE;

    SELECT Cam.pCamion
    INTO vpCamion
    FROM Camion Cam, Position Pos
    where Cam.pcamion = Pos.Pcamion 
    and pos.bdisponible = 1
    and ROWNUM = 1;
    
    INSERT INTO SoumissionD(pSoumissionE, nPrix, pCamion)
	VALUES(vpSoumissionE, 0, vpCamion);
    
END p_soumission;
/




-- procédure pour calculer le prix

CREATE OR REPLACE FUNCTION
 f_prix(ppSoumissionD IN NUMBER) RETURN NUMBER IS

vnConsommation NUMBER;
vnCoutGaz NUMBER;
vpChargement NUMBER;
vnCout NUMBER;
vnProfit NUMBER;
vnDistance NUMBER;
vPrix NUMBER;


BEGIN

    SELECT T.nConsommation, Car.nCout nCoutGaz, SE.pChargement, TE.nCout nCout, Com.nProfit
    INTO vnConsommation, vnCoutGaz, vpChargement, vnCout, vnProfit
    FROM Tracteur T, Camion Cam, Carburant Car, SoumissionD SD, SoumissionE SE, Equipement E, TypeEquipement TE, Compagnie Com
    WHERE SE.pSoumissionE=SD.pSoumissionE
    AND SD.pCamion=Cam.pCamion
    AND Cam.pTracteur=T.pTracteur 
    AND Cam.pEquipement=E.pEquipement
    AND E.pTypeEquipement=TE.pTypeEquipement
    AND T.pCarburant=Car.pCarburant
    AND Cam.pCompagnie=Com.pCompagnie
    AND SD.pSoumissionD=  ppSoumissionD;

    SELECT R.nDistance
    INTO vnDistance
    FROM Chargement C, Route R
    WHERE R.nLatOri=C.nLatOri 
    AND R.nLongOri=C.nLongOri
    AND R.nLatDes=C.nLatDes 
    AND R.nLongDes=C.nLongDes
    AND pChargement=vpChargement;
    
    RETURN(( (vnConsommation * vnDistance * vnCoutGaz) + (vnCout * vnDistance)  ) * vnProfit);

END f_prix;
/

-- procédure pour créer une commande

CREATE OR REPLACE PROCEDURE
 p_commande(ppSoumissionD IN NUMBER) IS

vpCommandeE NUMBER;

BEGIN

    --UPDATE SoumissionD SET nPrix = f_prix(ppSoumissionD) 
    -- where  pSoumissionD = ppSoumissionD;
    
	-- On assume aussi que le trigger sur soumission existe
	INSERT INTO CommandeE(pSoumissionD, dCommandeE) 
	VALUES (ppSoumissionD, TO_DATE(sysdate, 'yyyy/mm/dd hh24:mi:ss'))
    -- enregistrer le ID de la soumission 
    -- nouvellement créée dans la variable id 
    RETURNING pCommandeE INTO vpCommandeE;
    
    INSERT INTO CommandeD(pCommandeE, nPrix) 
    -- on utilise la fonction f_prix pour calculer 
    -- le prix (nprix) du détail de la commande
	VALUES (vpCommandeE, f_prix(ppSoumissionD));
    
END p_commande;
/

