-- Supprimer dans la table compo toutes les lignes concernant les bons de commande d’avril 2019
DELETE FROM COMPO
WHERE ID_BON IN (
    SELECT ID
    FROM BON
    WHERE DATE_CMDE >= '2019-04-01' AND DATE_CMDE < '2019-05-01'
);

-- Supprimer dans la table bon tous les bons de commande d’avril 2019
DELETE FROM BON
WHERE DATE_CMDE >= '2019-04-01' AND DATE_CMDE < '2019-05-01';
