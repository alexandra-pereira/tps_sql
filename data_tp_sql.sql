-- Suppression des tables précédentes
-- DROP TABLE COMPO ;
-- DROP TABLE BON ;
-- DROP TABLE ARTICLE ;
-- DROP TABLE FOURNISSEUR ;

-- Création des tables
CREATE TABLE ARTICLE (ID int NOT NULL PRIMARY KEY, REF varchar(13) NOT NULL, DESIGNATION varchar(255) NOT NULL, PRIX decimal(7,2) NOT NULL, ID_FOU int NOT NULL);
CREATE TABLE FOURNISSEUR (ID int NOT NULL PRIMARY KEY, NOM varchar(25) NOT NULL);
CREATE TABLE BON (ID int NOT NULL PRIMARY KEY, NUMERO int, DATE_CMDE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, DELAI int, ID_FOU int not null);
CREATE TABLE COMPO (ID int NOT NULL AUTO_INCREMENT PRIMARY KEY, ID_ART int, ID_BON int, QTE int);

-- Ajout des contraintes type « clés étrangères)
ALTER TABLE ARTICLE add constraint FK_ARTICLE_FOU FOREIGN KEY  (ID_FOU) REFERENCES FOURNISSEUR(ID) ;
ALTER TABLE BON add constraint FK_BON_FOU FOREIGN KEY (ID_FOU) REFERENCES FOURNISSEUR(ID) ;
ALTER TABLE COMPO add constraint FK_COMPO_ART FOREIGN KEY (ID_ART) REFERENCES ARTICLE(ID) ;
ALTER TABLE COMPO add constraint FK_COMPO_BON FOREIGN KEY (ID_BON) REFERENCES BON(ID) ;

-- INSERTIONS
Insert into FOURNISSEUR (ID, NOM) values (1, 'Française d''Imports') ;
Insert into FOURNISSEUR (ID, NOM) values (2, 'FDM SA') ;
Insert into FOURNISSEUR (ID, NOM) values (3, 'Dubois & Fils') ;

Insert into ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) values (1, 'A01', 'Perceuse P1', 74.99, 1) ;
Insert into ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) values (2, 'F01', 'Boulon laiton 4 x 40 mm (sachet de 10)', 2.25, 2) ;
Insert into ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) values (3, 'F02', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.45, 2) ;
Insert into ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) values (4, 'D01', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.4, 3) ;
Insert into ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) values (5, 'A02', 'Meuleuse 125mm', 37.85, 1) ;
Insert into ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) values (6, 'D03', 'Boulon acier zingué 4 x 40mm (sachet de 10)', 1.8, 3) ;
Insert into ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) values (7, 'A03', 'Perceuse à colonne', 185.25, 1) ;
Insert into ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) values (8, 'D04', 'Coffret mêches à bois', 12.25, 3) ;
Insert into ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) values (9, 'F03', 'Coffret mêches plates', 6.25, 2) ;
Insert into ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) values (10, 'F04', 'Fraises d’encastrement', 8.14, 2) ;


insert into BON (ID, NUMERO, DELAI, ID_FOU, DATE_CMDE) VALUES (1, 1, 3, 1, '2019-02-08 09:30:00');
insert into COMPO (ID_ART, ID_BON, QTE) values (1, 1, 3);
insert into COMPO (ID_ART, ID_BON, QTE) values (5, 1, 4);
insert into COMPO (ID_ART, ID_BON, QTE) values (7, 1, 1);


insert into BON (ID, NUMERO, DELAI, ID_FOU, DATE_CMDE) VALUES (2, 2, 5, 2, '2019-03-02 09:30:00');
insert into COMPO (ID_ART, ID_BON, QTE) values (2, 2, 25);
insert into COMPO (ID_ART, ID_BON, QTE) values (3, 2, 15);
insert into COMPO (ID_ART, ID_BON, QTE) values (9, 2, 8);
insert into COMPO (ID_ART, ID_BON, QTE) values (10, 2, 11);

insert into BON (ID, NUMERO, DELAI, ID_FOU, DATE_CMDE) VALUES (3, 3, 2, 3, '2019-04-03 17:30:00');
insert into COMPO (ID_ART, ID_BON, QTE) values (4, 3, 25);
insert into COMPO (ID_ART, ID_BON, QTE) values (6, 3, 40);
insert into COMPO (ID_ART, ID_BON, QTE) values (8, 3, 15);

insert into BON (ID, NUMERO, DELAI, ID_FOU, DATE_CMDE) VALUES (4, 4, 2, 3, '2019-04-05 11:40:00');
insert into COMPO (ID_ART, ID_BON, QTE) values (4, 4, 10);
insert into COMPO (ID_ART, ID_BON, QTE) values (6, 4, 15);
insert into COMPO (ID_ART, ID_BON, QTE) values (8, 4, 8);

insert into BON (ID, NUMERO, DELAI, ID_FOU, DATE_CMDE) VALUES (5, 5, 7, 2, '2019-05-15 14:45:00');
insert into COMPO (ID_ART, ID_BON, QTE) values (2, 5, 17);
insert into COMPO (ID_ART, ID_BON, QTE) values (3, 5, 13);
insert into COMPO (ID_ART, ID_BON, QTE) values (10, 5, 9);

insert into BON (ID, NUMERO, DELAI, ID_FOU, DATE_CMDE) VALUES (6, 6, 0, 1, '2019-06-24 18:55:00');


