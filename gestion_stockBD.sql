--autre code
drop database if exists Gestion_stock;
CREATE DATABASE Gestion_stock CHARACTER SET 'utf8';
USE Gestion_stock;

DROP TABLE IF EXISTS Commandes ; 
CREATE TABLE Commandes (id_commande VARCHAR(15) NOT NULL, 
                        quantite INT(5) NOT NULL, 
                        date_commande DATE NOT NULL, 
                        id_produit VARCHAR(15), 
                        PRIMARY KEY (id_commande)) ENGINE=InnoDB; 

DROP TABLE IF EXISTS Categories ; 
CREATE TABLE Categories (id_categorie VARCHAR(15) NOT NULL, 
                         nom_categorie VARCHAR(20) NOT NULL, 
                         PRIMARY KEY (id_categorie)) ENGINE=InnoDB;

DROP TABLE IF EXISTS Produits ; 
CREATE TABLE Produits (id_produit VARCHAR(15) NOT NULL, 
                       nom VARCHAR(20) NOT NULL, 
                       description VARCHAR(255) NOT NULL, 
                       prix INT(10) NOT NULL, 
                       stock INT(5) NOT NULL, 
                       id_categorie VARCHAR(15), 
                       id_fournisseur VARCHAR(15), 
                       PRIMARY KEY (id_produit)) ENGINE=InnoDB;

DROP TABLE IF EXISTS Fournisseurs ; 
CREATE TABLE Fournisseurs (id_fournisseur VARCHAR(15) NOT NULL, 
                           nom VARCHAR(20) NOT NULL, 
                           contact VARCHAR(15) NOT NULL, 
                           adresse VARCHAR(20) NOT NULL, 
                           telephone VARCHAR(15) NOT NULL, 
                           PRIMARY KEY (id_fournisseur)) ENGINE=InnoDB;

ALTER TABLE Commandes ADD CONSTRAINT FK_Commandes_id_produit FOREIGN KEY (id_produit) REFERENCES Produits (id_produit); 
ALTER TABLE Produits ADD CONSTRAINT FK_Produits_id_categorie FOREIGN KEY (id_categorie) REFERENCES Categories (id_categorie); 
ALTER TABLE Produits ADD CONSTRAINT FK_Produits_id_fournisseur FOREIGN KEY (id_fournisseur) REFERENCES Fournisseurs (id_fournisseur); 