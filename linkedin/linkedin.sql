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


-- Logros


CREATE TABLE logros (
  id_usuario INTEGER NOT NULL,
  id_logro INTEGER NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  CONSTRAINT pk_logros 
    PRIMARY KEY (id_usuario, id_logro),
  CONSTRAINT fk_logros_usuarios 
    FOREIGN KEY (id_usuario)
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);


CREATE TABLE cursos (
  id_usuario INTEGER NOT NULL,
  id_logro INTEGER NOT NULL,
  numero VARCHAR(30),
  CONSTRAINT pk_cursos 
    PRIMARY KEY (id_usuario, id_logro),
  CONSTRAINT fk_cursos_logros 
    FOREIGN KEY (id_usuario, id_logro)
    REFERENCES logros (id_usuario, id_logro)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);


CREATE TABLE proyectos (
  id_usuario INTEGER NOT NULL,
  id_logro INTEGER NOT NULL,
  fecha_inicial DATE,
  fecha_final DATE,
  url VARCHAR(500),
  descripcion VARCHAR(500),
  CONSTRAINT pk_proyectos 
    PRIMARY KEY (id_usuario, id_logro),
  CONSTRAINT fk_proyectos_logros 
    FOREIGN KEY (id_usuario, id_logro)
    REFERENCES logros (id_usuario, id_logro)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);


CREATE TABLE creadores_proyectos (
  id_usuario INTEGER NOT NULL,
  id_logro INTEGER NOT NULL,
  id_usuario_creador INTEGER NOT NULL,
  CONSTRAINT pk_creadores_proyectos 
    PRIMARY KEY (id_usuario, id_logro, id_usuario_creador),
  CONSTRAINT fk_creadores_proyectos_proyectos 
    FOREIGN KEY (id_usuario, id_logro)
    REFERENCES proyectos (id_usuario, id_logro)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_creadores_proyectos_usuarios 
    FOREIGN KEY (id_usuario_creador)
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT   
);



CREATE TABLE certificaciones (
  id_usuario INTEGER NOT NULL,
  id_logro INTEGER NOT NULL,
  autoridad_emisora VARCHAR(50),
  numero_licencia VARCHAR(50),
  fecha_obtencion DATE,
  fecha_expiracion DATE,
  url VARCHAR(500),
  CONSTRAINT pk_certificaciones 
    PRIMARY KEY (id_usuario, id_logro),
  CONSTRAINT fk_certificaciones_logros 
    FOREIGN KEY (id_usuario, id_logro)
    REFERENCES logros (id_usuario, id_logro)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);



CREATE TABLE idiomas (
  id_usuario INTEGER NOT NULL,
  id_logro INTEGER NOT NULL,
  nivel VARCHAR(50),
  CONSTRAINT pk_idiomas
    PRIMARY KEY (id_usuario, id_logro),
  CONSTRAINT fk_idiomas_logros 
    FOREIGN KEY (id_usuario, id_logro)
    REFERENCES logros (id_usuario, id_logro)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);



CREATE TABLE publicaciones (
  id_usuario INTEGER NOT NULL,
  id_logro INTEGER NOT NULL,
  fecha_publicacion DATE,
  url VARCHAR(500),
  descripcion VARCHAR(500),
  CONSTRAINT pk_publicaciones
    PRIMARY KEY (id_usuario, id_logro),
  CONSTRAINT fk_publicaciones_logros 
    FOREIGN KEY (id_usuario, id_logro)
    REFERENCES logros (id_usuario, id_logro)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);




CREATE TABLE autores_publicaciones (
  id_usuario INTEGER NOT NULL,
  id_logro INTEGER NOT NULL,
  id_usuario_autor INTEGER NOT NULL,
  CONSTRAINT pk_autores_publicaciones
    PRIMARY KEY (id_usuario, id_logro, id_usuario_autor),
  CONSTRAINT fk_autores_publicaciones_publicaciones 
    FOREIGN KEY (id_usuario, id_logro)
    REFERENCES publicaciones (id_usuario, id_logro)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_autores_publicaciones_usuarios 
    FOREIGN KEY (id_usuario_autor)
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT   
);


CREATE TABLE patentes (
  id_usuario INTEGER NOT NULL,
  id_logro INTEGER NOT NULL,
  pais_registro VARCHAR(500) NOT NULL,
  numero VARCHAR(50) NOT NULL,
  estado VARCHAR(50) NOT NULL,
  fecha_expedicion DATE,
  url VARCHAR(500),
  descripcion VARCHAR(500),
  CONSTRAINT pk_patentes
    PRIMARY KEY (id_usuario, id_logro),
  CONSTRAINT fk_patentes_logros 
    FOREIGN KEY (id_usuario, id_logro)
    REFERENCES logros (id_usuario, id_logro)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE inventores_patentes (
  id_usuario INTEGER NOT NULL,
  id_logro INTEGER NOT NULL,
  id_usuario_inventor INTEGER NOT NULL,
  CONSTRAINT pk_inventores_patentes
    PRIMARY KEY (id_usuario, id_logro, id_usuario_inventor),
  CONSTRAINT fk_inventores_patentes_patentes 
    FOREIGN KEY (id_usuario, id_logro)
    REFERENCES patentes (id_usuario, id_logro)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_inventores_patentes_usuarios 
    FOREIGN KEY (id_usuario_inventor)
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT   
);


-- Empresas

CREATE TABLE empresas (
  id_empresa INTEGER NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  industria VARCHAR(50),
  descripcion VARCHAR(500),
  anio_creacion INTEGER,
  url VARCHAR(500),
  tipo VARCHAR(50),
  tamanio INTEGER,
  id_usuario_creador INTEGER NOT NULL,
  CONSTRAINT pk_empresas 
    PRIMARY KEY (id_empresa),
  CONSTRAINT fk_empresas_usuarios 
    FOREIGN KEY (id_usuario_creador)
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT   
);


CREATE TABLE oficinas (
  id_empresa INTEGER NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(300) NOT NULL,
  es_principal BOOLEAN NOT NULL,
  CONSTRAINT pk_oficinas 
    PRIMARY KEY (id_empresa, nombre, direccion),
  CONSTRAINT fk_oficinas_empresas 
    FOREIGN KEY (id_empresa)
    REFERENCES empresas (id_empresa)
    ON UPDATE RESTRICT ON DELETE RESTRICT   
);

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


-- Anuncios


CREATE TABLE anuncios_empleos (
  id_anuncio INTEGER NOT NULL,
  cargo VARCHAR(50) NOT NULL,
  ubicacion VARCHAR(300),
  antiguedad VARCHAR(30),
  tipo VARCHAR(50),
  descripcion VARCHAR(500),
  id_empresa INTEGER NOT NULL,
  id_usuario_creador INTEGER NOT NULL,
  CONSTRAINT pk_anuncios_empleos 
    PRIMARY KEY (id_anuncio),
  CONSTRAINT fk_anuncios_empresas 
    FOREIGN KEY (id_empresa)
    REFERENCES empresas (id_empresa)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_anuncios_usuarios 
    FOREIGN KEY (id_usuario_creador)
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT 
);


CREATE TABLE aplicaciones_anuncios (
  id_usuario INTEGER NOT NULL,
  id_anuncio INTEGER NOT NULL,
  CONSTRAINT pk_aplicaciones_anuncios 
    PRIMARY KEY (id_usuario, id_anuncio),
  CONSTRAINT fk_aplicaciones_anuncios_anuncios 
    FOREIGN KEY (id_anuncio)
    REFERENCES anuncios_empleos (id_anuncio)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_aplicaciones_anuncios_usuarios 
    FOREIGN KEY (id_usuario)
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT 
);

CREATE TABLE anuncios_guardados (
  id_usuario INTEGER NOT NULL,
  id_anuncio INTEGER NOT NULL,
  CONSTRAINT pk_anuncios_guardados 
    PRIMARY KEY (id_usuario, id_anuncio),
  CONSTRAINT fk_anuncios_guardados_anuncios 
    FOREIGN KEY (id_anuncio)
    REFERENCES anuncios_empleos (id_anuncio)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_anuncios_guardados_usuarios 
    FOREIGN KEY (id_usuario)
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT 
);



CREATE TABLE posts (
  id_post INTEGER NOT NULL,
  texto VARCHAR(500) NOT NULL,
  id_usuario INTEGER NOT NULL,
  CONSTRAINT pk_posts
    PRIMARY KEY (id_post),
  CONSTRAINT fk_posts_usuarios 
    FOREIGN KEY (id_usuario)
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT 
);


CREATE TABLE likes (
  id_post INTEGER NOT NULL,
  id_usuario INTEGER NOT NULL,
  CONSTRAINT pk_likes
    PRIMARY KEY (id_post, id_usuario),
  CONSTRAINT fk_likes_posts
    FOREIGN KEY (id_post)
    REFERENCES posts (id_post)
    ON UPDATE RESTRICT ON DELETE RESTRICT,  
  CONSTRAINT fk_likes_usuarios
    FOREIGN KEY (id_usuario)
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT 
);


CREATE TABLE comentarios (
  id_comentario INTEGER NOT NULL,
  texto VARCHAR(500) NOT NULL,
  id_post INTEGER NOT NULL,
  id_usuario INTEGER NOT NULL,
  CONSTRAINT pk_comentarios
    PRIMARY KEY (id_comentario),
  CONSTRAINT fk_comentarios_posts
    FOREIGN KEY (id_post)
    REFERENCES posts (id_post)
    ON UPDATE RESTRICT ON DELETE RESTRICT,  
  CONSTRAINT fk_comentarios_usuarios
    FOREIGN KEY (id_usuario)
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT 
);


CREATE TABLE mensajes (
  id_mensaje INTEGER NOT NULL,
  texto VARCHAR(500) NOT NULL,
  id_usuario_origen INTEGER NOT NULL,
  id_usuario_destino INTEGER NOT NULL,
  CONSTRAINT pk_mensajes
    PRIMARY KEY (id_mensaje),
  CONSTRAINT fk_mensajes_usuario_origen
    FOREIGN KEY (id_usuario_origen)
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_mensajes_usuario_destino
    FOREIGN KEY (id_usuario_destino)
    REFERENCES usuarios (id_usuario)
    ON UPDATE RESTRICT ON DELETE RESTRICT 
);



-- Inserts

INSERT INTO usuarios VALUES 
  (
    1, 
    'Juan Lopez', 
    'Ingeniero Informatico', 
    'Buenos Aires', 
    'Software', 
    'Soy un Ingeniero informatico buscando proyectos desafiantes.'),
  (
    2, 
    'Martin Martinez', 
    'Licenciado en Ciencias de Computacion', 
    'Buenos Aires', 
    'Software', 
    NULL),
  (
    3, 
    'Gonzalo Gonzalez', 
    'Estudiante de Marketing', 
    'Cordoba', 
    'Marketing', 
    'Soy un estudiante de 3er año de Marketing, buscando nuevos desafios.'),
  (
    4, 
    'Pablo Perez', 
    'Ingeniero Industrial', 
    'Cordoba', 
    'Automotriz', 
    NULL),
  (
    5, 
    'Lucia Onelli', 
    'Gerente de Marketing', 
    'Cordoba', 
    'Marketing', 
    NULL),
  (
    6, 
    'Paula Molina', 
    'Estudiante de Administracion de empresas', 
    'Buenos Aires', 
    NULL, 
    NULL),
  (
    7, 
    'Jorge Empresas', 
    NULL, 
    NULL, 
    NULL, 
    NULL);



INSERT INTO empresas VALUES 
(
    1, 
    'Google', 
    'Internet', 
    'Google’s mission is to organize the world‘s information and make it universally accessible and useful.',
    1998, 
    'http://www.google.com',
    'Empresa pública',
    90000,
    7),
  (
    2, 
    'Amazon', 
    'Internet', 
    'Amazon tiene la misión de ser la compañía más orientada al cliente del mundo, en la que las personas puedan encontrar prácticamente cualquier producto que quieran comprar en línea.',
    1994, 
    'http://www.amazon.com',
    'Empresa pública',
    566000,
    7),
  (
    3, 
    'Mercado Libre', 
    'Internet', 
    'Fundada en 1999, Mercado Libre es una compañía de tecnología que desarrolla soluciones para que individuos y empresas puedan comprar, vender, anunciar, enviar y pagar bienes y servicios en Internet.',
    1999, 
    'http://www.mercadolibre.com',
    'De financiación privada',
    4000,
    7),

  (
    4, 
    'Despegar.com', 
    'Turismo', 
    'Despegar es la empresa de viajes online líder en Latinoamérica.',
    1999, 
    'http://www.despegar.com',
    'De financiación privada',
    9000,
    7),

  (
    5, 
    'Toyota', 
    'Automotriz', 
    'Toyota Motor Corporation is a global automotive industry leader manufacturing vehicles in 27 countries or regions and marketing the company’s products in over 170 countries and regions.',
    1937, 
    'http://www.toyota-global.com/',
    'Empresa pública',
    369124,
    7),

  (
    6, 
    'Starbucks', 
    'Venta al por menor', 
    'By bringing people together over coffee, Starbucks has become one of the world’s best-known and best-loved companies.',
    1971, 
    'http://www.starbucks.com/careers',
    'Empresa publica',
    250135,
    7),

  (
    7, 
    'Globant', 
    'Informatica', 
    'We are a digitally native company where innovation, design and engineering meet scale. We use the latest technologies in the digital and cognitive field to empower organizations in every aspect.',
    2003, 
    'http://www.globant.com',
    'Empresa pública',
    7000,
    7),

  (
    8, 
    'General Motors', 
    'Automotriz', 
    'At General Motors, we are passionate about moving towards a world with zero crashes, zero emissions and zero congestion.',
    NULL, 
    'http://www.gm.com',
    'Empresa publica',
    180000,
    7);