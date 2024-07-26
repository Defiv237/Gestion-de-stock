drop trigger if exists updateStock;
delimiter //
create trigger updateStock
after insert on Commandes
for each row
begin
	declare currentStock int;
    select stock into currentStock from Produits where Produits.id_produit = new.id_produit;
    update Produits set stock = new.quantite + currentStock where Produits.id_produit = new.id_produit;
end //
delimiter ;