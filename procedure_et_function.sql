#procedure pour ajouter une commande

drop procedure if exists newCommande;
delimiter //
create procedure newCommande(in id_prod int, in qté int)
begin 
	insert into Commandes value(0, qté, now(), id_prod, false);
end //
delimiter ;

# function pour verifier la disponibilites d'un produit

drop function if exists isProduct
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
