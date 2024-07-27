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
