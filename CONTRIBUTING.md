# 🤝 Guía de Contribución - QOLECT App Móvil

> **Importante**: Lee esta guía ANTES de hacer cambios al proyecto

---

## 🚨 ESTADO ACTUAL DEL PROYECTO

### ⚠️ MIGRACIÓN EN PROGRESO

**El proyecto está en medio de una migración crítica**:
- **De**: WordPress API (app.qolect.co)
- **A**: Python FastAPI + Supabase PostgreSQL (nueva arquitectura)

**Progreso**: 75% completado
- ✅ Fase 0-3: Base de datos y API Backend completa
- ✅ API funcionando en: `http://localhost:8000`
- ⏳ Fase 4: Migración de Flutter (PENDIENTE)

---

## 📋 ANTES DE HACER CAMBIOS

### 1. **Verificar Estado Actual**

Lee estos archivos en orden:
1. `../QOLECT-Documentacion/ESTADO_ACTUAL.md` - Estado del proyecto
2. `../QOLECT-Documentacion/LEEME_PRIMERO.md` - Contexto general
3. Este archivo (CONTRIBUTING.md) - Guía de contribución

### 2. **Comunicar tus Cambios**

**SIEMPRE** comunica con el equipo ANTES de:
- ❌ Modificar archivos de configuración de API
- ❌ Cambiar la estructura de navegación
- ❌ Actualizar dependencias mayores
- ❌ Modificar `api_calls.dart` (en migración activa)
- ❌ Cambiar Firebase Auth
- ❌ Modificar build.gradle files

**Puedes hacer sin preguntar**:
- ✅ Mejoras de UI/UX en componentes existentes
- ✅ Optimización de imágenes
- ✅ Corrección de bugs visuales
- ✅ Actualización de textos/traducciones
- ✅ Nuevos widgets reutilizables

---

## 🔀 Estrategia de Branches (Ramas)

### Ramas Principales

```
main (producción)
  └── dev (desarrollo)
       └── feature/* (nuevas funcionalidades)
       └── fix/* (correcciones)
       └── performance/* (optimizaciones)
```

### Convención de Nombres de Ramas

```bash
# Nueva funcionalidad
feature/nombre-descriptivo
Ejemplo: feature/new-payment-method

# Corrección de bug
fix/descripcion-del-bug
Ejemplo: fix/login-button-crash

# Mejora de performance
performance/que-se-optimizo
Ejemplo: performance/image-loading

# Refactoring
refactor/componente-refactorizado
Ejemplo: refactor/home-drawer
```

---

## 🔄 Flujo de Trabajo Git

### Paso 1: Crear una Rama Nueva

```bash
# Asegúrate de estar en main y actualizado
git checkout main
git pull origin main

# Crea tu rama desde main
git checkout -b feature/mi-nueva-funcionalidad
```

### Paso 2: Hacer tus Cambios

```bash
# Trabaja normalmente
# Commit frecuentemente con mensajes descriptivos

git add .
git commit -m "feature: descripción clara del cambio"
```

### Paso 3: Subir tu Rama

```bash
# Primera vez
git push -u origin feature/mi-nueva-funcionalidad

# Siguientes veces
git push
```

### Paso 4: Crear Pull Request

1. Ve a GitHub: `https://github.com/Invbu1414/QOLECT-AppMovil/pulls`
2. Click "New Pull Request"
3. **Base**: `main` ← **Compare**: `tu-rama`
4. Completa el template (ver abajo)
5. Asigna a alguien para revisar
6. **NO mergees inmediatamente** - espera revisión

---

## 📝 Template de Pull Request

```markdown
## 🎯 Descripción

¿Qué cambia este PR?

## 🔧 Tipo de Cambio

- [ ] 🐛 Bug fix (corrección de bug)
- [ ] ✨ Nueva funcionalidad
- [ ] 🎨 Mejora de UI/UX
- [ ] ⚡ Mejora de performance
- [ ] 🔨 Refactoring
- [ ] 📝 Documentación

## 📸 Screenshots (si aplica)

[Agrega capturas antes/después]

## ✅ Checklist

- [ ] Probé los cambios localmente
- [ ] No hay errores de compilación
- [ ] La app corre en emulador
- [ ] No rompe funcionalidades existentes
- [ ] Actualicé documentación si es necesario

## ⚠️ Impacto

¿Afecta API calls? ¿Afecta navegación? ¿Rompe algo?

## 🔗 Issue relacionado

Closes #[número] (si aplica)
```

---

## 📜 Convención de Commits

Usa este formato:

```bash
tipo: descripción breve en minúsculas

[cuerpo opcional con más detalles]
```

### Tipos de Commits

| Tipo | Cuándo usar | Ejemplo |
|------|-------------|---------|
| `feat` | Nueva funcionalidad | `feat: add payment gateway integration` |
| `fix` | Corrección de bug | `fix: resolve login crash on Android` |
| `perf` | Mejora de performance | `perf: optimize image loading in gallery` |
| `refactor` | Cambio de código sin afectar comportamiento | `refactor: simplify home drawer widget` |
| `style` | Cambios de formato (no afectan código) | `style: format code with prettier` |
| `docs` | Documentación | `docs: update README with setup steps` |
| `test` | Tests | `test: add unit tests for auth service` |
| `chore` | Mantenimiento | `chore: update dependencies` |

### Ejemplos Reales

```bash
# ✅ BIEN
git commit -m "feat: add password reset functionality"
git commit -m "fix: resolve button overlap on small screens"
git commit -m "perf: reduce app startup time by 30%"

# ❌ MAL
git commit -m "changes"
git commit -m "fixed stuff"
git commit -m "Update login_page.dart"
```

---

## 🚫 Archivos que NO Debes Commitear

Estos archivos están en `.gitignore` y NO deben subirse:

```
# Build outputs
build/
android/build/
ios/build/
.dart_tool/

# IDE
.vscode/
.idea/
*.iml

# Dependencias
.flutter-plugins
.flutter-plugins-dependencies
pubspec.lock (ya está, pero no modificar)

# Secrets
.env
google-services.json (si tiene credenciales reales)
GoogleService-Info.plist (si tiene credenciales reales)

# Temporal
*.log
nul
```

---

## ⚠️ ÁREAS CRÍTICAS - NO MODIFICAR SIN APROBACIÓN

### 🔴 Archivos Prohibidos para Cambio Directo

| Archivo | Razón |
|---------|-------|
| `lib/backend/api_requests/api_calls.dart` | **EN MIGRACIÓN ACTIVA** - Se está migrando de WordPress a FastAPI |
| `android/app/build.gradle` | Configuración crítica de build |
| `android/build.gradle` | Configuración crítica de build |
| `ios/Runner.xcodeproj/*` | Configuración iOS |
| `pubspec.yaml` | Requiere coordinación de dependencias |
| `lib/flutter_flow/nav/nav.dart` | Navegación central |
| `.env` | Credenciales sensibles |

### 🟡 Áreas Sensibles - Pedir Revisión

- Firebase Auth (`lib/auth/*`)
- Navegación (`lib/flutter_flow/nav/*`)
- Configuración de tema (`lib/flutter_flow/flutter_flow_theme.dart`)
- API models (`lib/backend/schema/*`)

---

## 🧪 Testing Antes de PR

### Checklist Obligatorio

```bash
# 1. Compilar sin errores
flutter pub get
flutter clean
flutter build apk --debug

# 2. Correr en emulador
flutter run

# 3. Probar flujo completo
# - Login
# - Navegación principal
# - Funcionalidad que modificaste
```

### Si Modificaste UI

- ✅ Probar en diferentes tamaños de pantalla
- ✅ Verificar modo claro/oscuro (si aplica)
- ✅ Probar scroll en listas largas
- ✅ Verificar que textos no se corten

---

## 🔍 Code Review - Qué Esperamos

Cuando revises un PR de otro developer:

### ✅ Aprueba si:
- Código es legible y bien estructurado
- No rompe funcionalidades existentes
- Tiene commits bien nombrados
- Probó localmente y funciona

### 🔄 Pide Cambios si:
- Hay código duplicado innecesario
- No sigue las convenciones
- Faltan screenshots de cambios visuales
- No probó en emulador

### ❌ Rechaza si:
- Modifica archivos críticos sin aprobación
- Rompe funcionalidades existentes
- Tiene credenciales hardcodeadas
- No compila

---

## 📞 Comunicación

### Antes de Empezar
- 💬 Comenta en el issue o crea uno nuevo
- 📢 Avisa en el chat del equipo
- 🤔 Pregunta si tienes dudas

### Durante el Desarrollo
- 🔄 Haz commits pequeños y frecuentes
- 📝 Documenta decisiones importantes
- 🆘 Pide ayuda si te atoras

### Al Terminar
- ✅ Crea PR con descripción clara
- 📸 Agrega screenshots si cambió UI
- 👀 Asigna reviewer
- ⏰ Estate disponible para feedback

---

## 🛠️ Comandos Útiles

### Actualizar tu Rama con main

```bash
# Opción 1: Merge (recomendado para features cortos)
git checkout mi-rama
git merge main

# Opción 2: Rebase (para features largos)
git checkout mi-rama
git rebase main
```

### Deshacer Cambios

```bash
# Descartar cambios locales (¡CUIDADO!)
git restore nombre-archivo.dart

# Descartar TODOS los cambios locales (¡MUCHO CUIDADO!)
git restore .

# Volver a un commit anterior
git reset --soft HEAD~1  # Mantiene cambios
git reset --hard HEAD~1  # BORRA cambios
```

### Ver qué Cambió

```bash
# Ver archivos modificados
git status

# Ver diferencias
git diff

# Ver historial
git log --oneline --graph
```

---

## 🆘 Problemas Comunes

### "Ya existe una rama con ese nombre"
```bash
git fetch --all
git branch -D nombre-rama  # Borra local
git checkout -b nombre-rama
```

### "Conflictos al hacer merge"
```bash
# 1. Abre los archivos marcados con <<<<<
# 2. Resuelve manualmente (elimina <<<< ==== >>>>)
# 3. Marca como resuelto
git add archivo-resuelto.dart
git commit -m "merge: resolve conflicts"
```

### "No puedo hacer push"
```bash
# Primero pull
git pull origin main
# Resuelve conflictos si hay
# Luego push
git push
```

---

## 📚 Recursos

- **Documentación del Proyecto**: `../QOLECT-Documentacion/`
- **Estado Actual**: `../QOLECT-Documentacion/ESTADO_ACTUAL.md`
- **Guía de API**: `../QOLECT-Documentacion/API_MIGRATION_GUIDE.md` (próximamente)
- **Git Flow**: https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow
- **Conventional Commits**: https://www.conventionalcommits.org/

---

## ✅ Checklist Final Antes de PR

- [ ] Lei ESTADO_ACTUAL.md
- [ ] Mi rama está actualizada con main
- [ ] Usé nombres de commits convencionales
- [ ] Probé en emulador
- [ ] No commitée archivos de build
- [ ] No modifiqué archivos críticos sin aprobación
- [ ] Agregué screenshots si cambió UI
- [ ] Actualicé documentación si es necesario
- [ ] Mi PR tiene descripción clara

---

**¿Dudas?** Pregunta ANTES de hacer el PR. Es mejor prevenir que corregir.

**Última actualización**: 2025-10-14
