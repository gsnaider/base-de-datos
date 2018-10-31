

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
