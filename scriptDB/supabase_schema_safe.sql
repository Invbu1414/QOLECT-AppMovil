-- ============================================
-- QOLECT Database Schema - PostgreSQL/Supabase
-- VERSION SEGURA: No borra nada, solo crea lo que no existe
-- ============================================

/* ========================
   EXTENSIONES NECESARIAS
   ======================== */
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

/* ========================
   TABLAS DE USUARIO Y PERFIL
   ======================== */

-- Tabla perfil
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'perfil') THEN
        CREATE TABLE perfil (
            id_perfil SERIAL PRIMARY KEY,
            nombre VARCHAR(50) NOT NULL,
            descripcion VARCHAR(255),
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );
    END IF;
END $$;

-- Tabla usuario
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'usuario') THEN
        CREATE TABLE usuario (
            id_usuario SERIAL PRIMARY KEY,
            firebase_uid VARCHAR(255) UNIQUE NOT NULL,
            nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
            nombre VARCHAR(100) NOT NULL,
            apellidos VARCHAR(150),
            alias VARCHAR(100),
            correo VARCHAR(150) UNIQUE NOT NULL,
            telefono VARCHAR(20),
            foto_url VARCHAR(500),
            verificado BOOLEAN DEFAULT FALSE,
            id_perfil INT REFERENCES perfil(id_perfil),
            is_active BOOLEAN DEFAULT TRUE,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );

        -- Crear índices
        CREATE INDEX idx_usuario_firebase_uid ON usuario(firebase_uid);
        CREATE INDEX idx_usuario_correo ON usuario(correo);
        CREATE INDEX idx_usuario_nombre_usuario ON usuario(nombre_usuario);
    END IF;
END $$;

/* ========================
   TABLAS DE PRODUCTOS/PLANES
   ======================== */

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'categoria') THEN
        CREATE TABLE categoria (
            id_categoria SERIAL PRIMARY KEY,
            nombre VARCHAR(100) NOT NULL,
            descripcion VARCHAR(255),
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'marca') THEN
        CREATE TABLE marca (
            id_marca SERIAL PRIMARY KEY,
            nombre VARCHAR(100) NOT NULL,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'producto') THEN
        CREATE TABLE producto (
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
            plan_url VARCHAR(500),
            is_active BOOLEAN DEFAULT TRUE,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'etiqueta') THEN
        CREATE TABLE etiqueta (
            id_etiqueta SERIAL PRIMARY KEY,
            nombre VARCHAR(100) NOT NULL,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'producto_etiqueta') THEN
        CREATE TABLE producto_etiqueta (
            id_producto INT REFERENCES producto(id_producto) ON DELETE CASCADE,
            id_etiqueta INT REFERENCES etiqueta(id_etiqueta) ON DELETE CASCADE,
            PRIMARY KEY (id_producto, id_etiqueta),
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );
    END IF;
END $$;

/* ========================
   TABLAS DE CONTENIDO
   ======================== */

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'noticia') THEN
        CREATE TABLE noticia (
            id_noticia SERIAL PRIMARY KEY,
            titulo VARCHAR(200) NOT NULL,
            autor VARCHAR(150),
            id_autor INT REFERENCES usuario(id_usuario),
            fecha DATE,
            enlace VARCHAR(500),
            descripcion TEXT,
            imagen VARCHAR(500),
            adjunto_url VARCHAR(500),
            is_active BOOLEAN DEFAULT TRUE,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'usuario_noticia') THEN
        CREATE TABLE usuario_noticia (
            id_usuario INT REFERENCES usuario(id_usuario) ON DELETE CASCADE,
            id_noticia INT REFERENCES noticia(id_noticia) ON DELETE CASCADE,
            leida BOOLEAN DEFAULT FALSE,
            fecha_lectura TIMESTAMP WITH TIME ZONE,
            PRIMARY KEY (id_usuario, id_noticia),
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );

        CREATE INDEX idx_usuario_noticia_leida ON usuario_noticia(id_usuario, leida);
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'viaje') THEN
        CREATE TABLE viaje (
            id_viaje SERIAL PRIMARY KEY,
            id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
            titulo VARCHAR(200) NOT NULL,
            destino VARCHAR(200),
            descripcion TEXT,
            direccion_detallada VARCHAR(255),
            fecha_salida DATE,
            fecha_llegada DATE,
            calificacion NUMERIC(3,2) DEFAULT 0.0,
            calificacion_texto TEXT,
            imagen_card VARCHAR(500),
            imagen_interna VARCHAR(500),
            documentos_destino JSONB DEFAULT '[]'::jsonb,
            documentos_regreso JSONB DEFAULT '[]'::jsonb,
            documentos_preparacion JSONB DEFAULT '[]'::jsonb,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );

        CREATE INDEX idx_viaje_usuario ON viaje(id_usuario);
        CREATE INDEX idx_viaje_fechas ON viaje(fecha_salida, fecha_llegada);
        CREATE INDEX idx_viaje_destino ON viaje(destino);
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'experiencia') THEN
        CREATE TABLE experiencia (
            id_experiencia SERIAL PRIMARY KEY,
            titulo VARCHAR(200) NOT NULL,
            fecha DATE,
            comentario TEXT,
            imagen VARCHAR(500),
            video VARCHAR(500),
            texto_previo VARCHAR(500),
            has_video BOOLEAN DEFAULT FALSE,
            id_usuario INT REFERENCES usuario(id_usuario),
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );

        CREATE INDEX idx_experiencia_usuario ON experiencia(id_usuario);
    END IF;
END $$;

/* ========================
   NOTIFICACIONES
   ======================== */

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'notificacion') THEN
        CREATE TABLE notificacion (
            id_notificacion SERIAL PRIMARY KEY,
            id_usuario INT NOT NULL REFERENCES usuario(id_usuario) ON DELETE CASCADE,
            titulo VARCHAR(200) NOT NULL,
            mensaje TEXT NOT NULL,
            tipo VARCHAR(50) DEFAULT 'info',
            leida BOOLEAN DEFAULT FALSE,
            fecha_lectura TIMESTAMP WITH TIME ZONE,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );

        CREATE INDEX idx_notificacion_usuario ON notificacion(id_usuario);
        CREATE INDEX idx_notificacion_leida ON notificacion(id_usuario, leida);
    END IF;
END $$;

/* ========================
   LEADS/CONTACTO
   ======================== */

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'lead') THEN
        CREATE TABLE lead (
            id_lead SERIAL PRIMARY KEY,
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
        CREATE INDEX idx_lead_created ON lead(created_at);
    END IF;
END $$;

/* ========================
   TABLAS GENERICAS
   ======================== */

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'medio') THEN
        CREATE TABLE medio (
            id_medio SERIAL PRIMARY KEY,
            tipo VARCHAR(20) CHECK (tipo IN ('Imagen','Video')),
            url VARCHAR(500) NOT NULL,
            descripcion VARCHAR(255),
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'calificacion') THEN
        CREATE TABLE calificacion (
            id_calificacion SERIAL PRIMARY KEY,
            id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
            entidad VARCHAR(50) NOT NULL,
            id_entidad INT NOT NULL,
            puntaje INT CHECK (puntaje BETWEEN 1 AND 5),
            comentario VARCHAR(500),
            fecha TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );

        CREATE INDEX idx_calificacion_entidad ON calificacion(entidad, id_entidad);
        CREATE INDEX idx_calificacion_usuario ON calificacion(id_usuario);
    END IF;
END $$;

/* ========================
   TRIGGERS PARA updated_at
   ======================== */

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Crear triggers solo si no existen
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'update_usuario_updated_at') THEN
        CREATE TRIGGER update_usuario_updated_at
            BEFORE UPDATE ON usuario
            FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'update_producto_updated_at') THEN
        CREATE TRIGGER update_producto_updated_at
            BEFORE UPDATE ON producto
            FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'update_noticia_updated_at') THEN
        CREATE TRIGGER update_noticia_updated_at
            BEFORE UPDATE ON noticia
            FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'update_viaje_updated_at') THEN
        CREATE TRIGGER update_viaje_updated_at
            BEFORE UPDATE ON viaje
            FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'update_experiencia_updated_at') THEN
        CREATE TRIGGER update_experiencia_updated_at
            BEFORE UPDATE ON experiencia
            FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'update_lead_updated_at') THEN
        CREATE TRIGGER update_lead_updated_at
            BEFORE UPDATE ON lead
            FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
    END IF;
END $$;

/* ========================
   DATOS INICIALES
   ======================== */

INSERT INTO perfil (nombre, descripcion) VALUES
    ('Admin', 'Administrador del sistema'),
    ('Usuario', 'Usuario regular'),
    ('Premium', 'Usuario premium')
ON CONFLICT DO NOTHING;

INSERT INTO categoria (nombre, descripcion) VALUES
    ('Vuelos', 'Paquetes de vuelos'),
    ('Hoteles', 'Alojamiento'),
    ('Paquetes', 'Paquetes completos'),
    ('Tours', 'Tours guiados')
ON CONFLICT DO NOTHING;

/* ========================
   VISTAS ÚTILES
   ======================== */

CREATE OR REPLACE VIEW viajes_completos AS
SELECT
    v.*,
    u.nombre,
    u.apellidos,
    u.correo,
    u.foto_url
FROM viaje v
JOIN usuario u ON v.id_usuario = u.id_usuario;

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
-- FIN DEL SCRIPT - VERSION SEGURA
-- ============================================
