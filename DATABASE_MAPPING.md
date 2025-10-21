# Mapeo Base de Datos QOLECT

## 🗄️ Esquema de Base de Datos Existente

### Motor de BD
**Detectado**: SQL Server (esquema original) + PostgreSQL (usuarios configurados)

**Decisión necesaria**: ¿Estás usando SQL Server o PostgreSQL actualmente?
- Si es **SQL Server**: Necesitamos adaptar SQLAlchemy para SQL Server
- Si es **PostgreSQL**: Migrar esquema de SQL Server → PostgreSQL

**Recomendación**: Usar **PostgreSQL** porque:
- ✅ Ya tienes usuarios configurados
- ✅ Tu API Python ya está configurada para PostgreSQL
- ✅ Cloud Run soporta Cloud SQL PostgreSQL
- ✅ Mejor para FastAPI/SQLAlchemy

---

## 📊 TABLAS EXISTENTES

### 1. Usuario y Perfil

#### Tabla `Perfil`
```sql
CREATE TABLE Perfil (
    idPerfil INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(50) NOT NULL,
    descripcion NVARCHAR(255)
);
```

#### Tabla `Usuario`
```sql
CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY IDENTITY(1,1),
    nombreUsuario NVARCHAR(50) NOT NULL UNIQUE,
    nombre NVARCHAR(100) NOT NULL,
    apellidos NVARCHAR(150),
    alias NVARCHAR(100),
    correo NVARCHAR(150) UNIQUE NOT NULL,
    telefono NVARCHAR(20),
    idPerfil INT,
    FOREIGN KEY (idPerfil) REFERENCES Perfil(idPerfil)
);
```

**⚠️ PROBLEMA**: Falta campo `firebase_uid` para integración con Firebase Auth

**Solución**: Agregar columna
```sql
ALTER TABLE Usuario ADD firebase_uid VARCHAR(255) UNIQUE;
ALTER TABLE Usuario ADD foto_url VARCHAR(500);
ALTER TABLE Usuario ADD verificado BOOLEAN DEFAULT FALSE;
ALTER TABLE Usuario ADD created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE Usuario ADD updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
```

---

### 2. Viaje

#### Tabla `Viaje`
```sql
CREATE TABLE Viaje (
    idViaje INT PRIMARY KEY IDENTITY(1,1),
    titulo NVARCHAR(200) NOT NULL,
    destino NVARCHAR(200),
    descripcion NVARCHAR(MAX),
    direccionDetallada NVARCHAR(255),
    fechaSalida DATE,
    fechaLlegada DATE,
    calificacion DECIMAL(3,2),
    imagenCard NVARCHAR(500),
    imagenInterna NVARCHAR(500)
);
```

**⚠️ PROBLEMA**: Falta relación con Usuario y campos de documentos

**Solución**: Agregar columnas
```sql
ALTER TABLE Viaje ADD idUsuario INT;
ALTER TABLE Viaje ADD FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);
ALTER TABLE Viaje ADD calificacion_texto TEXT;
ALTER TABLE Viaje ADD documentos_destino JSONB;  -- PostgreSQL
ALTER TABLE Viaje ADD documentos_regreso JSONB;
ALTER TABLE Viaje ADD documentos_preparacion JSONB;
ALTER TABLE Viaje ADD created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE Viaje ADD updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
```

---

### 3. Noticia

#### Tabla `Noticia`
```sql
CREATE TABLE Noticia (
    idNoticia INT PRIMARY KEY IDENTITY(1,1),
    titulo NVARCHAR(200) NOT NULL,
    autor NVARCHAR(150),
    fecha DATE,
    enlace NVARCHAR(500),
    descripcion NVARCHAR(MAX),
    imagen NVARCHAR(500)
);
```

**✅ BIEN**: Estructura básica correcta

**Mejoras opcionales**:
```sql
ALTER TABLE Noticia ADD idAutor INT;
ALTER TABLE Noticia ADD FOREIGN KEY (idAutor) REFERENCES Usuario(idUsuario);
ALTER TABLE Noticia ADD adjunto_url VARCHAR(500);
ALTER TABLE Noticia ADD created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
```

---

### 4. Experiencia

#### Tabla `Experiencia`
```sql
CREATE TABLE Experiencia (
    idExperiencia INT PRIMARY KEY IDENTITY(1,1),
    titulo NVARCHAR(200) NOT NULL,
    fecha DATE,
    comentario NVARCHAR(MAX),
    imagen NVARCHAR(500),
    video NVARCHAR(500),
    textoPrevio NVARCHAR(500),
    idUsuario INT,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);
```

**✅ BIEN**: Estructura correcta

**Mejoras opcionales**:
```sql
ALTER TABLE Experiencia ADD has_video BOOLEAN DEFAULT FALSE;
ALTER TABLE Experiencia ADD created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
```

---

### 5. Tablas de Productos

```sql
CREATE TABLE Categoria (...);
CREATE TABLE Marca (...);
CREATE TABLE Producto (...);
CREATE TABLE Etiqueta (...);
CREATE TABLE ProductoEtiqueta (...);
```

**📌 NOTA**: Estas tablas no están en WordPress ni en la app móvil actual.

**Pregunta**: ¿Estas tablas son para una funcionalidad futura o están en uso?
- Si **no se usan**: Podemos ignorarlas por ahora
- Si **se usan**: Necesitamos crear endpoints para planes/productos

---

## 🔄 MIGRACIÓN SQL SERVER → POSTGRESQL

### Diferencias Clave

| SQL Server | PostgreSQL |
|------------|------------|
| `IDENTITY(1,1)` | `SERIAL` o `GENERATED ALWAYS AS IDENTITY` |
| `NVARCHAR(n)` | `VARCHAR(n)` o `TEXT` |
| `NVARCHAR(MAX)` | `TEXT` |
| `DECIMAL(p,s)` | `NUMERIC(p,s)` o `DECIMAL(p,s)` |
| `DATETIME` | `TIMESTAMP` |
| `GETDATE()` | `CURRENT_TIMESTAMP` |
| No tiene JSONB | `JSONB` nativo |

### Script de Migración PostgreSQL

```sql
-- Crear base de datos
CREATE DATABASE qolect_db;

\c qolect_db;

/* ========================
   TABLAS DE USUARIO Y PERFIL
   ======================== */
CREATE TABLE perfil (
    id_perfil SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255)
);

CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    firebase_uid VARCHAR(255) UNIQUE NOT NULL,  -- NUEVO: Para Firebase
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(150),
    alias VARCHAR(100),
    correo VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    foto_url VARCHAR(500),  -- NUEVO
    verificado BOOLEAN DEFAULT FALSE,  -- NUEVO
    id_perfil INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- NUEVO
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- NUEVO
    FOREIGN KEY (id_perfil) REFERENCES perfil(id_perfil)
);

-- Índices para búsqueda rápida
CREATE INDEX idx_usuario_firebase_uid ON usuario(firebase_uid);
CREATE INDEX idx_usuario_correo ON usuario(correo);

/* ========================
   TABLAS DE PRODUCTOS
   ======================== */
CREATE TABLE categoria (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255)
);

CREATE TABLE marca (
    id_marca SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    id_categoria INT,
    fecha DATE,
    precio NUMERIC(12,2),
    precio_normal NUMERIC(12,2),
    precio_rebajado NUMERIC(12,2),
    descripcion TEXT,
    descripcion_corta VARCHAR(500),
    id_marca INT,
    imagen VARCHAR(500),
    plan_url VARCHAR(500),  -- NUEVO: Para URL del plan
    is_active BOOLEAN DEFAULT TRUE,  -- NUEVO
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
    FOREIGN KEY (id_marca) REFERENCES marca(id_marca)
);

CREATE TABLE etiqueta (
    id_etiqueta SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto_etiqueta (
    id_producto INT,
    id_etiqueta INT,
    PRIMARY KEY (id_producto, id_etiqueta),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE,
    FOREIGN KEY (id_etiqueta) REFERENCES etiqueta(id_etiqueta) ON DELETE CASCADE
);

/* ========================
   TABLAS DE CONTENIDO
   ======================== */
CREATE TABLE noticia (
    id_noticia SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(150),
    id_autor INT,  -- NUEVO: FK a usuario
    fecha DATE,
    enlace VARCHAR(500),
    descripcion TEXT,
    imagen VARCHAR(500),
    adjunto_url VARCHAR(500),  -- NUEVO
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_autor) REFERENCES usuario(id_usuario)
);

CREATE TABLE usuario_noticia (
    id_usuario INT,
    id_noticia INT,
    leida BOOLEAN DEFAULT FALSE,  -- NUEVO: Para marcar como leída
    fecha_lectura TIMESTAMP,  -- NUEVO
    PRIMARY KEY (id_usuario, id_noticia),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_noticia) REFERENCES noticia(id_noticia) ON DELETE CASCADE
);

CREATE TABLE viaje (
    id_viaje SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,  -- NUEVO: FK a usuario
    titulo VARCHAR(200) NOT NULL,
    destino VARCHAR(200),
    descripcion TEXT,
    direccion_detallada VARCHAR(255),
    fecha_salida DATE,
    fecha_llegada DATE,
    calificacion NUMERIC(3,2),
    calificacion_texto TEXT,  -- NUEVO
    imagen_card VARCHAR(500),
    imagen_interna VARCHAR(500),
    -- Documentos en formato JSON
    documentos_destino JSONB DEFAULT '[]'::jsonb,  -- NUEVO
    documentos_regreso JSONB DEFAULT '[]'::jsonb,  -- NUEVO
    documentos_preparacion JSONB DEFAULT '[]'::jsonb,  -- NUEVO
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Índice para búsquedas por usuario y fechas
CREATE INDEX idx_viaje_usuario ON viaje(id_usuario);
CREATE INDEX idx_viaje_fechas ON viaje(fecha_salida, fecha_llegada);

CREATE TABLE experiencia (
    id_experiencia SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    fecha DATE,
    comentario TEXT,
    imagen VARCHAR(500),
    video VARCHAR(500),
    texto_previo VARCHAR(500),
    has_video BOOLEAN DEFAULT FALSE,  -- NUEVO
    id_usuario INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

/* ========================
   TABLAS ADICIONALES NECESARIAS
   ======================== */

-- Notificaciones (falta en esquema original)
CREATE TABLE notificacion (
    id_notificacion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    mensaje TEXT NOT NULL,
    tipo VARCHAR(50) DEFAULT 'info',  -- info, warning, success, error
    leida BOOLEAN DEFAULT FALSE,
    fecha_lectura TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

CREATE INDEX idx_notificacion_usuario ON notificacion(id_usuario);
CREATE INDEX idx_notificacion_leida ON notificacion(leida);

-- Leads/Contacto (para formularios)
CREATE TABLE lead (
    id_lead SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    -- Datos de viaje
    num_adultos INT,
    num_ninos INT,
    num_infantes INT,
    trayecto VARCHAR(100),  -- ida, vuelta, ida-vuelta
    origen VARCHAR(200),
    destino VARCHAR(200),
    fecha_ida DATE,
    fecha_vuelta DATE,
    equipaje VARCHAR(100),
    -- Metadatos
    tipo VARCHAR(50),  -- vuelo, hotel, paquete, etc.
    estado VARCHAR(50) DEFAULT 'nuevo',  -- nuevo, procesado, contactado
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_lead_email ON lead(email);
CREATE INDEX idx_lead_estado ON lead(estado);

/* ========================
   TABLAS GENERICAS
   ======================== */
CREATE TABLE medio (
    id_medio SERIAL PRIMARY KEY,
    tipo VARCHAR(20) CHECK (tipo IN ('Imagen','Video')),
    url VARCHAR(500) NOT NULL,
    descripcion VARCHAR(255)
);

CREATE TABLE calificacion (
    id_calificacion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    entidad VARCHAR(50) NOT NULL,
    id_entidad INT NOT NULL,
    puntaje INT CHECK (puntaje BETWEEN 1 AND 5),
    comentario VARCHAR(500),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

/* ========================
   TRIGGERS PARA updated_at
   ======================== */

-- Función para actualizar updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Aplicar a tablas relevantes
CREATE TRIGGER update_usuario_updated_at BEFORE UPDATE ON usuario
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_viaje_updated_at BEFORE UPDATE ON viaje
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_lead_updated_at BEFORE UPDATE ON lead
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

---

## 🔗 MAPEO PYTHON MODELS

### Usuario Model

```python
# app/models/usuario.py
from sqlalchemy import Column, Integer, String, Boolean, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from app.core.database import Base

class Perfil(Base):
    __tablename__ = "perfil"

    id_perfil = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(50), nullable=False)
    descripcion = Column(String(255))

    usuarios = relationship("Usuario", back_populates="perfil")


class Usuario(Base):
    __tablename__ = "usuario"

    id_usuario = Column(Integer, primary_key=True, index=True)
    firebase_uid = Column(String(255), unique=True, nullable=False, index=True)
    nombre_usuario = Column(String(50), unique=True, nullable=False)
    nombre = Column(String(100), nullable=False)
    apellidos = Column(String(150))
    alias = Column(String(100))
    correo = Column(String(150), unique=True, nullable=False, index=True)
    telefono = Column(String(20))
    foto_url = Column(String(500))
    verificado = Column(Boolean, default=False)
    id_perfil = Column(Integer, ForeignKey("perfil.id_perfil"))
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())

    # Relaciones
    perfil = relationship("Perfil", back_populates="usuarios")
    viajes = relationship("Viaje", back_populates="usuario")
    experiencias = relationship("Experiencia", back_populates="usuario")
    notificaciones = relationship("Notificacion", back_populates="usuario")
```

### Viaje Model

```python
# app/models/viaje.py
from sqlalchemy import Column, Integer, String, Text, Date, Numeric, ForeignKey, DateTime
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from app.core.database import Base

class Viaje(Base):
    __tablename__ = "viaje"

    id_viaje = Column(Integer, primary_key=True, index=True)
    id_usuario = Column(Integer, ForeignKey("usuario.id_usuario"), nullable=False)
    titulo = Column(String(200), nullable=False)
    destino = Column(String(200))
    descripcion = Column(Text)
    direccion_detallada = Column(String(255))
    fecha_salida = Column(Date)
    fecha_llegada = Column(Date)
    calificacion = Column(Numeric(3, 2), default=0.0)
    calificacion_texto = Column(Text)
    imagen_card = Column(String(500))
    imagen_interna = Column(String(500))

    # JSON fields
    documentos_destino = Column(JSONB, default=[])
    documentos_regreso = Column(JSONB, default=[])
    documentos_preparacion = Column(JSONB, default=[])

    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())

    # Relaciones
    usuario = relationship("Usuario", back_populates="viajes")
```

---

## ✅ COMPATIBILIDAD CON API PYTHON

### Cambios Necesarios en Python API

1. **Cambiar de UUID a INTEGER** para PKs (tu BD usa `SERIAL`)
2. **Usar nombres snake_case** para columnas (tu BD los tiene así)
3. **Adaptar modelos** a esquema existente

### Ejemplo Adaptado

```python
# ANTES (API Python actual)
class User(Base):
    __tablename__ = "users"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    firebase_uid = Column(String(255), unique=True, nullable=False)
    # ...

# DESPUÉS (Compatible con tu BD)
class Usuario(Base):
    __tablename__ = "usuario"
    id_usuario = Column(Integer, primary_key=True, index=True)
    firebase_uid = Column(String(255), unique=True, nullable=False)
    # ...
```

---

## 🚀 PLAN DE ACCIÓN

### Opción 1: Adaptar API a BD Existente ✅ RECOMENDADO
1. Migrar esquema SQL Server → PostgreSQL
2. Agregar columnas faltantes (firebase_uid, etc.)
3. Adaptar modelos Python a tu esquema
4. Mantener compatibilidad con nombres de columnas

**Ventajas**:
- No pierdes datos existentes
- Menor trabajo de migración
- Más control sobre la BD

### Opción 2: Usar esquema nuevo de Python API
1. Crear tablas nuevas con esquema UUID
2. Migrar datos de BD antigua → nueva
3. Mantener ambas BDs temporalmente

**Ventajas**:
- Esquema más moderno (UUID)
- Mejor diseñado para APIs
- Mejores prácticas

**Desventajas**:
- Más trabajo de migración
- Posible pérdida de datos

---

## ❓ PREGUNTAS CLAVE

1. **¿Qué motor de BD estás usando actualmente?**
   - SQL Server
   - PostgreSQL
   - Otro

2. **¿Tienes datos en producción?**
   - Sí → Necesitamos migración cuidadosa
   - No → Podemos empezar de cero

3. **¿Las tablas de Producto están en uso?**
   - Sí → Crear endpoints para planes
   - No → Ignorar por ahora

4. **¿Prefieres adaptar API a tu BD o migrar BD al esquema de la API?**
   - Adaptar API (Opción 1) ← Recomendado
   - Migrar BD (Opción 2)

---

## 📋 PRÓXIMOS PASOS

Responde las preguntas clave y luego:

1. ✅ **Ejecutar script de migración PostgreSQL**
2. ✅ **Adaptar modelos Python** al esquema
3. ✅ **Crear migraciones Alembic**
4. ✅ **Conectar API a tu BD**
5. ✅ **Implementar endpoints**

