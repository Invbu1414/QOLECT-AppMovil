# Estrategia de Migración: WordPress → Python FastAPI

## 🔍 Análisis Comparativo

### Backend Actual (WordPress)
- **Base URL**: `https://app.qolect.co`
- **Auth**: JWT custom de WordPress
- **Estructura**: Custom endpoints en WordPress REST API
- **14 endpoints** principales

### Backend Nuevo (Python FastAPI)
- **Framework**: FastAPI
- **Base URL**: (por definir - ej: `https://api.qolect.co`)
- **Auth**: Firebase Auth (JWT) ✅ **YA COMPATIBLE con Flutter**
- **Estructura**: Modular con endpoints por cliente
- **Estado**: ✅ Base funcional, necesita endpoints específicos de QOLECT

---

## ✅ VENTAJA CLAVE: Firebase Auth Ya Está Implementado

**¡Excelente noticia!** Tu API de Python ya usa Firebase Auth, lo mismo que usa Flutter:

```python
# Python API
from app.core.auth import get_current_user  # Firebase JWT

# Flutter App
import '/auth/firebase_auth/auth_util.dart';  # Firebase Auth
```

**Esto significa:**
- ✅ **NO necesitas migrar autenticación**
- ✅ El login de Google/Apple/Email ya funciona con ambos backends
- ✅ Los tokens JWT de Firebase son compatibles
- ✅ Solo necesitas agregar los endpoints de negocio

---

## 📋 MAPEO DE ENDPOINTS

### 1. Autenticación ✅ LISTO

| WordPress | Python API | Estado |
|-----------|-----------|--------|
| `POST /wp-json/jwt-auth/v1/token` | `POST /api/v1/auth/login` | ✅ Ya existe |
| `GET /wp-json/wp/v2/users/{id}` | `GET /api/v1/auth/me` | ✅ Ya existe |
| - | `POST /api/v1/auth/logout` | ✅ Ya existe |

**Acción**: Ninguna, ya funciona con Firebase.

---

### 2. Usuarios - NECESITA IMPLEMENTACIÓN

| WordPress | Python API (crear) | Prioridad |
|-----------|-------------------|-----------|
| `GET /wp-json/wp/v2/users/{author}` | `GET /api/v1/mobile/profile` | ✅ Ya existe |
| `PUT /wp-json/wp/v2/users/{id}` | `PUT /api/v1/mobile/profile` | ✅ Ya existe |
| `POST /wp-json/wp/v2/users` | `POST /api/v1/auth/register` | 🔶 Adaptar |
| `POST /wp-json/user-delete-api/v1/delete-user/` | `DELETE /api/v1/mobile/profile` | 🔴 Crear |
| `POST /wp-json/v2/email-exist` | `GET /api/v1/auth/email-exists` | 🔴 Crear |
| `POST /wp-json/sense/v1/forgot-password` | `POST /api/v1/auth/reset-password` | 🔴 Crear |

**Campos de Usuario WordPress (ACF)**:
```json
{
  "id": number,
  "name": "string",
  "acf": {
    "foto": {"url": "string"},
    "telefono": "string",
    "verificado": boolean
  }
}
```

**Esquema Python actual**:
```python
class User:
    id: UUID
    firebase_uid: str
    email: str
    name: Optional[str]
    role: UserRole
    is_active: bool
```

**Necesitas agregar a Python**:
```python
class User:
    # ... campos existentes
    photo_url: Optional[str] = None
    phone: Optional[str] = None
    verified: bool = False
```

---

### 3. Viajes - NECESITA IMPLEMENTACIÓN COMPLETA 🔴

| WordPress | Python API (crear) |
|-----------|-------------------|
| `GET /wp-json/wp/v2/viaje/` | `GET /api/v1/mobile/viajes` |
| `PUT /wp-json/wp/v2/viaje/{id}` (rate) | `PUT /api/v1/mobile/viajes/{id}/rate` |

**Modelo de Viaje (WordPress ACF)**:
```json
{
  "id": number,
  "date": "datetime",
  "author": number,
  "title": {"rendered": "string"},
  "acf": {
    "destino": "string",
    "descripcion": "string",
    "direccion_detallada": "string",
    "fecha_de_salida": "date",
    "fecha_de_llegada": "date",
    "calificacion": "string",
    "imagen_para_card": "url",
    "en_destino_documentos": [
      {"nombre": "string", "pdf": "url", "icono": "string"}
    ],
    "de_regreso_a_casa_documentos": [
      {"nombre": "string", "pdf": "url|bool", "icono": "string"}
    ],
    "prepara_tu_viaje_documentos": [
      {"nombre": "string", "pdf": "url", "icono": "string"}
    ]
  }
}
```

**Necesitas crear en Python**:
```python
# app/models/viaje.py
class Viaje(Base):
    __tablename__ = "viajes"

    id = Column(UUID, primary_key=True)
    user_id = Column(UUID, ForeignKey("users.id"))
    destino = Column(String)
    descripcion = Column(Text)
    direccion_detallada = Column(String)
    fecha_salida = Column(Date)
    fecha_llegada = Column(Date)
    calificacion = Column(Float, default=0.0)
    calificacion_texto = Column(Text)
    imagen_card = Column(String)

    # JSON fields para documentos
    documentos_destino = Column(JSONB)
    documentos_regreso = Column(JSONB)
    documentos_preparacion = Column(JSONB)

    created_at = Column(DateTime, server_default=func.now())
    updated_at = Column(DateTime, onupdate=func.now())
```

---

### 4. Noticias - NECESITA IMPLEMENTACIÓN 🔴

| WordPress | Python API (crear) |
|-----------|-------------------|
| `GET /wp-json/wp/v2/noticias/` | `GET /api/v1/mobile/noticias` |

**Modelo**:
```python
class Noticia(Base):
    __tablename__ = "noticias"

    id = Column(UUID, primary_key=True)
    title = Column(String)
    descripcion = Column(Text)
    imagen_url = Column(String)
    adjunto_url = Column(String)
    author_id = Column(UUID, ForeignKey("users.id"))
    created_at = Column(DateTime)
```

---

### 5. Notificaciones - ADAPTAR EXISTENTE 🔶

| WordPress | Python API |
|-----------|-----------|
| `GET /wp-json/wp/v2/notificaciones` | `GET /api/v1/mobile/notifications` ✅ Ya existe |
| `POST /wp-json/sense/v1/editar-notificacion/{id}` | `POST /api/v1/mobile/notifications/{id}/read` ✅ Ya existe |

**Acción**: Conectar a base de datos real en vez de mock data.

---

### 6. Planes - NECESITA IMPLEMENTACIÓN 🔴

| WordPress | Python API (crear) |
|-----------|-------------------|
| `GET /wp-json/v2/plans` | `GET /api/v1/mobile/planes` |

**Modelo**:
```python
class Plan(Base):
    __tablename__ = "planes"

    id = Column(UUID, primary_key=True)
    title = Column(String)
    price = Column(String)
    image_url = Column(String)
    plan_url = Column(String)
    is_active = Column(Boolean, default=True)
```

---

### 7. Comunidad/Experiencias - NECESITA IMPLEMENTACIÓN 🔴

| WordPress | Python API (crear) |
|-----------|-------------------|
| `GET /wp-json/v2/experiences` | `GET /api/v1/mobile/experiencias` |
| `POST /wp-json/v2/experiences` | `POST /api/v1/mobile/experiencias` |

**Modelo**:
```python
class Experiencia(Base):
    __tablename__ = "experiencias"

    id = Column(UUID, primary_key=True)
    user_id = Column(UUID, ForeignKey("users.id"))
    comentario = Column(Text)
    texto_preview = Column(String)
    imagen_id = Column(UUID)
    imagen_url = Column(String)
    video_id = Column(UUID)
    video_url = Column(String)
    has_video = Column(Boolean)
    created_at = Column(DateTime)
```

---

### 8. Media Upload - NECESITA IMPLEMENTACIÓN 🔴

| WordPress | Python API (crear) |
|-----------|-------------------|
| `POST /wp-json/wp/v2/media` | `POST /api/v1/mobile/upload` |

**Usar Cloud Storage** (Google Cloud Storage, AWS S3, etc.)

---

### 9. Leads/Contacto - NECESITA IMPLEMENTACIÓN 🔴

| WordPress | Python API (crear) |
|-----------|-------------------|
| `POST /wp-json/miplugin/v1/enviar-correo/` | `POST /api/v1/mobile/leads` |

---

## 🎯 PLAN DE IMPLEMENTACIÓN

### Fase 1: Preparación (1-2 días)
1. ✅ **Actualizar modelo User** con campos faltantes
   - `phone`, `photo_url`, `verified`
2. ✅ **Crear modelos de base de datos**:
   - Viaje
   - Noticia
   - Plan
   - Experiencia
3. ✅ **Crear migraciones Alembic**
4. ✅ **Definir esquemas Pydantic** para cada modelo

### Fase 2: Endpoints Core (2-3 días)
1. ✅ **Viajes** (más importante)
   - `GET /api/v1/mobile/viajes`
   - `GET /api/v1/mobile/viajes/{id}`
   - `PUT /api/v1/mobile/viajes/{id}/rate`
2. ✅ **Noticias**
   - `GET /api/v1/mobile/noticias`
3. ✅ **Notificaciones** (conectar a DB)
   - Modificar endpoint existente

### Fase 3: Endpoints Secundarios (1-2 días)
1. ✅ **Planes**
   - `GET /api/v1/mobile/planes`
2. ✅ **Experiencias/Comunidad**
   - `GET /api/v1/mobile/experiencias`
   - `POST /api/v1/mobile/experiencias`
3. ✅ **Upload de media**
   - `POST /api/v1/mobile/upload`

### Fase 4: Endpoints Auth Adicionales (1 día)
1. ✅ **Reset password**
2. ✅ **Email exists**
3. ✅ **Delete account**

### Fase 5: Migración Flutter (2-3 días)
1. ✅ **Modificar `api_calls.dart`**
   - Cambiar base URL
   - Adaptar request/response bodies
2. ✅ **Testing endpoint por endpoint**
3. ✅ **Ajustes de compatibilidad**

### Fase 6: Testing & Deploy (2 días)
1. ✅ **Testing integral**
2. ✅ **Deploy a Cloud Run**
3. ✅ **Switch gradual** (feature flag?)

---

## 📝 CÓDIGO DE EJEMPLO

### 1. Modelo Viaje (Python)

```python
# app/models/viaje.py
from sqlalchemy import Column, String, Text, Date, Float, ForeignKey
from sqlalchemy.dialects.postgresql import UUID, JSONB
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
import uuid

from app.core.database import Base

class Viaje(Base):
    __tablename__ = "viajes"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)

    # Campos básicos
    title = Column(String, nullable=False)
    destino = Column(String, nullable=False)
    descripcion = Column(Text)
    direccion_detallada = Column(String)

    # Fechas
    fecha_salida = Column(Date, nullable=False)
    fecha_llegada = Column(Date, nullable=False)

    # Calificación
    calificacion = Column(Float, default=0.0)
    calificacion_texto = Column(Text)

    # Imagen
    imagen_card = Column(String)

    # Documentos (JSON)
    documentos_destino = Column(JSONB, default=[])
    documentos_regreso = Column(JSONB, default=[])
    documentos_preparacion = Column(JSONB, default=[])

    # Timestamps
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    # Relaciones
    user = relationship("User", back_populates="viajes")
```

### 2. Schema Viaje (Pydantic)

```python
# app/schemas/viaje.py
from pydantic import BaseModel
from typing import Optional, List, Dict, Any
from datetime import date, datetime
from uuid import UUID

class DocumentoViaje(BaseModel):
    nombre: str
    pdf: Optional[str] = None
    icono: Optional[str] = None
    disponible: Optional[bool] = True

class ViajeBase(BaseModel):
    title: str
    destino: str
    descripcion: Optional[str] = None
    direccion_detallada: Optional[str] = None
    fecha_salida: date
    fecha_llegada: date
    imagen_card: Optional[str] = None

class ViajeCreate(ViajeBase):
    documentos_destino: List[DocumentoViaje] = []
    documentos_regreso: List[DocumentoViaje] = []
    documentos_preparacion: List[DocumentoViaje] = []

class ViajeUpdate(BaseModel):
    title: Optional[str] = None
    descripcion: Optional[str] = None
    calificacion: Optional[float] = None
    calificacion_texto: Optional[str] = None

class ViajeRate(BaseModel):
    calificacion: float
    calificacion_texto: Optional[str] = None

class ViajeInDB(ViajeBase):
    id: UUID
    user_id: UUID
    calificacion: float
    calificacion_texto: Optional[str]
    documentos_destino: List[Dict[str, Any]]
    documentos_regreso: List[Dict[str, Any]]
    documentos_preparacion: List[Dict[str, Any]]
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True

class Viaje(ViajeInDB):
    """Viaje response - compatible con formato WordPress"""
    # Alias para compatibilidad
    @property
    def acf(self):
        return {
            "destino": self.destino,
            "descripcion": self.descripcion,
            "direccion_detallada": self.direccion_detallada,
            "fecha_de_salida": self.fecha_salida.isoformat(),
            "fecha_de_llegada": self.fecha_llegada.isoformat(),
            "calificacion": str(self.calificacion),
            "imagen_para_card": self.imagen_card,
            "en_destino_documentos": self.documentos_destino,
            "de_regreso_a_casa_documentos": self.documentos_regreso,
            "prepara_tu_viaje_documentos": self.documentos_preparacion,
        }
```

### 3. Endpoint Viajes

```python
# app/api/v1/endpoints/mobile.py

# Agregar estos imports
from app.services.viaje import ViajeService
from app.schemas.viaje import Viaje, ViajeRate

# Agregar estos endpoints

@router.get("/viajes", response_model=List[Viaje])
async def get_viajes(
    after: Optional[date] = Query(None),
    before: Optional[date] = Query(None),
    current_user: Dict[str, Any] = Depends(get_current_user),
    db: AsyncSession = Depends(get_async_session)
):
    """Get user's viajes (trips)."""
    user_service = UserService(db)
    viaje_service = ViajeService(db)

    user = await user_service.get_user_by_firebase_uid(current_user["uid"])
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )

    viajes = await viaje_service.get_user_viajes(
        user.id,
        after=after or date(2000, 1, 1),
        before=before or date(2100, 1, 1)
    )

    return [Viaje.model_validate(v) for v in viajes]


@router.get("/viajes/{viaje_id}", response_model=Viaje)
async def get_viaje(
    viaje_id: UUID,
    current_user: Dict[str, Any] = Depends(get_current_user),
    db: AsyncSession = Depends(get_async_session)
):
    """Get specific viaje by ID."""
    viaje_service = ViajeService(db)

    viaje = await viaje_service.get_viaje(viaje_id)
    if not viaje:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Viaje not found"
        )

    return Viaje.model_validate(viaje)


@router.put("/viajes/{viaje_id}/rate", response_model=Viaje)
@idempotent()
async def rate_viaje(
    viaje_id: UUID,
    rating: ViajeRate,
    request: Request,
    current_user: Dict[str, Any] = Depends(get_current_user),
    db: AsyncSession = Depends(get_async_session)
):
    """Rate a viaje."""
    viaje_service = ViajeService(db)

    viaje = await viaje_service.rate_viaje(
        viaje_id,
        rating.calificacion,
        rating.calificacion_texto
    )

    if not viaje:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Viaje not found"
        )

    return Viaje.model_validate(viaje)
```

### 4. Service Viajes

```python
# app/services/viaje.py
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, and_
from typing import List, Optional
from datetime import date
from uuid import UUID

from app.models.viaje import Viaje
from app.repositories.viaje import ViajeRepository

class ViajeService:
    def __init__(self, db: AsyncSession):
        self.db = db
        self.repository = ViajeRepository(db)

    async def get_user_viajes(
        self,
        user_id: UUID,
        after: date,
        before: date
    ) -> List[Viaje]:
        """Get all viajes for a user within date range."""
        return await self.repository.get_by_user_and_dates(
            user_id, after, before
        )

    async def get_viaje(self, viaje_id: UUID) -> Optional[Viaje]:
        """Get viaje by ID."""
        return await self.repository.get_by_id(viaje_id)

    async def rate_viaje(
        self,
        viaje_id: UUID,
        calificacion: float,
        calificacion_texto: Optional[str] = None
    ) -> Optional[Viaje]:
        """Rate a viaje."""
        viaje = await self.repository.get_by_id(viaje_id)
        if not viaje:
            return None

        viaje.calificacion = calificacion
        viaje.calificacion_texto = calificacion_texto

        return await self.repository.update(viaje)
```

---

## 🔧 MODIFICACIÓN EN FLUTTER

### Cambiar Base URL

```dart
// lib/backend/api_requests/api_calls.dart

// ANTES
const String _baseUrl = 'https://app.qolect.co';

// DESPUÉS
const String _baseUrl = 'https://api.qolect.co/api/v1/mobile';

// O usar variable de entorno
final String _baseUrl = const String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'https://api.qolect.co/api/v1/mobile'
);
```

### Actualizar Endpoint de Viajes

```dart
// ANTES (WordPress)
class WordpressViajesCall {
  static Future<ApiCallResponse> call({
    String? author = '',
    String? after = '2000-09-06',
    String? before = '2100-09-06',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Wordpress Viajes',
      apiUrl: 'https://app.qolect.co/wp-json/wp/v2/viaje/',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'acf_format': "standard",
        'acf_author': author,
        'acf_after': after,
        'acf_before': before,
      },
      // ...
    );
  }
}

// DESPUÉS (Python FastAPI)
class ViajesCall {
  static Future<ApiCallResponse> call({
    String? after = '2000-09-06',
    String? before = '2100-09-06',
    required String firebaseToken,  // Token de Firebase
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Viajes',
      apiUrl: '$_baseUrl/viajes',  // https://api.qolect.co/api/v1/mobile/viajes
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $firebaseToken',  // Token Firebase
      },
      params: {
        'after': after,
        'before': before,
      },
      // ... resto igual
    );
  }

  // Los getters de respuesta pueden quedarse igual
  // porque el schema Python retorna formato compatible
}
```

---

## ⚡ VENTAJAS DE LA MIGRACIÓN

1. ✅ **Mismo auth (Firebase)** - Sin cambios en login
2. ✅ **Mejor performance** - FastAPI es mucho más rápido que WordPress
3. ✅ **Escalabilidad** - Cloud Run auto-scaling
4. ✅ **Type safety** - Pydantic valida todo
5. ✅ **Mejor desarrollo** - Código limpio, modular, testeable
6. ✅ **Documentación automática** - Swagger/OpenAPI
7. ✅ **Rate limiting** - Redis
8. ✅ **Cache con ETag** - Menos tráfico
9. ✅ **Paginación eficiente** - Cursor pagination

---

## 📊 ESTIMACIÓN DE TIEMPO

| Fase | Tiempo Estimado |
|------|-----------------|
| Fase 1: Preparación | 1-2 días |
| Fase 2: Endpoints Core | 2-3 días |
| Fase 3: Endpoints Secundarios | 1-2 días |
| Fase 4: Endpoints Auth | 1 día |
| Fase 5: Migración Flutter | 2-3 días |
| Fase 6: Testing & Deploy | 2 días |
| **TOTAL** | **9-13 días** |

---

## 🚀 PRÓXIMOS PASOS

1. **Revisar y aprobar esta estrategia**
2. **Definir URL de producción** para la API Python
3. **Comenzar Fase 1**: Crear modelos de base de datos
4. **Setup de Cloud Run** (si aún no está)
5. **Crear branch de migración** en ambos repos

¿Quieres que empiece a implementar la Fase 1?
