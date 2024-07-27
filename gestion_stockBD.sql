#creation Base de donnée
drop database if exists Gestion_stock;

CREATE DATABASE Gestion_stock CHARACTER SET 'utf8';

USE Gestion_stock;

DROP TABLE IF EXISTS Categories;

CREATE TABLE Categories (
    id_categorie int(50) NOT NULL auto_increment,
    nom_categorie VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_categorie)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS Fournisseurs;

CREATE TABLE Fournisseurs (
    id_fournisseur int(50) NOT NULL auto_increment,
    nom_fournisseur VARCHAR(50) NOT NULL,
    contact VARCHAR(50) NOT NULL,
    adresse VARCHAR(50) NOT NULL,
    telephone VARCHAR(15) NOT NULL,
    PRIMARY KEY (id_fournisseur)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS Produits;

CREATE TABLE Produits (
    id_produit int(50) auto_increment NOT NULL,
    nom_produit VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL,
    prix REAL NOT NULL,
    stock INT(5) NOT NULL,
    id_categorie int not null,
    id_fournisseur int not null,
    PRIMARY KEY (id_produit),
    foreign key (id_categorie) references Categories(id_categorie),
    foreign key (id_fournisseur) references Fournisseurs(id_fournisseur)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS Commandes;

CREATE TABLE Commandes (
    id_commande int (50) auto_increment NOT NULL,
    quantite INT (5) NOT NULL,
    date_commande DATE NOT NULL,
    id_produit int not null,
    PRIMARY KEY (id_commande),
    foreign key (id_produit) references Produits(id_produit)
) ENGINE = InnoDB;


#insertion des données
INSERT INTO
    Categories (nom_categorie)
VALUES ('Électronique'),
    ('Livres'),
    ('Vêtements');

INSERT INTO
    Fournisseurs (
        nom_fournisseur,
        contact,
        adresse,
        telephone
    )
VALUES (
        'Fournisseur A',
        'contactA@example.com',
        '123 Rue Exemple',
        '0123456789'
    ),
    (
        'Fournisseur B',
        'contactB@example.com',
        '456 Rue Exemple',
        '0123456790'
    ),
    (
        'Fournisseur C',
        'contactC@example.com',
        '789 Rue Exemple',
        '0123456791'
    );

INSERT INTO
    Produits (
        nom_produit,
        description,
        prix,
        stock,
        id_categorie,
        id_fournisseur
    )
VALUES (
        'Ordinateur Portable',
        'Ordinateur portable haute performance',
        1200.00,
        50,
        1,
        1
    ),
    (
        'Livre de Programmation',
        'Livre pour apprendre à programmer',
        35.00,
        150,
        2,
        2
    ),
    (
        'T-shirt',
        'T-shirt en coton',
        20.00,
        200,
        3,
        3
    );
    
insert into Commandes (quantite, date_commande, id_produit)
values 
	(20, now(), 1),
	(10, date_add(now(), interval 3 day), 2),
	(30, date_add(now(), interval 5 day), 3);

#Mise à jour d'un produit d'id = P1
/*
UPDATE Produits
SET
    prix = 1300.00,
    description = 'Ordinateur portable haute performance avec écran 4K'
WHERE
    id_produit = 'P1';

#Mise à jour d'un fournisseur d'id = F1
UPDATE Fournisseurs
SET
    contact = 'nouveauContactA@example.com',
    adresse = '456 Nouvelle Rue Exemple'
WHERE
    id_fournisseur = 'F1';

#Supprimez une commande spécifique
DELETE FROM Commandes WHERE id_commande = 'C1';
*/