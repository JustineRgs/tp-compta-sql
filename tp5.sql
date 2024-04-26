-- Pour lister les articles dans l’ordre alphabétique des désignations :
SELECT * FROM ARTICLE ORDER BY DESIGNATION

-- Listez les articles dans l’ordre des prix du plus élevé au moins élevé
SELECT * FROM ARTICLE ORDER BY PRIX DESC;

-- Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant
SELECT * FROM ARTICLE WHERE DESIGNATION LIKE '%boulon%' ORDER BY PRIX ASC;

-- Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT * FROM ARTICLE WHERE DESIGNATION LIKE '%sachet%';

-- Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !
SELECT * FROM ARTICLE WHERE LOWER(DESIGNATION) LIKE '%sachet%';

-- Listez les articles avec les informations fournisseur correspondantes. Les résultats doivent être triées dans l’ordre alphabétique des fournisseurs et par article du prix le plus élevé au moins élevé.
SELECT A.*, F.NOM AS FOURNISSEUR FROM ARTICLE A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
ORDER BY F.NOM ASC, A.PRIX DESC;

-- Listez les articles de la société « Dubois & Fils »
SELECT * FROM ARTICLE A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
WHERE F.NOM = 'Dubois & Fils';

-- Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT AVG(A.PRIX) AS MOYENNE_PRIX FROM ARTICLE A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
WHERE F.NOM = 'Dubois & Fils';

-- Calculez la moyenne des prix des articles de chaque fournisseur
SELECT F.NOM AS FOURNISSEUR, AVG(A.PRIX) AS MOYENNE_PRIX
FROM ARTICLE A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
GROUP BY F.NOM;

-- Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.
SELECT * FROM BON WHERE DATE_CMDE BETWEEN '2019-03-01' AND '2019-04-05 12:00:00';

-- Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT DISTINCT B.*
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
JOIN ARTICLE A ON C.ID_ART = A.ID
WHERE A.DESIGNATION LIKE '%boulon%';

-- Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé.
SELECT DISTINCT B.*, F.NOM AS FOURNISSEUR
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
JOIN ARTICLE A ON C.ID_ART = A.ID
JOIN FOURNISSEUR F ON B.ID_FOU = F.ID
WHERE A.DESIGNATION LIKE '%boulon%';

-- Calculez le prix total de chaque bon de commande
SELECT B.ID, SUM(A.PRIX * C.QTE) AS PRIX_TOTAL
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
JOIN ARTICLE A ON C.ID_ART = A.ID
GROUP BY B.ID;

-- Comptez le nombre d’articles de chaque bon de commande
SELECT B.ID, COUNT(*) AS NOMBRE_ARTICLES
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
GROUP BY B.ID;

-- Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d’articles de chacun de ces bons de commande
SELECT ID_BON, SUM(QTE) AS Total_QTE
FROM COMPO
GROUP BY ID_BON
HAVING SUM(QTE) > 25;

-- Calculez le coût total des commandes effectuées sur le mois d’avril 
SELECT SUM(A.PRIX * C.QTE) AS COUT_TOTAL
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
JOIN ARTICLE A ON C.ID_ART = A.ID
WHERE MONTH(B.DATE_CMDE) = 4;

-- Sélectionnez les articles qui ont une désignation identique mais des fournisseurs différents (indice : réaliser une auto jointure i.e. de la table avec elle-même)
SELECT DISTINCT A1.ID, A1.DESIGNATION, A1.ID_FOU AS FOURNISSEUR_1, A2.ID_FOU AS FOURNISSEUR_2
FROM ARTICLE A1
JOIN ARTICLE A2 ON A1.DESIGNATION = A2.DESIGNATION AND A1.ID_FOU <> A2.ID_FOU;

-- Calculez les dépenses en commandes mois par mois (indice : utilisation des fonctions MONTH et YEAR)
SELECT YEAR(DATE_CMDE) AS ANNEE, MONTH(DATE_CMDE) AS MOIS, SUM(PRIX * QTE) AS DEPENSES
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
JOIN ARTICLE A ON C.ID_ART = A.ID
GROUP BY YEAR(DATE_CMDE), MONTH(DATE_CMDE);

-- Sélectionnez les bons de commandes sans article (indice : utilisation de EXISTS)
SELECT *
FROM BON B
WHERE NOT EXISTS (
    SELECT 1
    FROM COMPO C
    WHERE C.ID_BON = B.ID
);

-- Calculez le prix moyen des bons de commande par fournisseur
SELECT F.NOM AS FOURNISSEUR, AVG(A.PRIX * C.QTE) AS PRIX_MOYEN
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
JOIN ARTICLE A ON C.ID_ART = A.ID
JOIN FOURNISSEUR F ON B.ID_FOU = F.ID
GROUP BY F.NOM;
