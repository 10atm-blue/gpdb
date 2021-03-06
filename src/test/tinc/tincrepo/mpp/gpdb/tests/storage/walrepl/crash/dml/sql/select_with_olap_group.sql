-- start_ignore
SET gp_create_table_random_default_distribution=off;
-- end_ignore
--
-- STANDARD DATA FOR olap_* TESTS.
--
-- start_ignore
drop table if exists product;
drop table if exists sale;
-- end_ignore

create table product 
(
    pn int not null,
    pname text not null,
    pcolor text,
    
    primary key (pn)
    
) distributed by (pn);

create table sale
(
    cn int not null,
    vn int not null,
    pn int not null,
    dt date not null,
    qty int not null,
    prc float not null,
    
    primary key (cn, vn, pn) 
    
) distributed by (cn,vn,pn);


-- Products
insert into product values 
  ( 100, 'Sword', 'Black'),
  ( 200, 'Dream', 'Black'),
  ( 300, 'Castle', 'Grey'),
  ( 400, 'Justice', 'Clear'),
  ( 500, 'Donuts', 'Plain'),
  ( 600, 'Donuts', 'Chocolate'),
  ( 700, 'Hamburger', 'Grey'),
  ( 800, 'Fries', 'Grey');


-- Sales (transactions)
insert into sale values 
  ( 2, 40, 100, '1401-1-1', 1100, 2400),
  ( 1, 10, 200, '1401-3-1', 1, 0), 
  ( 3, 40, 200, '1401-4-1', 1, 0), 
  ( 1, 20, 100, '1401-5-1', 1, 0), 
  ( 1, 30, 300, '1401-5-2', 1, 0), 
  ( 1, 50, 400, '1401-6-1', 1, 0), 
  ( 2, 50, 400, '1401-6-1', 1, 0), 
  ( 1, 30, 500, '1401-6-1', 12, 5), 
  ( 3, 30, 500, '1401-6-1', 12, 5), 
  ( 3, 30, 600, '1401-6-1', 12, 5), 
  ( 4, 40, 700, '1401-6-1', 1, 1), 
  ( 4, 40, 800, '1401-6-1', 1, 1); 

SELECT sale.pn,sale.qty,sale.prc,sale.prc, TO_CHAR(COALESCE(AVG(DISTINCT floor(sale.vn)),0),'99999999.9999999'),TO_CHAR(COALESCE(STDDEV_SAMP(floor(sale.pn+sale.pn)),0),'99999999.9999999'),TO_CHAR(COALESCE(STDDEV(floor(sale.prc+sale.vn)),0),'99999999.9999999'),TO_CHAR(COALESCE(AVG(floor(sale.cn)),0),'99999999.9999999'),TO_CHAR(COALESCE(VAR_SAMP(floor(sale.qty+sale.vn)),0),'99999999.9999999'),TO_CHAR(COALESCE(STDDEV_SAMP(floor(sale.pn)),0),'99999999.9999999') 
FROM sale,product
WHERE sale.pn=product.pn
GROUP BY CUBE((sale.vn,sale.pn),(sale.cn,sale.vn),(sale.cn,sale.cn),(sale.qty,sale.dt)),ROLLUP((sale.qty,sale.vn,sale.cn),(sale.dt,sale.dt)),sale.prc;
