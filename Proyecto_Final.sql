DROP DATABASE restaurante;
CREATE DATABASE IF NOT EXISTS restaurante;
USE restaurante;

#1NF se cumple, ya que, se contienen datos atómicos
#2NF se cumple, ya que, las columnas están relacionados a la llave primaria artificial
#3NF se cumple, ya que, existe independencias entre las columnas de la tabla
CREATE TABLE IF NOT EXISTS mesas(
	mesa_id INT NOT NULL AUTO_INCREMENT,	#llave primaria artificial para facilitar acceso a datos
    mesa_capacidad INT,
	PRIMARY KEY (mesa_id)
);

#1NF se cumple, ya que, se contienen datos atómicos
#2NF se cumple, ya que, las columnas están relacionados a la llave primaria artificial
#3NF se cumple, ya que, existe independencias entre las columnas de la tabla
CREATE TABLE IF NOT EXISTS meseros(
	mesero_id INT NOT NULL AUTO_INCREMENT, #llave primaria artificial para facilitar acceso a datos
    mesero_nombre VARCHAR(45) NOT NULL,
	mesero_ap_pat VARCHAR(45) NOT NULL,
	mesero_ap_mat VARCHAR(45) NOT NULL,
    mesero_salario DECIMAL(6,2),
    mesero_ini_turno TIME, 	#hora que comienza su turno
    mesero_fin_turno TIME,	#hora que sale 
    INDEX mesero_nom_completo (mesero_nombre, mesero_ap_pat, mesero_ap_mat),
	PRIMARY KEY (mesero_id)
);

#1NF se cumple, ya que, se contienen datos atómicos
#2NF se cumple, ya que, las columnas están relacionados a la llave primaria artificial
#3NF se cumple, ya que, existe independencias entre las columnas de la tabla
CREATE TABLE IF NOT EXISTS alimentos(
	ali_id INT NOT NULL AUTO_INCREMENT, 	#llave primaria artificial para facilitar acceso a datos
    ali_nombre VARCHAR(45) NOT NULL,
    ali_precio DECIMAL(6,2) NOT NULL,
    ali_categoria ENUM('Ensaladas', 'Cervezas', 'Pescados', 'Carnes', 'Refrescos', 'Antojitos', 'Postres'),
	PRIMARY KEY (ali_id),
	UNIQUE (ali_nombre)
);

#1NF se cumple, ya que, se contienen datos atómicos
#2NF se cumple, ya que, las columnas están relacionados a la llave primaria artificial
#3NF se cumple, ya que, existe independencias entre las columnas de la tabla
CREATE TABLE IF NOT EXISTS orden(
	ord_id INT NOT NULL AUTO_INCREMENT,		#llave primaria artificial para facilitar acceso a datos
	ord_mesa_id INT NOT NULL,
	ord_mesero_id INT NOT NULL,
	ord_status ENUM('Abierta', 'Pagada'),
    ord_total DECIMAL(6,2),
    ord_fecha DATE NOT NULL,
	PRIMARY KEY (ord_id),
	CONSTRAINT fk_orden_mesa
		FOREIGN KEY (ord_mesa_id)
		REFERENCES mesas (mesa_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT fk_orden_mesero
		FOREIGN KEY (ord_mesero_id) 			
		REFERENCES meseros (mesero_id)
		ON UPDATE CASCADE 
		ON DELETE CASCADE
);

#ya se encuentra normalizada
#tabla de caracteristicas
CREATE TABLE IF NOT EXISTS detalles_orden(
	det_id INT NOT NULL AUTO_INCREMENT,
	det_ord_id INT NOT NULL,
	det_ali_id INT NOT NULL,
    PRIMARY KEY(det_id),
	CONSTRAINT fk_detalles_orden_id
		FOREIGN KEY (det_ord_id)
		REFERENCES orden (ord_id)
		ON UPDATE CASCADE 
		ON DELETE CASCADE,
	CONSTRAINT fk_detalles_alimento_id
		FOREIGN KEY (det_ali_id)
		REFERENCES alimentos (ali_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

INSERT INTO mesas(mesa_capacidad)
	VALUES (2), (4), (4), (4), (6), (8);
    
INSERT INTO meseros(mesero_nombre, mesero_ap_pat, mesero_ap_mat, mesero_salario, mesero_ini_turno, mesero_fin_turno)
		VALUES ('Jose', 'Gonzalez', 'Carrillo', 1300.00, '08:00:00', '16:00:00'),
				('Pablo', 'Juarez', 'Moreno', 1300.00, '08:00:00', '16:00:00'),
				('Marco', 'Hernandez', 'Baca', 0700.00, '12:00:00', '16:00:00'),
				('Mauricio', 'Gomez', 'Torres', 0900.00, '14:00:00', '22:00:00');

INSERT INTO alimentos (ali_nombre, ali_precio, ali_categoria)
	VALUES ('Verduras al vapor', 35.00, 'Ensaladas'),
			('Pastel de fresa', 50.00, 'Postres'),
			('Quesadillas', 20.00, 'Antojitos'),
			('Pescado empanizado', 65.00, 'Pescados'),
			('Coca-Cola', 15.00, 'Refrescos'),
			('Modelo', 40.00, 'Cervezas');

INSERT INTO orden(ord_mesa_id, ord_mesero_id, ord_status, ord_fecha)
	VALUES (1, 1, 'Abierta', '2020-12-19'), 
			(2, 3, 'Abierta', '2020-12-20'), 
			(3, 1, 'Abierta', '2020-12-20'), 
			(4, 2, 'Abierta', '2020-12-24'), 
			(5, 4, 'Abierta', '2020-12-24'), 
			(6, 4, 'Abierta', '2020-12-24');

INSERT INTO detalles_orden(det_ord_id, det_ali_id)
	VALUES (1,1), (1,5), (2,3), (2,6), (3,3), (3,5), (4,4), (5,4), (5,6), (6,2);
    
SELECT * FROM mesas;
SELECT * FROM meseros;
SELECT * FROM alimentos;
SELECT * FROM orden;
SELECT * FROM detalles_orden;

#1.-ordenes por mesero para una fecha
SELECT O.ord_id, O.ord_mesa_id, M.mesero_id, M.mesero_nombre, M.mesero_ap_pat, O.ord_status, O.ord_fecha
	FROM orden O, meseros M
	WHERE O.ord_mesero_id = M.mesero_id AND O.ord_fecha = "2020-12-20"
    ORDER BY O.ord_mesero_id DESC;
    
#2.-ordenes por mesa para una fecha
SELECT O.ord_id, O.ord_mesa_id, M.mesero_id, M.mesero_nombre, M.mesero_ap_pat, O.ord_status, O.ord_fecha
	FROM orden O, meseros M
	WHERE O.ord_mesero_id = M.mesero_id AND O.ord_fecha = "2020-12-20"
    ORDER BY O.ord_mesa_id DESC;
    
#3.-ordenes por fecha
SELECT O.ord_id, O.ord_mesa_id, M.mesero_id, M.mesero_nombre, M.mesero_ap_pat, O.ord_status, O.ord_fecha
	FROM orden O, meseros M
	WHERE O.ord_mesero_id = M.mesero_id
    ORDER BY O.ord_fecha DESC;
    
#4.-total de las ventas del dia
UPDATE orden
	SET ord_total = (
		SELECT SUM(A.ali_precio) total
		FROM detalles_orden D, alimentos A
		WHERE D.det_ord_id = "1" AND D.det_ali_id = A.ali_id)
	WHERE ord_id = "1"; # Total de ventas por Orden
    
SELECT SUM(ord_total) AS Venta_del_dia
	FROM orden WHERE ord_fecha = "2020-12-24"; # Total de ventas por Dia
    
#consultas extra
SELECT * FROM orden WHERE ord_status = 'Abierta'; #Órdenes abiertas.