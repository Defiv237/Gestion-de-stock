#creation Base de donnée
drop database if exists Gestion_stock;

CREATE DATABASE Gestion_stock CHARACTER SET 'utf8';

USE Gestion_stock;

DROP TABLE IF EXISTS Commandes;

CREATE TABLE Commandes (
    id_commande VARCHAR(15) NOT NULL,
    quantite INT(5) NOT NULL,
    date_commande DATE NOT NULL,
    id_produit VARCHAR(15),
    PRIMARY KEY (id_commande)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS Categories;

CREATE TABLE Categories (
    id_categorie VARCHAR(15) NOT NULL,
    nom_categorie VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_categorie)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS Produits;

CREATE TABLE Produits (
    id_produit VARCHAR(15) NOT NULL,
    nom VARCHAR(20) NOT NULL,
    description VARCHAR(255) NOT NULL,
    prix INT(10) NOT NULL,
    stock INT(5) NOT NULL,
    id_categorie VARCHAR(15),
    id_fournisseur VARCHAR(15),
    PRIMARY KEY (id_produit)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS Fournisseurs;

CREATE TABLE Fournisseurs (
    id_fournisseur VARCHAR(15) NOT NULL,
    nom VARCHAR(20) NOT NULL,
    contact VARCHAR(15) NOT NULL,
    adresse VARCHAR(20) NOT NULL,
    telephone VARCHAR(15) NOT NULL,
    PRIMARY KEY (id_fournisseur)
) ENGINE = InnoDB;

ALTER TABLE Commandes
ADD CONSTRAINT FK_Commandes_id_produit FOREIGN KEY (id_produit) REFERENCES Produits (id_produit);

ALTER TABLE Produits
ADD CONSTRAINT FK_Produits_id_categorie FOREIGN KEY (id_categorie) REFERENCES Categories (id_categorie);

ALTER TABLE Produits
ADD CONSTRAINT FK_Produits_id_fournisseur FOREIGN KEY (id_fournisseur) REFERENCES Fournisseurs (id_fournisseur);


#insertion des données
INSERT INTO
    Categories (id_categorie, nom_categorie)
VALUES ('C1', 'Électronique'),
    ('C2', 'Livres'),
    ('C3', 'Vêtements');

INSERT INTO
    Fournisseurs (
        id_fournisseur,
        nom,
        contact,
        adresse,
        telephone
    )
VALUES (
        'F1',
        'Fournisseur A',
        'contactA@example.com',
        '123 Rue Exemple',
        '0123456789'
    ),
    (
        'F2',
        'Fournisseur B',
        'contactB@example.com',
        '456 Rue Exemple',
        '0123456790'
    ),
    (
        'F3',
        'Fournisseur C',
        'contactC@example.com',
        '789 Rue Exemple',
        '0123456791'
    );

INSERT INTO
    Produits (
        id_produit,
        nom,
        description,
        prix,
        stock,
        id_categorie,
        id_fournisseur
    )
VALUES (
        'P4',
        'Ordinateur Portable',
        'Ordinateur portable haute performance',
        1200.00,
        50,
        'C1',
        'F1'
    ),
    (
        'P5',
        'Livre de Programmation',
        'Livre pour apprendre à programmer',
        35.00,
        150,
        'C2',
        'F2'
    ),
    (
        'P6',
        'T-shirt',
        'T-shirt en coton',
        20.00,
        200,
        'C3',
        'F3'
    );