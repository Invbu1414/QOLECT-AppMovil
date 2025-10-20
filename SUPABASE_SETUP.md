# Configuración Supabase para QOLECT

## 🎯 Objetivo

Migrar el esquema de SQL Server a PostgreSQL en Supabase y prepararlo para la API Python.

---

## 📝 PASO 1: Ejecutar Script en Supabase SQL Editor

Ve a tu proyecto Supabase → **SQL Editor** y ejecuta este script completo:

```sql
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
```

---

## 📝 PASO 2: Verificar en Supabase Table Editor

Después de ejecutar el script, verifica que se crearon las tablas:

1. Ve a **Table Editor** en Supabase
2. Deberías ver estas tablas:
   - ✅ `usuario` (con columna `firebase_uid`)
   - ✅ `viaje`
   - ✅ `noticia`
   - ✅ `experiencia`
   - ✅ `notificacion` (nueva)
   - ✅ `lead` (nueva)
   - ✅ `producto`
   - ✅ `perfil`
   - ✅ etc.

---

## 📝 PASO 3: Obtener Credenciales de Supabase

### 3.1 Database URL

Ve a **Project Settings** → **Database** y copia:

```
Host: db.xxxxxxxxxxxxx.supabase.co
Database name: postgres
Port: 5432
User: postgres
Password: [tu-password]
```

### 3.2 Connection String

La URL de conexión será:
```
postgresql://postgres:[PASSWORD]@db.xxxxxxxxxxxxx.supabase.co:5432/postgres
```

### 3.3 Supabase API Keys

Ve a **Project Settings** → **API** y copia:
- `anon public` key (para cliente)
- `service_role` key (para backend) ⚠️ **Mantén esto secreto**

---

## 📝 PASO 4: Configurar API Python

### 4.1 Actualizar .env en QOLECT-API

```bash
# Database - Supabase PostgreSQL
DATABASE_URL=postgresql://postgres:[PASSWORD]@db.xxxxxxxxxxxxx.supabase.co:5432/postgres

# Supabase (opcional, si usas Supabase SDK)
SUPABASE_URL=https://xxxxxxxxxxxxx.supabase.co
SUPABASE_KEY=[service_role_key]
SUPABASE_ANON_KEY=[anon_public_key]

# Firebase (mantener lo que ya tienes)
FIREBASE_PROJECT_ID=your-project-id
# ... resto de configuración Firebase
```

### 4.2 Probar Conexión

Crea un script de prueba en tu API Python:

```python
# test_connection.py
import asyncio
from sqlalchemy import text
from app.core.database import engine

async def test_connection():
    async with engine.begin() as conn:
        result = await conn.execute(text("SELECT COUNT(*) FROM usuario"))
        count = result.scalar()
        print(f"✅ Conexión exitosa! Usuarios en BD: {count}")

if __name__ == "__main__":
    asyncio.run(test_connection())
```

Ejecutar:
```bash
cd C:\Users\Darka\Documents\MyStuff\QOLECT\QOLECT-API
python test_connection.py
```

---

## 📝 PASO 5: Crear Usuario de Prueba

Ejecuta en Supabase SQL Editor:

```sql
-- Crear perfil de prueba
INSERT INTO perfil (nombre, descripcion)
VALUES ('Usuario', 'Usuario regular')
ON CONFLICT DO NOTHING;

-- Crear usuario de prueba
-- IMPORTANTE: Usa el firebase_uid de tu cuenta de prueba
INSERT INTO usuario (
    firebase_uid,
    nombre_usuario,
    nombre,
    apellidos,
    correo,
    telefono,
    verificado,
    id_perfil
) VALUES (
    'FIREBASE_UID_AQUI',  -- Reemplazar con tu Firebase UID real
    'usuario_prueba',
    'Usuario',
    'Prueba',
    'test@qolect.co',
    '+1234567890',
    true,
    (SELECT id_perfil FROM perfil WHERE nombre = 'Usuario' LIMIT 1)
) ON CONFLICT (firebase_uid) DO NOTHING;

-- Verificar
SELECT * FROM usuario WHERE correo = 'test@qolect.co';
```

---

## 📝 PASO 6: Insertar Datos de Prueba

```sql
-- Viaje de prueba
INSERT INTO viaje (
    id_usuario,
    titulo,
    destino,
    descripcion,
    direccion_detallada,
    fecha_salida,
    fecha_llegada,
    calificacion,
    imagen_card,
    documentos_destino
) VALUES (
    (SELECT id_usuario FROM usuario WHERE correo = 'test@qolect.co'),
    'Viaje a Cartagena',
    'Cartagena, Colombia',
    'Un viaje increíble a la ciudad amurallada',
    'Centro Histórico, Cartagena',
    '2024-12-01',
    '2024-12-07',
    4.5,
    'https://example.com/cartagena.jpg',
    '[
        {"nombre": "Pasaporte", "pdf": "https://example.com/pasaporte.pdf", "icono": "passport"},
        {"nombre": "Boleto Aéreo", "pdf": "https://example.com/boleto.pdf", "icono": "flight"}
    ]'::jsonb
);

-- Noticia de prueba
INSERT INTO noticia (
    titulo,
    autor,
    fecha,
    descripcion,
    imagen
) VALUES (
    'Nuevos destinos disponibles',
    'QOLECT Team',
    CURRENT_DATE,
    'Descubre nuestros nuevos destinos para este verano',
    'https://example.com/destinos.jpg'
);

-- Producto/Plan de prueba
INSERT INTO producto (
    nombre,
    descripcion,
    descripcion_corta,
    precio,
    precio_normal,
    imagen,
    plan_url,
    id_categoria
) VALUES (
    'Paquete Cartagena 5 días',
    'Paquete completo incluye vuelo, hotel y tours',
    'Todo incluido - 5 días en Cartagena',
    1200.00,
    1500.00,
    'https://example.com/plan-cartagena.jpg',
    'https://qolect.co/planes/cartagena-5dias',
    (SELECT id_categoria FROM categoria WHERE nombre = 'Paquetes' LIMIT 1)
);

-- Verificar datos insertados
SELECT 'Viajes' as tabla, COUNT(*) as total FROM viaje
UNION ALL
SELECT 'Noticias', COUNT(*) FROM noticia
UNION ALL
SELECT 'Productos', COUNT(*) FROM producto;
```

---

## 🔐 PASO 7: Configurar Firebase Auth con Supabase

### Opción 1: Usar Firebase + Supabase (Recomendado)

Tu app ya usa Firebase Auth, así que:

1. **Firebase maneja**: Autenticación (login, tokens JWT)
2. **Supabase maneja**: Base de datos
3. **Python API**: Valida tokens Firebase y consulta Supabase

Ya tienes esto configurado en tu API Python! ✅

### Opción 2: Migrar a Supabase Auth (opcional)

Si quieres usar Supabase Auth en lugar de Firebase:

1. Configurar Supabase Auth providers (Google, Apple, Email)
2. Modificar Flutter app para usar Supabase Auth SDK
3. Migrar usuarios de Firebase → Supabase

**NO recomiendo esto** porque:
- Ya tienes Firebase funcionando
- Requiere cambios grandes en Flutter
- Firebase Auth es excelente

---

## ✅ VERIFICACIÓN FINAL

Ejecuta estas queries para verificar todo:

```sql
-- 1. Verificar tablas creadas
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

-- 2. Verificar índices
SELECT tablename, indexname
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;

-- 3. Verificar triggers
SELECT
    trigger_name,
    event_object_table,
    action_statement
FROM information_schema.triggers
WHERE trigger_schema = 'public'
ORDER BY event_object_table;

-- 4. Verificar RLS habilitado
SELECT
    schemaname,
    tablename,
    rowsecurity
FROM pg_tables
WHERE schemaname = 'public'
AND rowsecurity = true;

-- 5. Contar registros
SELECT
    'usuarios' as tabla, COUNT(*) as total FROM usuario
UNION ALL SELECT 'perfiles', COUNT(*) FROM perfil
UNION ALL SELECT 'viajes', COUNT(*) FROM viaje
UNION ALL SELECT 'noticias', COUNT(*) FROM noticia
UNION ALL SELECT 'productos', COUNT(*) FROM producto
UNION ALL SELECT 'experiencias', COUNT(*) FROM experiencia
UNION ALL SELECT 'notificaciones', COUNT(*) FROM notificacion
UNION ALL SELECT 'leads', COUNT(*) FROM lead;
```

---

## 🚀 PRÓXIMOS PASOS

Una vez ejecutado todo:

1. ✅ **Copiar connection string** de Supabase
2. ✅ **Actualizar .env** en API Python
3. ✅ **Probar conexión** con script de prueba
4. ✅ **Crear modelos SQLAlchemy** adaptados al esquema
5. ✅ **Implementar endpoints** en FastAPI
6. ✅ **Modificar Flutter** para apuntar a nueva API

---

## 📞 SUPPORT

Si encuentras errores al ejecutar el script:

1. Copia el error exacto
2. Verifica que estás en SQL Editor de Supabase
3. Ejecuta secciones individuales para identificar problemas
4. Verifica que tu plan de Supabase soporta las features (RLS, JSONB, etc.)

**Supabase Free Tier incluye**:
- ✅ PostgreSQL completo
- ✅ JSONB
- ✅ Row Level Security
- ✅ Triggers y funciones
- ✅ 500 MB de espacio
- ✅ Hasta 2 GB de transferencia

