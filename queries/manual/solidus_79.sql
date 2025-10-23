SELECT DISTINCT p.* FROM spree_promotions p INNER JOIN spree_orders_promotions op ON p.id = op.promotion_id;
