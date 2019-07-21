-- Consultas de granja de postura

-- Consulta 1

select 
	p.nombre as Plantel,
    g.nombre as Galpon,
    c.razonSocial as Cabaña
from plantel p 
	inner join genetica g on p.genetica_idGenetica = g.idGenetica 
    inner join cabaña c on g.cabaña_cuit = c.cuit

order by p.idPlantel asc;


-- Consulta 2

select 
	sum(g.cantidad) as 'Total de gallinas'
from galpon g;


-- Consulta 3

select 
	p.nombre as Plantel,
	g.idGalpon as Galpon,    
	sum(cantidad) as 'Gallina por galpon'
from galpon g 
inner join plantel p on g.plantel_idPlantel = p.idPlantel

group by g.idGalpon order by p.idPlantel asc;


-- Consulta 4

select 
	g2.cantidad * 100 / (select sum(g1.cantidad) as total from galpon g1) as 'Porcentaje del total %'
    
from galpon g2
order by g2.idGalpon asc;
	

-- Consulta 5

select 
	g2.idGalpon,
	g2.plantel_idPlantel,
	g2.cantidad * 100 / (select 
							sum(g1.cantidad) 
						 from plantel p 
							inner join galpon g1 on p.idPlantel = g1.plantel_idPlantel
						 where g2.plantel_idPlantel = p.idPlantel) 
	as 'Porcentaje del plantel %'
    
from galpon g2
order by g2.idGalpon asc;
	

-- Consulta 6

select
	*
from genetica g
where 
	not exists (select * from plantel p 
				where p.genetica_idGenetica = g.idGenetica);
                
select gen.idGenetica, gen.nombre from plantel p 
	inner join genetica gen on p.genetica_idGenetica = gen.idGenetica
where not exists (select * from galpon g inner join plantel p1 on p1.idPlantel = g.plantel_idPlantel
			where p.idPlantel = g.plantel_idPlantel);


-- Consulta 7

-- select 
-- 	i.tipoAlimento as 'Tipo de alimento',
--     (select sum(i2.cantAlimento) 
--      from informe i2
--      where i2.tipoAlimento = i.tipoAlimento) as 'Cantidad por tipo'
-- from informe i
-- group by tipoAlimento;

select 
	i.tipoAlimento as 'Tipo de alimento', sum(i.cantAlimento) as Suma
from informe i
group by tipoAlimento;


-- Consulta 8

-- select distinct
-- 	i.tipoAlimento as 'Tipo de alimento',
--     (select sum(i2.cantAlimento) 
--      from informe i2
--      where i2.tipoAlimento = i.tipoAlimento) as 'Cantidad por tipo'
-- from informe i
-- where
-- 	'Cantidad por tipo' > (select avg(i3.cantAlimento) from informe i3)
-- group by tipoAlimento;

select 
	i.tipoAlimento as 'Tipo de alimento', sum(i.cantAlimento) as Suma
from informe i
group by i.tipoAlimento
having sum(i.cantAlimento) > avg(i.cantAlimento);


-- Consulta 9 	REVISAR ENUNCIADO

-- select distinct
-- 	i.tipoAlimento as 'Tipo de alimento',
--     (select sum(i2.cantAlimento) 
--      from informe i2
--      where i2.tipoAlimento = i.tipoAlimento) as 'Cantidad por tipo'
-- from informe i
-- where
-- 	'Cantidad por tipo' > (select avg(i3.cantAlimento) from informe i3)
-- group by tipoAlimento;

select 
	i.tipoAlimento as 'Tipo de alimento', 
    sum(i.cantAlimento) as Suma,
    (select avg(i2.cantAlimento) from informe i2
	where i.tipoAlimento = i2.tipoAlimento) as promedio
from informe i
group by i.tipoAlimento
having sum(i.cantAlimento) > promedio;
                                
                                

-- Consulta 10

select
	f.fecha as Fecha, sum(p.precio * c.cantidad) as Total
from
	factura f 
    inner join producto_has_factura pxf on f.idFactura = pxf.factura_idFactura
    inner join producto p on pxf.producto_idProducto = p.idProducto
    inner join cantidad c on p.cantidad_idCantidad = c.idCantidad
group by f.fecha;


-- Consulta 11

select p.nombre, f.fecha
from producto p
	inner join producto_has_factura pxf 
		on p.idProducto = pxf.producto_idProducto
    inner join factura f 
		on pxf.factura_idFactura = f.idFactura
order by f.fecha;

    
    
    

-- inner join producto_has_factura pxf on p.idProducto = pxf.producto_idProducto;