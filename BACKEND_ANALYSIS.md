# Análisis del Backend - QOLECT App

## Arquitectura Actual

### Base URL
`https://app.qolect.co`

### Sistema Backend
- **WordPress REST API** con custom endpoints
- **Firebase** para autenticación y almacenamiento
- **JWT Authentication** para tokens

---

## 📋 ENDPOINTS IDENTIFICADOS

### 1. **Autenticación**

#### Login
- **Endpoint**: `POST /wp-json/jwt-auth/v1/token`
- **Body**:
  ```json
  {
    "username": "string",
    "password": "string",
    "token": "!?zEJ4!g~?o$ZqMaP#k-2C>;}#m26w0@H9a"
  }
  ```
- **Response**:
  ```json
  {
    "token": "string",
    "user_email": "string",
    "user_nicename": "string",
    "user_display_name": "string",
    "id": number
  }
  ```

#### Reset Password
- **Endpoint**: `POST /wp-json/sense/v1/forgot-password`
- **Body**:
  ```json
  {
    "email": "string"
  }
  ```

---

### 2. **Usuarios**

#### Get User Info
- **Endpoint**: `GET /wp-json/wp/v2/users/{author}/?acf_format=standard`
- **Headers**: `Authorization: Bearer {token}`
- **Response**:
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

#### Register User
- **Endpoint**: `POST /wp-json/wp/v2/users`
- **Headers**: `Authorization: Bearer {token}`
- **Params**: username, email, password (multipart)

#### Update Profile
- **Endpoint**: `PUT /wp-json/wp/v2/users/{id}`
- **Headers**: `Authorization: Bearer {token}`
- **Body**:
  ```json
  {
    "password": "string",
    "acf": {
      "telefono": "string",
      "foto": "string"
    }
  }
  ```

#### Delete User
- **Endpoint**: `POST /wp-json/user-delete-api/v1/delete-user/`
- **Headers**: `Authorization: Bearer {token}`
- **Body**:
  ```json
  {
    "user_id": "string"
  }
  ```

#### Validar Existencia Email
- **Endpoint**: `POST /wp-json/v2/email-exist`
- **Body**:
  ```json
  {
    "email": "string"
  }
  ```
- **Response**:
  ```json
  {
    "userExist": boolean
  }
  ```

---

### 3. **Viajes**

#### Get Viajes
- **Endpoint**: `GET /wp-json/wp/v2/viaje/`
- **Params**:
  - `acf_format`: "standard"
  - `acf_author`: user_id
  - `acf_after`: date (2000-09-06)
  - `acf_before`: date (2100-09-06)
- **Response**: Array de viajes con ACF (Advanced Custom Fields):
  - id, date, author
  - acf.destino
  - acf.descripcion
  - acf.direccion_detallada
  - acf.fecha_de_salida
  - acf.fecha_de_llegada
  - acf.calificacion
  - acf.imagen_para_card
  - acf.en_destino_documentos[] (nombre, pdf, icono)
  - acf.de_regreso_a_casa_documentos[] (nombre, pdf, icono)
  - acf.prepara_tu_viaje_documentos[] (nombre, pdf, icono)

#### Rate Viaje
- **Endpoint**: `PUT /wp-json/wp/v2/viaje/{postId}?acf_format=standard`
- **Headers**: `Authorization: Bearer {token}`
- **Body**:
  ```json
  {
    "acf": {
      "calificacion": number,
      "calificacion_texto": "string"
    }
  }
  ```

---

### 4. **Noticias**

#### Get Noticias
- **Endpoint**: `GET /wp-json/wp/v2/noticias/?nocachee`
- **Params**:
  - `acf_format`: "standard"
  - `acf_author`: user_id
- **Response**: Array de noticias:
  - id, date, title.rendered, author
  - acf.imagen.url
  - acf.descripcion
  - acf.adjunto

---

### 5. **Notificaciones**

#### Get Notificaciones
- **Endpoint**: `GET /wp-json/wp/v2/notificaciones`
- **Params**:
  - `acf_format`: "standard"
  - `acf_author`: user_id
- **Response**: Array de notificaciones:
  - id, date, title.rendered, author
  - acf.texto_notificacion

#### Update Notificación
- **Endpoint**: `POST /wp-json/sense/v1/editar-notificacion/{notiId}`
- **Headers**: `Authorization: Bearer {token}`
- **Body**:
  ```json
  {
    "user_id": "string"
  }
  ```

---

### 6. **Planes**

#### Get Planes
- **Endpoint**: `GET /wp-json/v2/plans`
- **Response**: Array de planes:
  - plan_id
  - plan_title
  - plan_image
  - plan_price
  - plan_url

---

### 7. **Comunidad / Experiencias**

#### Get Experiencias
- **Endpoint**: `GET /wp-json/v2/experiences`
- **Response**: Array de experiencias:
  - experience_id
  - experience_comments
  - experience_text_prev
  - experience_image
  - experience_video
  - experience_has_video
  - user_image
  - user_name

#### Guardar Experiencia
- **Endpoint**: `POST /wp-json/v2/experiences`
- **Body**:
  ```json
  {
    "comentario": "string",
    "id_imagen": number,
    "id_video": number,
    "id_usuario": number
  }
  ```

---

### 8. **Media**

#### Upload Media
- **Endpoint**: `POST /wp-json/wp/v2/media`
- **Headers**: `Authorization: Bearer {token}`
- **Body**: Multipart form-data con file

---

### 9. **Leads / Contacto**

#### Send Lead
- **Endpoint**: `POST /wp-json/miplugin/v1/enviar-correo/`
- **Headers**: `Authorization: Bearer {token}`
- **Body**:
  ```json
  {
    "numero_de_adultos": "string",
    "numero_de_ninos": "string",
    "numero_de_infantes": "string",
    "trayecto": "string",
    "origen": "string",
    "destino": "string",
    "fecha_ida": "string",
    "fecha_vuelta": "string",
    "equipaje": "string"
  }
  ```

---

## 🔥 Firebase Services

### Firebase Auth
- **Archivo**: `lib/auth/firebase_auth/`
- **Providers**: Email/Password, Google, Apple
- **User Document**: `users/{uid}` en Firestore

### Firestore Collections
- **Archivo**: `lib/backend/schema/`
- Users: Datos de usuario complementarios

### Firebase Storage
- **Archivo**: `lib/backend/firebase_storage/`
- Upload de imágenes y archivos

---

## 📁 Estructura de Archivos Backend

```
lib/backend/
├── api_requests/
│   ├── api_calls.dart       # Todos los endpoints WordPress
│   └── api_manager.dart     # HTTP client manager
├── backend.dart             # Exports principales
├── firebase/                # Configuración Firebase
├── firebase_storage/        # Storage helpers
└── schema/                  # Modelos Firestore
```

---

## 🎯 ESTRATEGIA DE MIGRACIÓN A PYTHON API

### Opción 1: Adaptador/Middleware
Crear un servicio intermedio que:
1. Reciba las mismas peticiones que WordPress
2. Traduzca al formato de tu API Python
3. Devuelva respuestas en formato WordPress

**Ventaja**: No modificas el código Flutter
**Desventaja**: Capa extra de complejidad

### Opción 2: Modificación Directa
Modificar `api_calls.dart` para:
1. Cambiar URLs a tu API Python
2. Adaptar request/response bodies
3. Mantener la misma interfaz de métodos

**Ventaja**: Más limpio y eficiente
**Desventaja**: Requiere modificar código Flutter

### Opción 3: Capa de Abstracción
Crear una capa de servicios que:
1. Abstraiga la fuente de datos (WordPress/Python)
2. Use una interfaz común
3. Permita switch fácil entre backends

**Ventaja**: Máxima flexibilidad
**Desventaja**: Mayor refactorización inicial

---

## ✅ RECOMENDACIÓN

**Opción 2 (Modificación Directa)** es la mejor opción porque:
- El código ya está bien estructurado en clases
- Solo necesitas cambiar las URLs y request/response mappers
- Mantienes el mismo flujo de autenticación con Firebase
- Python API puede imitar la estructura de respuestas

---

## 🔧 PRÓXIMOS PASOS

1. **Documentar tu API Python** con sus endpoints actuales
2. **Mapear endpoints** WordPress → Python
3. **Crear modelos de datos** en Python que coincidan con las respuestas esperadas
4. **Modificar api_calls.dart** progresivamente por módulos:
   - Empezar con Login/Auth
   - Luego Viajes
   - Después Noticias/Notificaciones
   - Finalmente Planes/Comunidad
5. **Testing** endpoint por endpoint

