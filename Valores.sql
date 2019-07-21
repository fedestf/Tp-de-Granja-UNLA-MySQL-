
insert into domicilio values
	(1, "141", 373, "City Bell", "Buenos Aires"),
    (2, "Ruta 2", 45, "Abasto", "Buenos Aires"),
    (3, "141", 373, "City Bell", "Buenos Aires"),
    (4, "Ruta 2", 45, "Abasto", "Buenos Aires"),
    (5, "141", 373, "City Bell", "Buenos Aires"),
    (6, "Ruta 2", 45, "Abasto", "Buenos Aires"),
    (7, "Ruta 2", 45, "Abasto", "Buenos Aires");


insert into cabaña values
	(30123456789, "Cabaña Camila SA", 1),
    (30111111117, "Cabaña Lohmann SRL", 2);
    
    
insert into cantidad values
	(1, 6),
    (2, 12),
    (3, 30);
    
    
insert into genetica values
	("LB1", "Lohmann Brown B-36", 30111111117),
    ("LW1", "Lohmann White W-41", 30111111117),
    ("CB1", "Camila Brown 2789", 30123456789),
    ("CW1", "Camila White 3456", 30123456789);


insert into plantel values
	("P1", "Plantel 1", 18, '2018-10-08', "CB1"),
    ("P2", "Plantel 2", 18, '2018-10-08', "LB1"),
    ("P3", "Plantel 3", 18, '2018-10-08', "LW1"),
    
    ("P8", "Plantel 8", 20, '2018-10-08', "CW1");
    
    
insert into galpon values
	(1, 2000, "P2"),
    (2, 3000, "P2"),
    (3, 1500, "P1"),
    (4, 3000, "P3");


insert into informe values
	(1, '2018-10-08', 1800, 10, "F1", 200, null, 1),
    (2, '2018-10-08', 2600, 20, "F1B", 300, null, 2),
    (3, '2018-10-08', 1350, 25, "F1", 150, null, 3),
    (4, '2018-10-08', 2500, 15, "F1A", 300, null, 4),
    (5, '2018-11-08', 1850, 11, "F1", 200, null, 1),
    (6, '2018-11-08', 2500, 19, "F1B", 300, null, 2),
    (7, '2018-11-08', 1300, 10, "F1", 150, null, 3),
    (8, '2018-11-08', 2600, 13, "F1A", 300, null, 4);
    
    -- Continuar
    
    
insert into producto values
	("HCD", "Docena Huevo Color", 80, 2),
	("HBD", "Docena Huevo Blanco", 70, 2),
    ("HCM", "Maple Huevo Color", 180, 3),
    ("HBM", "Maple Huevo Blanco", 160, 3),
    ("HBC2", "Caja media docena Huevo Color", 50, 1),
    ("HBD2", "Caja media docena Huevo Blanco", 40, 1);
    
    
insert into cliente values
    (20111111111, "Ernesto Fernandez", 3),
    (30222222222, "Avìcola Santa Fe SRL", 4),
    (30333333333, "Avícola Romero SA", 5),
    (30444444444, "Granja San Martìn SRL", 6),
    (20222222229, "José López", 7);
    

insert into producto_has_factura values



-- insert into factura values
-- 	(1, )
--     (1, )
    
    