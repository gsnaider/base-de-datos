CREATE TABLE usuarios (
  id_usuario INTEGER NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  titulo VARCHAR(30),
  ubicacion VARCHAR(300),
  industria VARCHAR(30),
  extracto VARCHAR(500),
  CONSTRAINT pk_usuarios PRIMARY KEY (id_usuario)
);

CREATE TABLE aptitudes (
  id_usuario INTEGER NOT NULL,
  nombre_aptitud VARCHAR(30) NOT NULL,
  CONSTRAINT pk_aptitudes 
    PRIMARY KEY (id_usuario, nombre_aptitud),
  CONSTRAINT fk_aptitudes_usuarios 
    FOREIGN KEY (id_usuario) 
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE validaciones_aptitudes (
  id_usuario_validador INTEGER NOT NULL,
  id_usuario_validado INTEGER NOT NULL,
  nombre_aptitud VARCHAR(30) NOT NULL,
  CONSTRAINT pk_validaciones_aptitudes 
    PRIMARY KEY (id_usuario_validador, id_usuario_validado, nombre_aptitud),
  CONSTRAINT fk_validaciones_aptitudes_usuario_validador
    FOREIGN KEY (id_usuario_validador)
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_validaciones_aptitudes_usuario_validado
    FOREIGN KEY (id_usuario_validado, nombre_aptitud)
    REFERENCES aptitudes (id_usuario, nombre_aptitud)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE conexiones (
  id_usuario_1 INTEGER NOT NULL,
  id_usuario_2 INTEGER NOT NULL,
  CONSTRAINT pk_conexiones 
    PRIMARY KEY (id_usuario_1, id_usuario_2),
  CONSTRAINT fk_conexiones_usuario_1 
    FOREIGN KEY (id_usuario_1) 
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_conexiones_usuario_2
    FOREIGN KEY (id_usuario_2) 
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);


CREATE TABLE recomendaciones (
  id_usuario_recomendador INTEGER NOT NULL,
  id_usuario_recomendado INTEGER NOT NULL,
  texto VARCHAR(500) NOT NULL,
  fecha DATE NOT NULL,
  CONSTRAINT pk_recomendaciones 
    PRIMARY KEY (id_usuario_recomendador, id_usuario_recomendado),
  CONSTRAINT fk_conexiones_usuario_recomendador
    FOREIGN KEY (id_usuario_recomendador) 
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_conexiones_usuario_recomendado
    FOREIGN KEY (id_usuario_recomendado) 
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);
