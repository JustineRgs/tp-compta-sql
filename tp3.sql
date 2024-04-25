CREATE TABLE FOURNISSEUR (
    id_fournisseur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50)
);


CREATE TABLE ARTICLE (
    id_article INT AUTO_INCREMENT PRIMARY KEY,
    ref VARCHAR(255),
    designation VARCHAR(255),
    prix DECIMAL(7, 2),
    id_fournisseur INT,
    FOREIGN KEY (id_fournisseur) REFERENCES FOURNISSEUR(id_fournisseur)
);


CREATE TABLE BON (
    id_bon INT AUTO_INCREMENT PRIMARY KEY,
    numero INT(10),
    date_cmde TIMESTAMP,
    delai INT(10),
    id_fournisseur INT,
    FOREIGN KEY (id_fournisseur) REFERENCES FOURNISSEUR(id_fournisseur)
);


CREATE TABLE COMPO (
    id_article INT,
    id_bon INT,
    quantite INT,
    PRIMARY KEY (id_article, id_bon),
    FOREIGN KEY (id_article) REFERENCES ARTICLE(id_article),
    FOREIGN KEY (id_bon) REFERENCES BON(id_bon)
);


INSERT INTO fournisseur (nom) VALUES ('Française d’Imports');
INSERT INTO fournisseur (nom) VALUES ('FDM SA');
INSERT INTO fournisseur (nom) VALUES ('Dubois & Fils');

INSERT INTO `article`(`ref`, `designation`, `prix`, `id_fournisseur`) VALUES ("A01", "Perceuse P1", 74.99, 1);
INSERT INTO `article`(`ref`, `designation`, `prix`, `id_fournisseur`) VALUES ("F01", "Boulon laiton 4 x 40 mm (sachet de 10) ", 2.25, 2);
INSERT INTO `article`(`ref`, `designation`, `prix`, `id_fournisseur`) VALUES ("F02", "Boulon laiton 4 x 40 mm (sachet de 10) ", 4.45, 2);
INSERT INTO `article`(`ref`, `designation`, `prix`, `id_fournisseur`) VALUES ("D01", "Boulon laiton 4 x 40 mm (sachet de 10) ", 4.40, 3);
INSERT INTO `article`(`ref`, `designation`, `prix`, `id_fournisseur`) VALUES ("A02", "Meuleuse 125mm", 37.85, 1);
INSERT INTO `article`(`ref`, `designation`, `prix`, `id_fournisseur`) VALUES ("D03", "Boulon acier zingué 4 x 40mm (sachet de 10)", 1.8, 3);
INSERT INTO `article`(`ref`, `designation`, `prix`, `id_fournisseur`) VALUES ("A03", "Perceuse à colonne", 185.25, 1);
INSERT INTO `article`(`ref`, `designation`, `prix`, `id_fournisseur`) VALUES ("D04", "Coffret mêches à bois", 12.25, 3);
INSERT INTO `article`(`ref`, `designation`, `prix`, `id_fournisseur`) VALUES ("F03", "Coffret mêches plates", 6.25, 2);
INSERT INTO `article`(`ref`, `designation`, `prix`, `id_fournisseur`) VALUES ("F04", "Fraises d’encastrement", 8.14, 2);

INSERT INTO `bon`(`numero`, `date_cmde`, `delai`, `id_fournisseur`) VALUES (1, '2024-04-25', 3, 1);

INSERT INTO `compo`(`id_article`, `id_bon`, `quantite`) VALUES (1,1,3);
INSERT INTO `compo`(`id_article`, `id_bon`, `quantite`) VALUES (5,1,4);
INSERT INTO `compo`(`id_article`, `id_bon`, `quantite`) VALUES (7,1,1);