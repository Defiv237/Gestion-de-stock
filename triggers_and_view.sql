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
	
select*from CommandeDetails 
