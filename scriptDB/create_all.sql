-- ============================================
-- QOLECT Database - Crear TODO desde cero
-- ============================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- TABLA: perfil
CREATE TABLE perfil (
    idperfil SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- TABLA: usuario
CREATE TABLE usuario (
    idusuario SERIAL PRIMARY KEY,
    firebase_uid VARCHAR(255) UNIQUE NOT NULL,
    nombreusuario VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(150),
    alias VARCHAR(100),
    correo VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    foto_url VARCHAR(500),
    verificado BOOLEAN DEFAULT FALSE,
    idperfil INT REFERENCES perfil(idperfil),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_usuario_firebase_uid ON usuario(firebase_uid);
CREATE INDEX idx_usuario_correo ON usuario(correo);

-- TABLA: categoria
CREATE TABLE categoria (
    idcategoria SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- TABLA: marca
CREATE TABLE marca (
    idmarca SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- TABLA: producto
CREATE TABLE producto (
    idproducto SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    idcategoria INT REFERENCES categoria(idcategoria),
    fecha DATE,
    precio NUMERIC(12,2),
    precionormal NUMERIC(12,2),
    preciorebajado NUMERIC(12,2),
    descripcion TEXT,
    descripcioncorta VARCHAR(500),
    idmarca INT REFERENCES marca(idmarca),
    imagen VARCHAR(500),
    plan_url VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- TABLA: etiqueta
CREATE TABLE etiqueta (
    idetiqueta SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- TABLA: productoetiqueta
CREATE TABLE productoetiqueta (
    idproducto INT REFERENCES producto(idproducto) ON DELETE CASCADE,
    idetiqueta INT REFERENCES etiqueta(idetiqueta) ON DELETE CASCADE,
    PRIMARY KEY (idproducto, idetiqueta),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- TABLA: noticia
CREATE TABLE noticia (
    idnoticia SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(150),
    idautor INT REFERENCES usuario(idusuario),
    fecha DATE,
    enlace VARCHAR(500),
    descripcion TEXT,
    imagen VARCHAR(500),
    adjunto_url VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- TABLA: usuarionoticia
CREATE TABLE usuarionoticia (
    idusuario INT REFERENCES usuario(idusuario) ON DELETE CASCADE,
    idnoticia INT REFERENCES noticia(idnoticia) ON DELETE CASCADE,
    leida BOOLEAN DEFAULT FALSE,
    fecha_lectura TIMESTAMP WITH TIME ZONE,
    PRIMARY KEY (idusuario, idnoticia),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_usuario_noticia_leida ON usuarionoticia(idusuario, leida);

-- TABLA: viaje
CREATE TABLE viaje (
    idviaje SERIAL PRIMARY KEY,
    idusuario INT NOT NULL REFERENCES usuario(idusuario),
    titulo VARCHAR(200) NOT NULL,
    destino VARCHAR(200),
    descripcion TEXT,
    direcciondetallada VARCHAR(255),
    fechasalida DATE,
    fechallegada DATE,
    calificacion NUMERIC(3,2) DEFAULT 0.0,
    calificacion_texto TEXT,
    imagencard VARCHAR(500),
    imageninterna VARCHAR(500),
    documentos_destino JSONB DEFAULT '[]'::jsonb,
    documentos_regreso JSONB DEFAULT '[]'::jsonb,
    documentos_preparacion JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_viaje_usuario ON viaje(idusuario);
CREATE INDEX idx_viaje_fechas ON viaje(fechasalida, fechallegada);
CREATE INDEX idx_viaje_destino ON viaje(destino);

-- TABLA: experiencia
CREATE TABLE experiencia (
    idexperiencia SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    fecha DATE,
    comentario TEXT,
    imagen VARCHAR(500),
    video VARCHAR(500),
    textoprevio VARCHAR(500),
    has_video BOOLEAN DEFAULT FALSE,
    idusuario INT REFERENCES usuario(idusuario),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_experiencia_usuario ON experiencia(idusuario);

-- TABLA: notificacion
CREATE TABLE notificacion (
    idnotificacion SERIAL PRIMARY KEY,
    idusuario INT NOT NULL REFERENCES usuario(idusuario) ON DELETE CASCADE,
    titulo VARCHAR(200) NOT NULL,
    mensaje TEXT NOT NULL,
    tipo VARCHAR(50) DEFAULT 'info',
    leida BOOLEAN DEFAULT FALSE,
    fecha_lectura TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_notificacion_usuario ON notificacion(idusuario);
CREATE INDEX idx_notificacion_leida ON notificacion(idusuario, leida);

-- TABLA: lead
CREATE TABLE lead (
    idlead SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    num_adultos INT,
    num_ninos INT,
    num_infantes INT,
    trayecto VARCHAR(100),
    origen VARCHAR(200),
    destino VARCHAR(200),
    fecha_ida DATE,
    fecha_vuelta DATE,
    equipaje VARCHAR(100),
    tipo VARCHAR(50),
    estado VARCHAR(50) DEFAULT 'nuevo',
    notas TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_lead_email ON lead(email);
CREATE INDEX idx_lead_estado ON lead(estado);

-- TABLA: medio
CREATE TABLE medio (
    idmedio SERIAL PRIMARY KEY,
    tipo VARCHAR(20) CHECK (tipo IN ('Imagen','Video')),
    url VARCHAR(500) NOT NULL,
    descripcion VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- TABLA: calificacion
CREATE TABLE calificacion (
    idcalificacion SERIAL PRIMARY KEY,
    idusuario INT NOT NULL REFERENCES usuario(idusuario),
    entidad VARCHAR(50) NOT NULL,
    identidad INT NOT NULL,
    puntaje INT CHECK (puntaje BETWEEN 1 AND 5),
    comentario VARCHAR(500),
    fecha TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_calificacion_entidad ON calificacion(entidad, identidad);
CREATE INDEX idx_calificacion_usuario ON calificacion(idusuario);

-- FUNCIÓN: updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- TRIGGERS
CREATE TRIGGER update_usuario_updated_at
    BEFORE UPDATE ON usuario
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_producto_updated_at
    BEFORE UPDATE ON producto
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_noticia_updated_at
    BEFORE UPDATE ON noticia
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_viaje_updated_at
    BEFORE UPDATE ON viaje
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_experiencia_updated_at
    BEFORE UPDATE ON experiencia
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_lead_updated_at
    BEFORE UPDATE ON lead
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- DATOS INICIALES
INSERT INTO perfil (nombre, descripcion) VALUES
    ('Admin', 'Administrador del sistema'),
    ('Usuario', 'Usuario regular'),
    ('Premium', 'Usuario premium');

INSERT INTO categoria (nombre, descripcion) VALUES
    ('Vuelos', 'Paquetes de vuelos'),
    ('Hoteles', 'Alojamiento'),
    ('Paquetes', 'Paquetes completos'),
    ('Tours', 'Tours guiados');

-- COMENTARIOS
COMMENT ON TABLE usuario IS 'Usuarios del sistema con integración Firebase Auth';
COMMENT ON TABLE viaje IS 'Viajes de los usuarios con documentos en formato JSONB';
COMMENT ON TABLE notificacion IS 'Notificaciones push para usuarios';
COMMENT ON TABLE lead IS 'Leads de contacto del formulario';
COMMENT ON TABLE producto IS 'Planes/productos disponibles';

-- ============================================
-- LISTO!
-- ============================================
