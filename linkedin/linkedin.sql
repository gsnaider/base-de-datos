CREATE TABLE usuarios (
  id_usuario INTEGER NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  titulo VARCHAR(30) NOT NULL,
  ubicacion VARCHAR(300) NOT NULL,
  industria VARCHAR(30) NOT NULL,
  extracto VARCHAR(500) NOT NULL,
  CONSTRAINT pk_usuarios PRIMARY KEY (id_usuario)
);

CREATE TABLE aptitudes (
  id_usuario INTEGER NOT NULL,
  nombre_aptitud VARCHAR(30) NOT NULL,
  CONSTRAINT pk_aptitudes PRIMARY KEY 
   (id_usuario, nombre_aptitud),
  CONSTRAINT fk_aptitudes_usuarios FOREIGN KEY (id_usuario) 
   REFERENCES usuarios (id_usuario)
   ON UPDATE RESTRICT ON DELETE RESTRICT
);

