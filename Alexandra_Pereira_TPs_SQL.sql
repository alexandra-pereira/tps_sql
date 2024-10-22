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
