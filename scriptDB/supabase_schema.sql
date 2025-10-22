-- ============================================
-- QOLECT Database Schema - PostgreSQL/Supabase
-- ============================================

/* ========================
   EXTENSIONES NECESARIAS
   ======================== */
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

/* ========================
   TABLAS DE USUARIO Y PERFIL
   ======================== */

CREATE TABLE IF NOT EXISTS perfil (
    id_perfil SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS usuario (
    id_usuario SERIAL PRIMARY KEY,

    -- Firebase Auth Integration (CRÍTICO)
    firebase_uid VARCHAR(255) UNIQUE NOT NULL,

    -- Datos básicos
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(150),
    alias VARCHAR(100),
    correo VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(20),

    -- Perfil
    foto_url VARCHAR(500),
    verificado BOOLEAN DEFAULT FALSE,
    id_perfil INT REFERENCES perfil(id_perfil),

    -- Metadata
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Índices para búsqueda rápida
CREATE INDEX IF NOT EXISTS idx_usuario_firebase_uid ON usuario(firebase_uid);
CREATE INDEX IF NOT EXISTS idx_usuario_correo ON usuario(correo);
CREATE INDEX IF NOT EXISTS idx_usuario_nombre_usuario ON usuario(nombre_usuario);

/* ========================
   TABLAS DE PRODUCTOS/PLANES
   ======================== */

CREATE TABLE IF NOT EXISTS categoria (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS marca (
    id_marca SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS producto (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    id_categoria INT REFERENCES categoria(id_categoria),
    fecha DATE,
    precio NUMERIC(12,2),
    precio_normal NUMERIC(12,2),
    precio_rebajado NUMERIC(12,2),
    descripcion TEXT,
    descripcion_corta VARCHAR(500),
    id_marca INT REFERENCES marca(id_marca),
    imagen VARCHAR(500),

    -- Campos adicionales para planes
    plan_url VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,

    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS etiqueta (
    id_etiqueta SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS producto_etiqueta (
    id_producto INT REFERENCES producto(id_producto) ON DELETE CASCADE,
    id_etiqueta INT REFERENCES etiqueta(id_etiqueta) ON DELETE CASCADE,
    PRIMARY KEY (id_producto, id_etiqueta),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

/* ========================
   TABLAS DE CONTENIDO
   ======================== */

CREATE TABLE IF NOT EXISTS noticia (
    id_noticia SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(150),
    id_autor INT REFERENCES usuario(id_usuario),
    fecha DATE,
    enlace VARCHAR(500),
    descripcion TEXT,
    imagen VARCHAR(500),
    adjunto_url VARCHAR(500),

    -- Metadata
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS usuario_noticia (
    id_usuario INT REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    id_noticia INT REFERENCES noticia(id_noticia) ON DELETE CASCADE,
    leida BOOLEAN DEFAULT FALSE,
    fecha_lectura TIMESTAMP WITH TIME ZONE,
    PRIMARY KEY (id_usuario, id_noticia),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Índice para búsquedas de noticias no leídas
CREATE INDEX IF NOT EXISTS idx_usuario_noticia_leida ON usuario_noticia(id_usuario, leida);

CREATE TABLE IF NOT EXISTS viaje (
    id_viaje SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario),

    -- Datos básicos
    titulo VARCHAR(200) NOT NULL,
    destino VARCHAR(200),
    descripcion TEXT,
    direccion_detallada VARCHAR(255),

    -- Fechas
    fecha_salida DATE,
    fecha_llegada DATE,

    -- Calificación
    calificacion NUMERIC(3,2) DEFAULT 0.0,
    calificacion_texto TEXT,

    -- Imágenes
    imagen_card VARCHAR(500),
    imagen_interna VARCHAR(500),

    -- Documentos (JSONB para flexibilidad)
    -- Formato: [{"nombre": "string", "pdf": "url", "icono": "string"}]
    documentos_destino JSONB DEFAULT '[]'::jsonb,
    documentos_regreso JSONB DEFAULT '[]'::jsonb,
    documentos_preparacion JSONB DEFAULT '[]'::jsonb,

    -- Metadata
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Índices para búsquedas eficientes
CREATE INDEX IF NOT EXISTS idx_viaje_usuario ON viaje(id_usuario);
CREATE INDEX IF NOT EXISTS idx_viaje_fechas ON viaje(fecha_salida, fecha_llegada);
CREATE INDEX IF NOT EXISTS idx_viaje_destino ON viaje(destino);

CREATE TABLE IF NOT EXISTS experiencia (
    id_experiencia SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    fecha DATE,
    comentario TEXT,
    imagen VARCHAR(500),
    video VARCHAR(500),
    texto_previo VARCHAR(500),
    has_video BOOLEAN DEFAULT FALSE,
    id_usuario INT REFERENCES usuario(id_usuario),

    -- Metadata
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_experiencia_usuario ON experiencia(id_usuario);

/* ========================
   NOTIFICACIONES (NUEVA)
   ======================== */

CREATE TABLE IF NOT EXISTS notificacion (
    id_notificacion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario) ON DELETE CASCADE,

    -- Contenido
    titulo VARCHAR(200) NOT NULL,
    mensaje TEXT NOT NULL,
    tipo VARCHAR(50) DEFAULT 'info', -- info, warning, success, error

    -- Estado
    leida BOOLEAN DEFAULT FALSE,
    fecha_lectura TIMESTAMP WITH TIME ZONE,

    -- Metadata
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_notificacion_usuario ON notificacion(id_usuario);
CREATE INDEX IF NOT EXISTS idx_notificacion_leida ON notificacion(id_usuario, leida);

/* ========================
   LEADS/CONTACTO (NUEVA)
   ======================== */

CREATE TABLE IF NOT EXISTS lead (
    id_lead SERIAL PRIMARY KEY,

    -- Datos de contacto
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),

    -- Datos de viaje
    num_adultos INT,
    num_ninos INT,
    num_infantes INT,
    trayecto VARCHAR(100), -- ida, vuelta, ida-vuelta
    origen VARCHAR(200),
    destino VARCHAR(200),
    fecha_ida DATE,
    fecha_vuelta DATE,
    equipaje VARCHAR(100),

    -- Metadatos
    tipo VARCHAR(50), -- vuelo, hotel, paquete, etc.
    estado VARCHAR(50) DEFAULT 'nuevo', -- nuevo, procesado, contactado, cerrado
    notas TEXT,

    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_lead_email ON lead(email);
CREATE INDEX IF NOT EXISTS idx_lead_estado ON lead(estado);
CREATE INDEX IF NOT EXISTS idx_lead_created ON lead(created_at);

/* ========================
   TABLAS GENERICAS
   ======================== */

CREATE TABLE IF NOT EXISTS medio (
    id_medio SERIAL PRIMARY KEY,
    tipo VARCHAR(20) CHECK (tipo IN ('Imagen','Video')),
    url VARCHAR(500) NOT NULL,
    descripcion VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS calificacion (
    id_calificacion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
    entidad VARCHAR(50) NOT NULL, -- viaje, producto, experiencia, etc.
    id_entidad INT NOT NULL,
    puntaje INT CHECK (puntaje BETWEEN 1 AND 5),
    comentario VARCHAR(500),
    fecha TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_calificacion_entidad ON calificacion(entidad, id_entidad);
CREATE INDEX IF NOT EXISTS idx_calificacion_usuario ON calificacion(id_usuario);

/* ========================
   TRIGGERS PARA updated_at
   ======================== */

-- Función para actualizar updated_at automáticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Aplicar trigger a todas las tablas con updated_at
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

/* ========================
   DATOS INICIALES
   ======================== */

-- Perfiles por defecto
INSERT INTO perfil (nombre, descripcion) VALUES
    ('Admin', 'Administrador del sistema'),
    ('Usuario', 'Usuario regular'),
    ('Premium', 'Usuario premium')
ON CONFLICT DO NOTHING;

-- Categorías de ejemplo
INSERT INTO categoria (nombre, descripcion) VALUES
    ('Vuelos', 'Paquetes de vuelos'),
    ('Hoteles', 'Alojamiento'),
    ('Paquetes', 'Paquetes completos'),
    ('Tours', 'Tours guiados')
ON CONFLICT DO NOTHING;

/* ========================
   POLÍTICAS RLS (Row Level Security)
   ======================== */

-- Habilitar RLS en tablas sensibles
ALTER TABLE usuario ENABLE ROW LEVEL SECURITY;
ALTER TABLE viaje ENABLE ROW LEVEL SECURITY;
ALTER TABLE experiencia ENABLE ROW LEVEL SECURITY;
ALTER TABLE notificacion ENABLE ROW LEVEL SECURITY;

-- Política: Los usuarios solo pueden ver/editar sus propios datos
CREATE POLICY "Users can view own data" ON usuario
    FOR SELECT USING (firebase_uid = auth.uid());

CREATE POLICY "Users can update own data" ON usuario
    FOR UPDATE USING (firebase_uid = auth.uid());

CREATE POLICY "Users can view own viajes" ON viaje
    FOR SELECT USING (
        id_usuario IN (
            SELECT id_usuario FROM usuario WHERE firebase_uid = auth.uid()
        )
    );

CREATE POLICY "Users can manage own viajes" ON viaje
    FOR ALL USING (
        id_usuario IN (
            SELECT id_usuario FROM usuario WHERE firebase_uid = auth.uid()
        )
    );

CREATE POLICY "Users can view own experiencias" ON experiencia
    FOR SELECT USING (
        id_usuario IN (
            SELECT id_usuario FROM usuario WHERE firebase_uid = auth.uid()
        )
    );

CREATE POLICY "Users can manage own experiencias" ON experiencia
    FOR ALL USING (
        id_usuario IN (
            SELECT id_usuario FROM usuario WHERE firebase_uid = auth.uid()
        )
    );

CREATE POLICY "Users can view own notifications" ON notificacion
    FOR SELECT USING (
        id_usuario IN (
            SELECT id_usuario FROM usuario WHERE firebase_uid = auth.uid()
        )
    );

-- Política: Todos pueden ver noticias activas
CREATE POLICY "Anyone can view active noticias" ON noticia
    FOR SELECT USING (is_active = true);

-- Política: Todos pueden ver productos activos
CREATE POLICY "Anyone can view active productos" ON producto
    FOR SELECT USING (is_active = true);

/* ========================
   VISTAS ÚTILES
   ======================== */

-- Vista de viajes con información del usuario
CREATE OR REPLACE VIEW viajes_completos AS
SELECT
    v.*,
    u.nombre,
    u.apellidos,
    u.correo,
    u.foto_url
FROM viaje v
JOIN usuario u ON v.id_usuario = u.id_usuario;

-- Vista de experiencias con información del usuario
CREATE OR REPLACE VIEW experiencias_completas AS
SELECT
    e.*,
    u.nombre,
    u.apellidos,
    u.foto_url as user_image,
    CONCAT(u.nombre, ' ', COALESCE(u.apellidos, '')) as user_name
FROM experiencia e
JOIN usuario u ON e.id_usuario = u.id_usuario;

/* ========================
   COMENTARIOS EN TABLAS
   ======================== */

COMMENT ON TABLE usuario IS 'Usuarios del sistema con integración Firebase Auth';
COMMENT ON TABLE viaje IS 'Viajes de los usuarios con documentos en formato JSONB';
COMMENT ON TABLE notificacion IS 'Notificaciones push para usuarios';
COMMENT ON TABLE lead IS 'Leads de contacto del formulario';
COMMENT ON TABLE producto IS 'Planes/productos disponibles';

-- ============================================
-- FIN DEL SCRIPT
-- ============================================
