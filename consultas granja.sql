use granja2;
-- Listar planteles en granja, indicando su genética y cabaña
select p.idplantel,p.nombre,p.edad_entrada,g.nombre as genetica,
c.razon_social as cabaña 
	from plantel p 
    inner join genetica g 
		on p.genetica_idgenetica=g.idgenetica
	inner join cabaña c 
		on g.cabaña_idcabaña=c.idcabaña;



--  Total de gallinas alojadas en la granja.
select sum(gp.cant_gallinas) as total_gallinas from galpon_has_plantel gp;




-- Total de gallinas en cada galpón, indicando a qué plantel corresponden.
select sum(gp.cant_gallinas) as total_gallinas,gp.galpon_idgalpon as galpon, p.nombre
	from galpon_has_plantel gp
    inner join plantel p
		on gp.plantel_idplantel=p.idplantel
	group by gp.galpon_idgalpon;



-- Porcentaje de gallinas en cada galpón, 
-- con respecto al total de gallinas alojadas en la granja.
select (gp.cant_gallinas*100)/(select sum(gp2.cant_gallinas) from galpon_has_plantel gp2)
as porcentaje, gp.galpon_idgalpon as galpon from galpon_has_plantel gp
group by gp.galpon_idgalpon;




-- Porcentaje de gallinas en cada galpón, 
-- con respecto al total de gallinas del plantel al que pertenecen.

	-- NO ANDA
	select (gp.cant_gallinas*100)/
			(select sum(gp2.cant_gallinas) from galpon_has_plantel gp2 
			group by gp2.plantel_idplantel)
		as porcentaje, gp.galpon_idgalpon,p.nombre
		from galpon_has_plantel gp 
			inner join plantel p on gp.plantel_idplantel=p.idplantel
		where gp.galpon_idgalpon=gp2.galpon_idgalpon
			group by gp.galpon_idgalpon;
    
	-- anda bien (POR PARTES) NO PORCENTAJE  
	select gp.galpon_idgalpon as Galpon,
		gp.cant_gallinas,
  
		(select sum(g.cant_gallinas) from galpon_has_plantel g 
			where g.plantel_idplantel=gp.plantel_idplantel
			group by g.plantel_idplantel )as total_plantel,
  
			gp.plantel_idplantel
		from galpon_has_plantel gp
		group by gp.galpon_idgalpon;

	
	select sum(cant_gallinas), plantel_idplantel from galpon_has_plantel 
		group by plantel_idplantel;
	-- SUBCONSULTA calcula total de g en x galpones por plantel
	(select sum(g.cant_gallinas) from galpon_has_plantel g 
		where g.plantel_idplantel=gp.plantel_idplantel
        group by g.plantel_idplantel )as total_plantel, ;
   
   
-- CONSULTA FINAL-- ANDA BIEN   
select gp.galpon_idgalpon as Galpon,
	(gp.cant_gallinas*100)/
  
   (select sum(g.cant_gallinas) from galpon_has_plantel g 
		where g.plantel_idplantel=gp.plantel_idplantel
        group by g.plantel_idplantel )as porcentaje,
  
        gp.plantel_idplantel as  del_plantel, p.nombre
      from galpon_has_plantel gp
			inner join plantel p 
				on gp.plantel_idplantel=p.idplantel
    group by gp.galpon_idgalpon;    


-- Listado de las genéticas de las que no hay planteles en ningún galpón.
 -- 1ero   planteles en galpones
 
 
 select p.genetica_idgenetica from plantel p 
	where not exists(
		select p.nombre, p.idplantel, gp.galpon_idgalpon
		from plantel p 
			inner join galpon_has_plantel gp
				on p.idplantel=gp.plantel_idplantel
			where p.idplantel=gp.plantel_idplantel
                ) ;

select * from genetica g 
where not exists
(select p.* from plantel p 
	where p.genetica_idgenetica=g.idgenetica);


-- anda bien
select * from genetica g 
	inner join plantel p2
		on g.idgenetica=p2.genetica_idgenetica
where not exists 
(select p.* from plantel p 
	inner join galpon_has_plantel gp 
		on p.idplantel=gp.plantel_idplantel
	where p2.idplantel=gp.plantel_idplantel);



-- Total de alimento entregado a los galpones, acumulado por tipo
select sum(p2.cant_alimento) as total_alimento,alimento_idalimento, a.nombre
from planilla p2 
inner join alimento a 
	on p2.alimento_idalimento=a.idalimento
group by alimento_idalimento;




-- Total de alimento entregado a los galpones, acumulado por tipo 
-- y que superen el promedio de las entregas
select sum(p.cant_alimento) as total_alim , p.alimento_idalimento , a.nombre
from planilla p 
inner join alimento a on p.alimento_idalimento=a.idalimento
group by p.alimento_idalimento
	having sum(p.cant_alimento)>
		(select avg(p2.cant_alimento) from planilla p2);

                 -- promedio 
				select avg(cant_alimento) from planilla ;




-- Total de alimento entregado a los galpones, acumulado por tipo 
-- y que superen el promedio de las entregas del tipo.

select sum(p.cant_alimento) as total_alim,p.alimento_idalimento, 
(select avg(p2.cant_alimento) from planilla p2
	where p2.alimento_idalimento=p.alimento_idalimento
    group by alimento_idalimento
)as promedio

from planilla p 
group by p.alimento_idalimento
having sum(p.cant_alimento)>
	promedio;

(select avg(p2.cant_alimento) from planilla p2
	where p2.alimento_idalimento=p.alimento_idalimento
    group by alimento_idalimento
);



-- Total de ventas entre fechas.
select v.fecha,
	(select sum(dv2.precio_unitario*dv2.cant_vendida) 
		from detalle_venta dv2
			inner join venta v2
				on dv2.venta_idventa=v2.idventa
        
			where v2.fecha=v.fecha
		group by v2.fecha) as total_vendido
from venta v
	inner join detalle_venta dv
		on v.idventa=dv.venta_idventa
group by v.fecha;

select v.fecha, 
	sum((select sum(dv.precio_unitario*dv.cant_vendida) as total_venta, dv.venta_idventa
	from detalle_venta dv 
    inner join venta v2
		on v2.idventa=dv.venta_idventa
	
	group by v2.fecha)) as total
from venta v

;
group by v.fecha

select sum(dv.precio_unitario*dv.cant_vendida) as total_venta, dv.venta_idventa
from detalle_venta dv 
group by dv.venta_idventa;


-- anda 
select sum(dv.precio_unitario*dv.cant_vendida) as total_venta, v.fecha
from detalle_venta dv 
inner join venta v
	on dv.venta_idventa=v.idventa
group by v.fecha;


select v.fecha, (select sum(dv.precio_unitario*dv.cant_vendida) as total_venta
	from detalle_venta dv 
    inner join venta v2
		on v2.idventa=dv.venta_idventa
	where v.fecha=v2.fecha
	group by v2.fecha) as total
    from venta v;



select v.fecha, (select sum(dv.precio_unitario*dv.cant_vendida) as total_venta
	from detalle_venta dv 
    inner join venta v2
		on v2.idventa=dv.venta_idventa
	where v.fecha=v2.fecha
	group by v2.fecha) as total
    from venta v;


-- suma del totales por venta 
select v.fecha, v.idventa,

(select sum(dv.precio_unitario*dv.cant_vendida) from detalle_venta dv
	where dv.venta_idventa=v.idventa
    group by dv.venta_idventa
	
)as total from venta v
group by v.idventa
;


-- Total de ventas entre fechas, por producto.
select distinct p.descripcion, p.codigo, 
(select sum(dv2.precio_unitario*dv2.cant_vendida )
from detalle_venta dv2
	inner join venta v2
		on v2.idventa=dv2.venta_idventa
	inner join producto p2
		on dv2.producto_codigo=p2.codigo
	where v.fecha=v2.fecha
    and dv2.producto_codigo=dv.producto_codigo
) as total, v.fecha
from producto p 
inner join detalle_venta dv 
	on p.codigo=dv.producto_codigo
	inner join venta v 
		on v.idventa=dv.venta_idventa;

-- Detalle de ventas (número factura, fecha, total facturado) entre fechas.

select v.idventa,v.fecha,

(select sum(dv.precio_unitario*dv.cant_vendida) from detalle_venta dv
	where dv.venta_idventa=v.idventa
    group by dv.venta_idventa
	
)as total from venta v
group by v.idventa
;


-- Detalle de ventas (número factura, fecha, total facturado) entre fechas cuyo total supere el promedio del total de ventas entre dichas fechas.
select v.idventa,v.fecha,

(select sum(dv.precio_unitario*dv.cant_vendida) from detalle_venta dv
	where dv.venta_idventa=v.idventa
    group by dv.venta_idventa
	
)as total from venta v
group by v.idventa
having total > (select avg(dv2.cant_vendida*dv2.precio_unitario)
 from detalle_venta dv2 
	inner join venta v2
		on v2.idventa=dv2.venta_idventa
 where v2.fecha=v.fecha)
;

-- Detalle de ventas realizadas en la localidad de Lanús.
select dv.* from detalle_venta dv 
	inner join venta v 
		on v.idventa=dv.venta_idventa
		inner join cliente c 
			on v.cliente_cuit=c.cuit
            inner join calle ca
				on c.calle_idcalle=ca.idcalle
                inner join localidad l 
					 on ca.localidad_idlocalidad=l.idlocalidad
 where l.nombre="Lanus";



-- Detalle de producción y ventas de la granja: se deberá mostrar 
-- fecha, tipo (producción o venta), cantidad en docenas de huevos (positiva si es producción, negativa si es venta).


select p.fecha, 'p' as tipo , p.cant_huevos/12
from planilla p
union
select v.fecha, 'v' as tipo, (-1*(dv.cant_vendida* pr.cantidad_empacada)/12)
from detalle_venta dv
	inner join venta v 
		on dv.venta_idventa=v.idventa
        inner join producto pr
			on dv.producto_codigo= pr.codigo
		order by fecha
            ;
            

-- Resultado de producción y ventas de la granja: se deberá mostrar fecha, resultado (en docenas).
-- Positivo si la producción superó a las ventas, negativo en caso contrario.


select p.fecha, sum(total)from
(

 select p.fecha, p.cant_huevos/12 as total
from planilla p

union all

select v.fecha, (-1*(dv.cant_vendida* pr.cantidad_empacada)/12) as total
from detalle_venta dv
	inner join venta v 
		on dv.venta_idventa=v.idventa
        inner join producto pr
			on dv.producto_codigo= pr.codigo
		
		) ;
            


select p.fecha, 
((select sum(p1.cant_huevos) from planilla p1
where p1.fecha=p.fecha
group by p1.fecha)


-(select sum(dv.cant_vendida* pr.cantidad_empacada)
from detalle_venta dv
	inner join venta v 
		on dv.venta_idventa=v.idventa
        inner join producto pr
			on dv.producto_codigo= pr.codigo
		where v.fecha=p.fecha
        group by v.fecha))/12 as total
from planilla p 
group by p.fecha;

            


