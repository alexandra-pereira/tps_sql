-- se connecter à la base de données
mysql -u root -p

-- Création de la base de données 'compta'
CREATE DATABASE compta CHARACTER SET UTF8 COLLATE utf8_general_ci;
USE compta;

-- Création des tables
CREATE TABLE FOURNISSEUR (
    ID INT PRIMARY KEY,
    NOM VARCHAR(100) NOT NULL
);

CREATE TABLE ARTICLE (
    ID INT PRIMARY KEY,
    REF VARCHAR(50) NOT NULL,
    DESIGNATION VARCHAR(255) NOT NULL,
    PRIX DECIMAL(10,2) NOT NULL,
    ID_FOU INT,
    CONSTRAINT FK_ARTICLE_FOU FOREIGN KEY (ID_FOU) REFERENCES FOURNISSEUR(ID)
);

CREATE TABLE BON (
    ID INT PRIMARY KEY,
    NUMERO VARCHAR(50) NOT NULL,
    DATE_CMDE DATE NOT NULL,
    DELAI INT NOT NULL,
    ID_FOU INT,
    CONSTRAINT FK_BON_FOU FOREIGN KEY (ID_FOU) REFERENCES FOURNISSEUR(ID)
);

CREATE TABLE COMPO (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    QTE INT NOT NULL,
    ID_ART INT,
    ID_BON INT,
    CONSTRAINT FK_COMPO_ART FOREIGN KEY (ID_ART) REFERENCES ARTICLE(ID),
    CONSTRAINT FK_COMPO_BON FOREIGN KEY (ID_BON) REFERENCES BON(ID)
);

-- Insertion des fournisseurs
INSERT INTO FOURNISSEUR (ID, NOM) VALUES
(1, 'Française d’Imports'),
(2, 'FDM SA'),
(3, 'Dubois & Fils');

-- Insertion des articles
INSERT INTO ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) VALUES
(1, 'A01', 'Perceuse P1', 74.99, 1),
(2, 'F01', 'Boulon laiton 4 x 40 mm (sachet de 10)', 2.25, 2),
(3, 'F02', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.45, 2),
(4, 'D01', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.40, 3),
(5, 'A02', 'Meuleuse 125mm', 37.85, 1),
(6, 'D03', 'Boulon acier zingué 4 x 40mm (sachet de 10)', 1.80, 3),
(7, 'A03', 'Perceuse à colonne', 185.25, 1),
(8, 'D04', 'Coffret mêches à bois', 12.25, 3),
(9, 'F03', 'Coffret mêches plates', 6.25, 2),
(10, 'F04', 'Fraises d’encastrement', 8.14, 2);

-- Insertion d'un bon de commande
INSERT INTO BON (ID, NUMERO, DATE_CMDE, DELAI, ID_FOU) VALUES
(1, '001', '2024-10-20', 3, 1);

-- Composition du bon de commande
INSERT INTO COMPO (QTE, ID_ART, ID_BON) VALUES
(3, 1, 1),  -- 3 perceuses P1
(4, 5, 1),  -- 4 meuleuses 125mm
(1, 7, 1);  -- 1 perceuse à colonne

-- Requêtes basiques
-- a. Listez toutes les données concernant les articles
SELECT * FROM ARTICLE;

-- b. Listez uniquement les références et désignations des articles de plus de 2 euros
SELECT REF, DESIGNATION FROM ARTICLE WHERE PRIX > 2;

-- c. Listez tous les articles dont le prix est compris entre 2 et 6.25 euros (opérateurs de comparaison)
SELECT * FROM ARTICLE WHERE PRIX >= 2 AND PRIX <= 6.25;

-- d. Listez tous les articles dont le prix est compris entre 2 et 6.25 euros (opérateur BETWEEN)
SELECT * FROM ARTICLE WHERE PRIX BETWEEN 2 AND 6.25;

-- e. Listez tous les articles dont le prix n’est pas compris entre 2 et 6.25 euros et dont le fournisseur est Française d’Imports
SELECT * FROM ARTICLE WHERE (PRIX < 2 OR PRIX > 6.25) AND ID_FOU = 1;

-- f. Listez tous les articles dont les fournisseurs sont Française d’Imports ou Dubois et Fils (opérateurs logiques)
SELECT * FROM ARTICLE WHERE ID_FOU = 1 OR ID_FOU = 3;

-- g. Même requête avec l’opérateur IN
SELECT * FROM ARTICLE WHERE ID_FOU IN (1, 3);

-- h. Listez tous les articles dont les fournisseurs ne sont ni Française d’Imports, ni Dubois et Fils (opérateurs NOT et IN)
SELECT * FROM ARTICLE WHERE ID_FOU NOT IN (1, 3);

-- i. Listez tous les bons de commande dont la date de commande est entre le 01/02/2019 et le 30/04/2019
SELECT * FROM BON WHERE DATE_CMDE BETWEEN '2019-02-01' AND '2019-04-30';


-- TP 05 – Requêtes avancées

-- a. Listez les articles dans l’ordre alphabétique des désignations
SELECT * FROM ARTICLE
ORDER BY DESIGNATION;

-- b. Listez les articles dans l’ordre des prix du plus élevé au moins élevé
SELECT * FROM ARTICLE
ORDER BY PRIX DESC;

-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant
SELECT * FROM ARTICLE
WHERE DESIGNATION LIKE '%boulon%'
ORDER BY PRIX ASC;

-- d. Listez tous les articles dont la désignation contient le mot « sachet »
SELECT * FROM ARTICLE
WHERE DESIGNATION LIKE '%sachet%';

-- e. Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse
SELECT * FROM ARTICLE
WHERE LOWER(DESIGNATION) LIKE '%sachet%';

-- f. Listez les articles avec les informations fournisseur correspondantes
-- Les résultats doivent être triées dans l’ordre alphabétique des fournisseurs et par article du prix le plus élevé au moins élevé
SELECT ARTICLE.*, FOURNISSEUR.NOM AS FOURNISSEUR_NOM 
FROM ARTICLE
JOIN FOURNISSEUR ON ARTICLE.ID_FOU = FOURNISSEUR.ID
ORDER BY FOURNISSEUR.NOM, PRIX DESC;

-- g. Listez les articles de la société « Dubois & Fils »
SELECT * FROM ARTICLE
WHERE ID_FOU = (SELECT ID FROM FOURNISSEUR WHERE NOM = 'Dubois & Fils');

-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT AVG(PRIX) AS MOYENNE_PRIX
FROM ARTICLE
WHERE ID_FOU = (SELECT ID FROM FOURNISSEUR WHERE NOM = 'Dubois & Fils');

-- i. Calculez la moyenne des prix des articles de chaque fournisseur
SELECT FOURNISSEUR.NOM, AVG(ARTICLE.PRIX) AS MOYENNE_PRIX
FROM ARTICLE
JOIN FOURNISSEUR ON ARTICLE.ID_FOU = FOURNISSEUR.ID
GROUP BY FOURNISSEUR.NOM;

-- j. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00
SELECT * FROM BON
WHERE DATE_CMDE BETWEEN '2019-03-01' AND '2019-04-05 12:00:00';

-- k. Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT DISTINCT BON.* 
FROM BON
JOIN COMPO ON BON.ID = COMPO.ID_BON
JOIN ARTICLE ON COMPO.ID_ART = ARTICLE.ID
WHERE ARTICLE.DESIGNATION LIKE '%boulon%';

-- l. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé
SELECT DISTINCT BON.*, FOURNISSEUR.NOM AS FOURNISSEUR_NOM
FROM BON
JOIN COMPO ON BON.ID = COMPO.ID_BON
JOIN ARTICLE ON COMPO.ID_ART = ARTICLE.ID
JOIN FOURNISSEUR ON ARTICLE.ID_FOU = FOURNISSEUR.ID
WHERE ARTICLE.DESIGNATION LIKE '%boulon%';

-- m. Calculez le prix total de chaque bon de commande
SELECT BON.NUMERO, SUM(ARTICLE.PRIX * COMPO.QTE) AS PRIX_TOTAL
FROM BON
JOIN COMPO ON BON.ID = COMPO.ID_BON
JOIN ARTICLE ON COMPO.ID_ART = ARTICLE.ID
GROUP BY BON.NUMERO;

-- n. Comptez le nombre d’articles de chaque bon de commande
SELECT BON.NUMERO, COUNT(COMPO.ID_ART) AS NOMBRE_ARTICLES
FROM BON
JOIN COMPO ON BON.ID = COMPO.ID_BON
GROUP BY BON.NUMERO;

-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d’articles de chacun de ces bons de commande
SELECT BON.NUMERO, COUNT(COMPO.ID_ART) AS NOMBRE_ARTICLES
FROM BON
JOIN COMPO ON BON.ID = COMPO.ID_BON
GROUP BY BON.NUMERO
HAVING COUNT(COMPO.ID_ART) > 25;

-- p. Calculez le coût total des commandes effectuées sur le mois d’avril
SELECT SUM(ARTICLE.PRIX * COMPO.QTE) AS COUT_TOTAL_AVRIL
FROM BON
JOIN COMPO ON BON.ID = COMPO.ID_BON
JOIN ARTICLE ON COMPO.ID_ART = ARTICLE.ID
WHERE MONTH(BON.DATE_CMDE) = 4 AND YEAR(BON.DATE_CMDE) = 2019;

-- 3) Requêtes plus difficiles (facultatives)

-- a. Sélectionnez les articles qui ont une désignation identique mais des fournisseurs différents
SELECT A1.ID, A1.DESIGNATION, A1.ID_FOU AS FOURNISSEUR_1, A2.ID_FOU AS FOURNISSEUR_2
FROM ARTICLE A1
JOIN ARTICLE A2 ON A1.DESIGNATION = A2.DESIGNATION AND A1.ID_FOU <> A2.ID_FOU;

-- b. Calculez les dépenses en commandes mois par mois
SELECT YEAR(BON.DATE_CMDE) AS ANNEE, MONTH(BON.DATE_CMDE) AS MOIS, SUM(ARTICLE.PRIX * COMPO.QTE) AS TOTAL_DEPENSES
FROM BON
JOIN COMPO ON BON.ID = COMPO.ID_BON
JOIN ARTICLE ON COMPO.ID_ART = ARTICLE.ID
GROUP BY YEAR(BON.DATE_CMDE), MONTH(BON.DATE_CMDE)
ORDER BY ANNEE, MOIS;

-- c. Sélectionnez les bons de commandes sans article
SELECT * FROM BON
WHERE NOT EXISTS (
    SELECT 1 FROM COMPO WHERE COMPO.ID_BON = BON.ID
);

-- d. Calculez le prix moyen des bons de commande par fournisseur
SELECT FOURNISSEUR.NOM, AVG(SUM(ARTICLE.PRIX * COMPO.QTE)) AS PRIX_MOYEN
FROM BON
JOIN COMPO ON BON.ID = COMPO.ID_BON
JOIN ARTICLE ON COMPO.ID_ART = ARTICLE.ID
JOIN FOURNISSEUR ON BON.ID_FOU = FOURNISSEUR.ID
GROUP BY FOURNISSEUR.NOM;


-- TP 06  Mise à jour de données 

-- 1) Désactivation du mode « safe update »
SET SQL_SAFE_UPDATES = 0;

-- 2) Requête a : Mettez en majuscules les désignations de tous les articles dont le prix est strictement supérieur à 10€
UPDATE ARTICLE
SET DESIGNATION = UPPER(DESIGNATION)
WHERE PRIX > 10;

-- 3) Requête b : Mettez en minuscules la désignation de l’article dont l’identifiant est 2
UPDATE ARTICLE
SET DESIGNATION = LOWER(DESIGNATION)
WHERE ID = 2;

-- 4) Requête c : Augmentez les prix de 10% pour tous les articles du fournisseur FDM SA
UPDATE ARTICLE A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
SET A.PRIX = A.PRIX * 1.10
WHERE F.NOM = 'FDM SA';


