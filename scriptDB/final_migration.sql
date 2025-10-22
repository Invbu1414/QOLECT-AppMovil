-- ============================================
-- QOLECT - Script Final de Migración
-- Agrega columnas faltantes y crea tablas nuevas
-- ============================================

/* PASO 1: Agregar columnas faltantes a tabla usuario */
ALTER TABLE usuario ADD COLUMN IF NOT EXISTS firebase_uid VARCHAR(255);
ALTER TABLE usuario ADD COLUMN IF NOT EXISTS foto_url VARCHAR(500);
ALTER TABLE usuario ADD COLUMN IF NOT EXISTS verificado BOOLEAN DEFAULT FALSE;
ALTER TABLE usuario ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT TRUE;
ALTER TABLE usuario ADD COLUMN IF NOT EXISTS created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE usuario ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;

-- Hacer firebase_uid único si no lo es
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'usuario_firebase_uid_key'
    ) THEN
        ALTER TABLE usuario ADD CONSTRAINT usuario_firebase_uid_key UNIQUE (firebase_uid);
    END IF;
END $$;

-- Crear índices
CREATE INDEX IF NOT EXISTS idx_usuario_firebase_uid ON usuario(firebase_uid);
CREATE INDEX IF NOT EXISTS idx_usuario_correo ON usuario(correo);

/* PASO 2: Agregar columnas a tabla viaje */
ALTER TABLE viaje ADD COLUMN IF NOT EXISTS documentos_destino JSONB DEFAULT '[]'::jsonb;
ALTER TABLE viaje ADD COLUMN IF NOT EXISTS documentos_regreso JSONB DEFAULT '[]'::jsonb;
ALTER TABLE viaje ADD COLUMN IF NOT EXISTS documentos_preparacion JSONB DEFAULT '[]'::jsonb;
ALTER TABLE viaje ADD COLUMN IF NOT EXISTS created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE viaje ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;

-- Índices para viaje
CREATE INDEX IF NOT EXISTS idx_viaje_usuario ON viaje(idusuario);
CREATE INDEX IF NOT EXISTS idx_viaje_destino ON viaje(destino);

/* PASO 3: Agregar columnas a otras tablas */
ALTER TABLE producto ADD COLUMN IF NOT EXISTS plan_url VARCHAR(500);
ALTER TABLE producto ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT TRUE;
ALTER TABLE producto ADD COLUMN IF NOT EXISTS created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE producto ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE noticia ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT TRUE;
ALTER TABLE noticia ADD COLUMN IF NOT EXISTS created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE noticia ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE experiencia ADD COLUMN IF NOT EXISTS has_video BOOLEAN DEFAULT FALSE;
ALTER TABLE experiencia ADD COLUMN IF NOT EXISTS created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE experiencia ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;

/* PASO 4: Crear tabla notificacion */
CREATE TABLE IF NOT EXISTS notificacion (
    id_notificacion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuario(idusuario) ON DELETE CASCADE,
    titulo VARCHAR(200) NOT NULL,
    mensaje TEXT NOT NULL,
    tipo VARCHAR(50) DEFAULT 'info',
    leida BOOLEAN DEFAULT FALSE,
    fecha_lectura TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_notificacion_usuario ON notificacion(id_usuario);
CREATE INDEX IF NOT EXISTS idx_notificacion_leida ON notificacion(id_usuario, leida);

/* PASO 5: Crear tabla lead */
CREATE TABLE IF NOT EXISTS lead (
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

CREATE INDEX IF NOT EXISTS idx_lead_email ON lead(email);
CREATE INDEX IF NOT EXISTS idx_lead_estado ON lead(estado);

/* PASO 6: Crear función y triggers para updated_at */
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers
DROP TRIGGER IF EXISTS update_usuario_updated_at ON usuario;
CREATE TRIGGER update_usuario_updated_at
    BEFORE UPDATE ON usuario
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_producto_updated_at ON producto;
CREATE TRIGGER update_producto_updated_at
    BEFORE UPDATE ON producto
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_noticia_updated_at ON noticia;
CREATE TRIGGER update_noticia_updated_at
    BEFORE UPDATE ON noticia
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_viaje_updated_at ON viaje;
CREATE TRIGGER update_viaje_updated_at
    BEFORE UPDATE ON viaje
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_experiencia_updated_at ON experiencia;
CREATE TRIGGER update_experiencia_updated_at
    BEFORE UPDATE ON experiencia
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_lead_updated_at ON lead;
CREATE TRIGGER update_lead_updated_at
    BEFORE UPDATE ON lead
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

/* PASO 7: Insertar datos iniciales */
INSERT INTO categoria (nombre, descripcion) VALUES
    ('Vuelos', 'Paquetes de vuelos'),
    ('Hoteles', 'Alojamiento'),
    ('Paquetes', 'Paquetes completos'),
    ('Tours', 'Tours guiados')
ON CONFLICT DO NOTHING;

/* PASO 8: Comentarios en tablas */
COMMENT ON TABLE usuario IS 'Usuarios del sistema con integración Firebase Auth';
COMMENT ON TABLE viaje IS 'Viajes de los usuarios con documentos en formato JSONB';
COMMENT ON TABLE notificacion IS 'Notificaciones push para usuarios';
COMMENT ON TABLE lead IS 'Leads de contacto del formulario';
COMMENT ON TABLE producto IS 'Planes/productos disponibles';

-- ============================================
-- FIN - Base de datos lista para la API Python
-- ============================================
