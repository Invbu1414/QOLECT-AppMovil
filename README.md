# 📱 QOLECT - App Móvil (Flutter)

> **Sistema de gestión de viajes y experiencias turísticas**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev/)
[![FlutterFlow](https://img.shields.io/badge/FlutterFlow-Generated-purple.svg)](https://flutterflow.io/)
[![Firebase](https://img.shields.io/badge/Firebase-Auth-orange.svg)](https://firebase.google.com/)

---

## ⚠️ IMPORTANTE - Lee Esto Primero

### 🚨 Proyecto en Migración Activa

Este proyecto está en **medio de una migración crítica**:
- **De**: WordPress API (app.qolect.co)
- **A**: Python FastAPI + Supabase PostgreSQL

**Progreso actual**: 75% completado
- ✅ Backend API completado y funcional
- ⏳ Migración de Flutter en progreso

### 📚 ANTES de Hacer Cambios

**Lee estos archivos en orden**:

1. **[CONTRIBUTING.md](./CONTRIBUTING.md)** ⭐ **OBLIGATORIO**
   - Flujo de trabajo Git
   - Convenciones de código
   - Cómo crear PRs
   - Qué NO modificar

2. **[../QOLECT-Documentacion/ESTADO_ACTUAL.md](../QOLECT-Documentacion/ESTADO_ACTUAL.md)**
   - Estado completo del proyecto
   - Progreso de migración
   - Próximos pasos

3. **[../QOLECT-Documentacion/CHANGELOG_FLUTTER.md](../QOLECT-Documentacion/CHANGELOG_FLUTTER.md)**
   - Historial de cambios
   - Últimas modificaciones

---

## 🚀 Quick Start

### Prerequisitos

```bash
# Flutter SDK 3.x (stable)
flutter --version

# Android Studio o Xcode (según plataforma)
# Git
git --version
```

### Instalación

```bash
# 1. Clonar repositorio
git clone https://github.com/Invbu1414/QOLECT-AppMovil.git
cd QOLECT-AppMovil

# 2. Instalar dependencias
flutter pub get

# 3. Correr app
flutter run
```

### Emulador Recomendado

```
Nombre: Medium_Phone_API_36.1
Sistema: Android
Resolución: 1080x2340
```

---

## 📁 Estructura del Proyecto

```
QOLECT-AppMovil/
├── lib/
│   ├── backend/
│   │   └── api_requests/
│   │       └── api_calls.dart       # ⚠️ EN MIGRACIÓN - NO MODIFICAR
│   ├── components/                  # Widgets reutilizables
│   │   ├── home_drawer/
│   │   └── planes_list/
│   ├── pages/                       # Pantallas principales
│   │   ├── login_page/
│   │   ├── comunidad/
│   │   ├── notices_page/
│   │   └── web_view_plan/
│   ├── flutter_flow/                # Configuración FlutterFlow
│   │   ├── flutter_flow_theme.dart
│   │   └── nav/
│   └── main.dart                    # Entry point
├── assets/
│   └── images/                      # Imágenes y assets
├── android/                         # Configuración Android
├── ios/                             # Configuración iOS
├── CONTRIBUTING.md                  # ⭐ Guía de contribución
└── README.md                        # Este archivo
```

---

## 🔧 Tecnologías

| Tecnología | Uso |
|------------|-----|
| **Flutter 3.x** | Framework principal |
| **FlutterFlow** | Generación de UI |
| **Firebase Auth** | Autenticación (Google Sign-In) |
| **FastAPI** | Backend API (en migración) |
| **Supabase** | Base de datos PostgreSQL |
| **WordPress** | Backend legacy (en deprecación) |

---

## 🎨 Funcionalidades Principales

### ✅ Implementadas

- 🔐 **Autenticación**
  - Login con Google (Firebase Auth)
  - Gestión de sesión

- 📰 **Noticias**
  - Lista de noticias con imágenes
  - Detalle de noticia con transiciones
  - Diseño optimizado

- 🗺️ **Viajes**
  - Lista de viajes del usuario
  - Detalle de viaje (preparado para datos dinámicos)
  - Sistema de calificación

- 📦 **Planes**
  - Catálogo de paquetes turísticos
  - Filtros y búsqueda
  - Detalle de plan

- 👥 **Comunidad**
  - Experiencias de usuarios
  - Galería de fotos/videos
  - Publicar experiencias

- 🎨 **UI/UX Mejorada** (2025-10-14)
  - Nuevo diseño de login
  - SideBar rediseñado
  - Splash screen actualizado
  - Onboarding mejorado
  - Optimización de performance

### ⏳ En Desarrollo

- 🔄 Migración a nueva API (Fase 4)
- 🔔 Sistema de notificaciones push
- 💾 Modo offline
- 📊 Analytics mejorados

---

## 🔀 Flujo de Desarrollo

### Estrategia de Branches

```
main (producción)
  └── dev (desarrollo)
       └── feature/* (nuevas funcionalidades)
       └── fix/* (correcciones)
       └── performance/* (optimizaciones)
```

### Crear Feature

```bash
# 1. Actualizar main
git checkout main
git pull origin main

# 2. Crear rama
git checkout -b feature/mi-funcionalidad

# 3. Desarrollar y commitear
git add .
git commit -m "feat: descripción clara"

# 4. Push y crear PR
git push -u origin feature/mi-funcionalidad
# Ir a GitHub y crear Pull Request
```

**Ver**: [CONTRIBUTING.md](./CONTRIBUTING.md) para detalles completos

---

## 📝 Convenciones

### Commits

Usamos [Conventional Commits](https://www.conventionalcommits.org/):

```bash
feat: nueva funcionalidad
fix: corrección de bug
perf: mejora de performance
refactor: refactorización de código
style: cambios de formato
docs: documentación
test: tests
chore: mantenimiento
```

### Código

- ✅ Widgets pequeños y reutilizables
- ✅ Nombres descriptivos en inglés
- ✅ Comentarios en español para lógica compleja
- ✅ Evitar hardcodear strings (usar i18n si es posible)

---

## 🧪 Testing

```bash
# Análisis de código
flutter analyze

# Tests unitarios
flutter test

# Build de prueba
flutter build apk --debug
```

---

## 🚨 Problemas Comunes

### "Bad state: Cannot add new events after calling close"

```bash
flutter clean
flutter pub get
flutter run
```

### "Gradle build failed"

```bash
cd android
./gradlew clean
cd ..
flutter run
```

### "Pod install failed" (iOS)

```bash
cd ios
pod deintegrate
pod install
cd ..
flutter run
```

---

## 📞 Equipo y Comunicación

### Antes de Hacer Cambios

1. ✅ Lee [CONTRIBUTING.md](./CONTRIBUTING.md)
2. ✅ Verifica [ESTADO_ACTUAL.md](../QOLECT-Documentacion/ESTADO_ACTUAL.md)
3. ✅ Comenta en issue o crea uno nuevo
4. ✅ Coordina en chat del equipo

### Áreas Críticas (Requieren Aprobación)

- ❌ `lib/backend/api_requests/api_calls.dart` (en migración)
- ❌ `android/app/build.gradle`
- ❌ `pubspec.yaml`
- ❌ Firebase Auth
- ❌ Navegación principal

---

## 📚 Documentación Adicional

| Documento | Descripción |
|-----------|-------------|
| [CONTRIBUTING.md](./CONTRIBUTING.md) | Guía de contribución (⭐ obligatorio) |
| [ESTADO_ACTUAL.md](../QOLECT-Documentacion/ESTADO_ACTUAL.md) | Estado del proyecto |
| [CHANGELOG_FLUTTER.md](../QOLECT-Documentacion/CHANGELOG_FLUTTER.md) | Historial de cambios |
| [PROYECTO_RESUMEN_COMPLETO.md](./PROYECTO_RESUMEN_COMPLETO.md) | Contexto completo |
| [MIGRATION_STRATEGY.md](./MIGRATION_STRATEGY.md) | Plan de migración |

---

## 🔗 Enlaces Útiles

- **Repositorio**: https://github.com/Invbu1414/QOLECT-AppMovil
- **Firebase Console**: https://console.firebase.google.com
- **Supabase Dashboard**: https://supabase.com/dashboard
- **API Docs** (local): http://localhost:8000/docs
- **FlutterFlow**: https://flutterflow.io/

---

## 📊 Estado del Proyecto

| Métrica | Valor |
|---------|-------|
| **Progreso Global** | 75% |
| **Backend API** | 100% ✅ |
| **Migración Flutter** | 0% ⏳ |
| **Última Actualización** | 2025-10-14 |
| **Última Versión** | Mergeo de feature/performance-improvement |

---

## 🏆 Changelog Reciente

### 2025-10-14 - Mejoras UI/UX por Diego
- ✅ Rediseño completo de login
- ✅ Nuevo SideBar con paleta actualizada
- ✅ Optimización de pantallas de noticias y comunidad
- ✅ Eliminación de WebView (mejor performance)
- ✅ Nuevos íconos de app
- ✅ -1,253 líneas de código (optimización)

**Ver detalles**: [CHANGELOG_FLUTTER.md](../QOLECT-Documentacion/CHANGELOG_FLUTTER.md)

---

## 📄 Licencia

Propietario: QOLECT
Todos los derechos reservados.

---

## 🆘 Soporte

¿Tienes dudas? **No adivines, pregunta primero**.

1. Lee [CONTRIBUTING.md](./CONTRIBUTING.md)
2. Busca en issues existentes
3. Crea un issue nuevo
4. Contacta al equipo

---

**Última actualización**: 2025-10-14
**Mantenido por**: Equipo QOLECT
