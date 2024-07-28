#Ma base de données : 
#-----------------------------------------------------------------------------------------
# 1. database creation
#-----------------------------------------------------------------------------------------
SELECT "***************CREATION DE LA BASE DE DONNEES*************************";
drop database if exists Gestion_stock;

CREATE DATABASE Gestion_stock CHARACTER SET 'utf8';

USE Gestion_stock;

#-----------------------------------------------------------------------------------------
# 2. tables creation
#-----------------------------------------------------------------------------------------
SELECT "***************CREATION DES TABLES****************************\n";
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
    statut_commande bool NOT NULL Default False,
    PRIMARY KEY (id_commande),
    foreign key (id_produit) references Produits(id_produit)
) ENGINE = InnoDB;


#-----------------------------------------------------------------------------------------
# 3. inserting data in tables
#-----------------------------------------------------------------------------------------
SELECT "******************INSERTION DES DONNEES DANS LES TABLES*******************\n";
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
VALUES 
    ('Fournisseur A', 'contactA@example.com','123 Rue Exemple', '0123456789' ),
    ('Fournisseur B', 'contactB@example.com', '456 Rue Exemple','0123456790'),
    ('Fournisseur C', 'contactC@example.com','789 Rue Exemple','0123456791');

INSERT INTO
    Produits (
        nom_produit,
        description,
        prix,
        stock,
        id_categorie,
        id_fournisseur
    )
VALUES 
    ('Ordinateur Portable', 'Ordinateur portable haute performance', 1200.00, 50, 1, 1 ),
    ('Livre de Programmation','Livre pour apprendre à programmer', 35.00, 150, 2,2),
    ('T-shirt', 'T-shirt en coton', 20.00, 200, 3, 3);
    
insert into Commandes (quantite, date_commande, id_produit, statut_commande)
values 
	(20, now(), 1, 1),
	(10, date_add(now(), interval 3 day), 2, 1),
	(30, date_add(now(), interval 5 day), 3, 0);

#-----------------------------------------------------------------------------------------
# 4. procedure and function
#-----------------------------------------------------------------------------------------
SELECT "*****************CREATION PROCEDURE to add an order***********************\n";

drop procedure if exists newCommande;
delimiter //
create procedure newCommande(in id_prod int, in qté int)
begin 
	insert into Commandes value(0, qté, now(), id_prod, false);
end //
delimiter ;

# function pour verifier la disponibilites d_un produit 

drop function if exists isProduct;
delimiter //
create function isProduct(id_prod int)
returns boolean
deterministic
begin 
	declare qte int;
    select stock into qte from Produits where id_produit = id_prod;
    if qte > 0 then
		return true;
	else 
		return false;
	end if;
end //
delimiter ;

#-----------------------------------------------------------------------------------------
# 5. view and trigger 
#-----------------------------------------------------------------------------------------
SELECT "*********************VIEW AND TRIGGER*********************************\n";
drop trigger if exists addStock;
delimiter //
create trigger addStock
after insert on Commandes
for each row
begin
	declare currentStock int;
    select stock into currentStock from Produits where Produits.id_produit = new.id_produit;
    update Produits set stock = new.quantite + currentStock where Produits.id_produit = new.id_produit;
end //
delimiter ;


drop trigger if exists reduceStock;
delimiter //
create trigger reduceStock
after delete on Commandes
for each row
begin
    declare currentStock int;
    select stock into currentStock from Produits where Produits.id_produit = old.id_produit;
    update Produits set stock = currentStock - old.quantite where Produits.id_produit = old.id_produit;
end //
delimiter ;



drop view if exists CommandeDetails;
create view CommandeDetails as
select Produits.nom_produit, Fournisseurs.nom_fournisseur, Commandes.quantite, Commandes.date_commande, Commandes.id_commande
from Produits 
join Fournisseurs
	on Produits.id_fournisseur = Fournisseurs.id_fournisseur
join Commandes
	on Commandes.id_produit = Produits.id_produit ;
	
select*from CommandeDetails ;


#----------------------------------------------------------------------------------------
# 6. sql queries
#----------------------------------------------------------------------------------------

#Requête pour lister les produits par catégorie
Select Produits.nom_produit, Categories.nom_categorie
from Produits
join Categories
	on Produits.id_categorie = Categories.id_categorie
where Categories.nom_categorie = 'Électronique' ;


#Requête pour trouver les fournisseurs dun certain produit
Select Produits.nom_produit, Fournisseurs.nom_fournisseur
from Produits
join Fournisseurs
	on Produits.id_fournisseur = Fournisseurs.id_fournisseur
where Produits.nom_produit = 'Ordinateur Portable' ;


#Requête pour lister les commandes en cours pour un produit
Select Produits.id_produit as id ,Produits.nom_produit, Commandes.statut_commande as Encours
from Produits
join Commandes
	on Commandes.id_produit = Produits.id_produit
where Produits.nom_produit = 'Ordinateur Portable' ;


#Requête pour compter le nombre total de commandes par produit
Select Produits.id_produit as id ,Produits.nom_produit, COUNT(Commandes.id_commande) as nbre_commande
from Produits
join Commandes
	on Commandes.id_produit = Produits.id_produit

Group by (Commandes.id_commande);
