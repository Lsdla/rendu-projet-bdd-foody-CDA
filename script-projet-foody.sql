--création de la data base
DROP database IF EXISTS foody;
CREATE database foody;

-- crétaion de la table client
CREATE TABLE Client (
    Codecli VARCHAR(5) NOT NULL PRIMARY KEY,
    Societe VARCHAR(45) NOT NULL,
    Contact VARCHAR(45) NOT NULL,
    Fonction VARCHAR(45) NOT NULL,
    Adresse VARCHAR(45),
    Ville VARCHAR(30) ,
    Region VARCHAR(30),
    Codepostal VARCHAR(10),
    Pays VARCHAR(30) ,
    Tel VARCHAR(30) ,
    Fax VARCHAR(30)
)ENGINE=InnoDB;

-- création de la table message
CREATE TABLE Messager (
    NoMess INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    NomMess VARCHAR(50) NOT NULL,
    Tel VARCHAR(20)
)ENGINE=InnoDB;

-- création de la table employe
CREATE TABLE Employe (
    NoEmp INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Nom VARCHAR(50) NOT NULL,
    Prenom VARCHAR(50) NOT NULL,
    Fonction VARCHAR(50) ,
    TitreCourtoisie VARCHAR(50),
    DateNaissance DATETIME,
    DateEmbauche DATETIME ,
    Adresse VARCHAR(60),
    Ville VARCHAR(50),
    Region VARCHAR(50),
    Codepostal VARCHAR(50) ,
    Pays VARCHAR(50) ,
    TelDom VARCHAR(20) ,
    Extension VARCHAR(50),
    RendCompteA INT,
    CONSTRAINT `FK_RendCompteA` FOREIGN KEY (RendCompteA) REFERENCES Employe (NoEmp)
)ENGINE=InnoDB;

-- création de la table commande 
CREATE TABLE Commande (
    NoCom INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    CodeCli VARCHAR(10) ,
    NoEmp INT,
    DateCom DATETIME ,
    ALivAvant DATETIME,
    DateEnv DATETIME,
    NoMess INT ,
    Port DECIMAL(10,4) DEFAULT 0,
    Destinataire VARCHAR(50) ,
    AdrLiv VARCHAR(50) ,
    VilleLiv VARCHAR(50) ,
    RegionLiv VARCHAR(50),
    CodePostalLiv VARCHAR(20),
    PaysLiv VARCHAR(25),
    CONSTRAINT `FK_NoMess` FOREIGN KEY (NoMess) REFERENCES Messager (NoMess),
    CONSTRAINT `FK_CodeCli` FOREIGN KEY (CodeCli) REFERENCES Client (CodeCli),
    CONSTRAINT `FK_NoEmp` FOREIGN KEY (NoEmp) REFERENCES Employe (NoEmp)
)ENGINE=InnoDB;

-- création de la table fournisseur
CREATE TABLE Fournisseur (
    NoFour INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Societe VARCHAR(45) NOT NULL,
    Contact VARCHAR(45) ,
    Fonction VARCHAR(45) ,
    Adresse VARCHAR(255) ,
    Ville VARCHAR(45),
    Region VARCHAR(45),
    CodePostal VARCHAR(10) ,
    Pays VARCHAR(45) ,
    Tel VARCHAR(20) ,
    Fax VARCHAR(20),
    PageAccueil MEDIUMTEXT
)ENGINE=InnoDB;

-- création de la table categorie
CREATE TABLE Categorie (
    CodeCateg INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    NomCateg VARCHAR(15) NOT NULL,
    Descriptionn VARCHAR(255)
)ENGINE=InnoDB;

-- création de la table produit
CREATE TABLE Produit (
    RefProd INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    NomProd VARCHAR(50) NOT NULL,
    NoFour INT,
    CodeCateg INT,
    QteParUnit VARCHAR(20),
    PrixUnit DECIMAL(10,4) default 0,
    UnitesStock INT DEFAULT 0,
    UnitesCom INT DEFAULT 0,
    NiveauReap INT DEFAULT 0,
    Indisponible INT NOT NULL default 0,
    CONSTRAINT `FK_NoFour` FOREIGN KEY (NoFour) REFERENCES Fournisseur (NoFour),
    CONSTRAINT `FK_CodeCateg` FOREIGN KEY (CodeCateg) REFERENCES Categorie (CodeCateg)
)ENGINE=InnoDB;

-- création de la table detailCommande 
CREATE TABLE DetailCommande (
    NoCom INT NOT NULL,
    RefProd INT NOT NULL,
    PrixUnit DECIMAL(10,4) NOT NULL DEFAULT 0,
    Qte INT NOT NULL DEFAULT 1,
    Remise% Double NOT NULL DEFAULT 0,
    CONSTRAINT `PK_DetailCommande` PRIMARY KEY (NoCom , RefProd),
    CONSTRAINT `FK_NoCom` FOREIGN KEY (NoCom) REFERENCES Commande (NoCom),
    CONSTRAINT `FK_RefProd` FOREIGN KEY (RefProd) REFERENCES Produit (RefProd),
)ENGINE=InnoDB;

--exemple de load file pour une table Client, faut faire la même chose pour les autres noms de table.
LOAD DATA LOCAL INFILE '/Users/Lyes/Desktop/formation-simplon/cours/Concepteur-developeur-application/bdd/exo/data/Client.csv' INTO TABLE foody.Client FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n' IGNORE 1 LINES;






