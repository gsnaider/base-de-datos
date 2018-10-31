
-- Obtener los mensajes entre usuarios que alguna vez trabajaron en la misma empresa. 
-- Listar el texto del mensaje junto con el id y nombre de los usuarios origen y destino.

SELECT m.texto, u_orig.id_usuario, u_orig.nombre, u_dest.id_usuario, u_dest.nombre
FROM mensajes m
INNER JOIN usuarios u_orig
ON m.id_usuario_origen = u_orig.id_usuario
INNER JOIN usuarios u_dest
ON m.id_usuario_destino = u_dest.id_usuario

WHERE EXISTS
  (SELECT DISTINCT exp1.id_usuario, exp2.id_usuario 
    FROM experiencias_laborales_empresas exp1
    INNER JOIN experiencias_laborales_empresas exp2 
    ON exp1.id_empresa = exp2.id_empresa
    AND exp1.id_usuario != exp2.id_usuario
    AND (
        (exp1.id_usuario = m.id_usuario_origen 
         AND exp2.id_usuario = m.id_usuario_destino)
      OR
        (exp1.id_usuario = m.id_usuario_destino 
         AND exp2.id_usuario = m.id_usuario_origen)));



-- Obtener el id y nombre de los usuarios que trabajaron en 
-- por lo menos las mismas empresas que el usuario con id 2.

SELECT DISTINCT u.id_usuario, u.nombre FROM usuarios u 
INNER JOIN
  (SELECT * FROM experiencias_laborales_empresas e1
  WHERE NOT EXISTS (
    SELECT 1 FROM
      (SELECT DISTINCT id_empresa 
       FROM experiencias_laborales_empresas 
       WHERE id_usuario = 2) e2
    WHERE NOT EXISTS (
      SELECT 1 FROM experiencias_laborales_empresas e3
      WHERE e3.id_usuario = e1.id_usuario
      AND e3.id_empresa = e2.id_empresa))) e
USING (id_usuario);


-- Obtener el id, nombre y título de los usuarios que tienen 
-- por lo menos 3 experiencias laborales, 2 logros, 
-- y por lo menos una educación con promedio >= 8.

SELECT DISTINCT u.id_usuario, u.nombre, u.titulo
FROM usuarios u INNER JOIN (

(SELECT id_usuario
FROM experiencias_laborales
GROUP BY id_usuario
HAVING COUNT(*) >= 3) exp

INNER JOIN 
(SELECT DISTINCT id_usuario 
  FROM logros 
  GROUP BY id_usuario 
  HAVING COUNT(*) >= 2) log 

USING (id_usuario)

INNER JOIN 
(SELECT DISTINCT id_usuario 
  FROM educaciones
  WHERE promedio >= 8) edu
USING (id_usuario)) perfil

USING (id_usuario);



-- Obtener el id y nombre de los Usuarios que hicieron la mayor 
-- cantidad de posts y comentarios. Mostrar también dicha cantidad.

CREATE VIEW cant_posts_y_comentarios AS 
SELECT * FROM 
	(SELECT id_usuario, COUNT(*) AS cant_posts
	FROM posts p
	GROUP BY id_usuario) posts
FULL OUTER JOIN
	(SELECT id_usuario, COUNT(*) AS cant_comentarios
	FROM comentarios c
	GROUP BY id_usuario) comms
USING (id_usuario);

SELECT u.id_usuario, 
       u.nombre, 
       (cant_posts + cant_comentarios) AS
            max_posts_y_comentarios
FROM cant_posts_y_comentarios
INNER JOIN usuarios u
USING (id_usuario)
WHERE cant_posts + cant_comentarios = 
    (SELECT MAX(cant_posts + cant_comentarios) 
     FROM cant_posts_y_comentarios);