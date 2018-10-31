-- Usuarios

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


-- Experiencias

CREATE TABLE experiencias (
  id_usuario INTEGER NOT NULL,
  id_experiencia INTEGER NOT NULL,
  descripcion VARCHAR(500),
  fecha_inicial DATE NOT NULL,
  fecha_final DATE,
  CONSTRAINT pk_experiencias 
    PRIMARY KEY (id_usuario, id_experiencia),
  CONSTRAINT fk_experiencias_usuarios 
    FOREIGN KEY (id_usuario)
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);


CREATE TABLE educaciones (
  id_usuario INTEGER NOT NULL,
  id_experiencia INTEGER NOT NULL,
  titulo VARCHAR(50) NOT NULL,
  escuela VARCHAR(50) NOT NULL,
  disiplina_academica VARCHAR(50),
  promedio FLOAT(2),
  CONSTRAINT pk_educaciones 
    PRIMARY KEY (id_usuario, id_experiencia),
  CONSTRAINT fk_educaciones_experiencias 
    FOREIGN KEY (id_usuario, id_experiencia)
    REFERENCES experiencias (id_usuario, id_experiencia)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);


CREATE TABLE experiencias_laborales (
  id_usuario INTEGER NOT NULL,
  id_experiencia INTEGER NOT NULL,
  cargo VARCHAR(50) NOT NULL,
  ubicacion VARCHAR(300),
  CONSTRAINT pk_experiencias_laborales 
    PRIMARY KEY (id_usuario, id_experiencia),
  CONSTRAINT fk_experiencias_laborales_experiencias 
    FOREIGN KEY (id_usuario, id_experiencia)
    REFERENCES experiencias (id_usuario, id_experiencia)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);


-- Ejecutar despues de crear tabla empresas
CREATE TABLE experiencias_laborales_empresas (
  id_usuario INTEGER NOT NULL,
  id_experiencia INTEGER NOT NULL,
  id_empresa INTEGER NOT NULL,
  CONSTRAINT pk_experiencias_laborales_empresas 
    PRIMARY KEY (id_usuario, id_experiencia),
  CONSTRAINT fk_experiencias_laborales_empresas_experiencias_laborales 
    FOREIGN KEY (id_usuario, id_experiencia)
    REFERENCES experiencias_laborales (id_usuario, id_experiencia)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_experiencias_laborales_empresas_empresas 
    FOREIGN KEY (id_empresa)
    REFERENCES empresas (id_empresa)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);


