# Flutter-Biodiversity-App

Aplicación móvil orientada a la divulgación ambiental y biodiversidad del estado de Guanajuato.

---

## 📱 Descripción

Este proyecto es una aplicación desarrollada en **Flutter** que permite a los usuarios:

- Explorar especies de flora y fauna
- Registrar avistamientos
- Visualizar reportes en un mapa
- Gestionar sus propios reportes

La app está pensada como una herramienta educativa y de concientización ambiental.

---

## 🚀 Features principales

- 🔐 Autenticación de usuarios (Firebase Auth)
- 🧭 Navegación estructurada (Bottom Navigation + Drawer)
- 🐾 Catálogo de especies (Grid View moderno)
- 📄 Vista de detalle tipo ficha técnica
- 📝 Registro de avistamientos (formulario completo)
- ☁️ Persistencia en la nube (Firestore)
- 🗺️ Mapa interactivo (flutter_map + OpenStreetMap)
- 📊 Visualización de reportes del usuario

---

## 🧱 Tecnologías utilizadas

- **Flutter**
- **Dart**
- **Firebase Authentication**
- **Cloud Firestore**
- **flutter_map**
- **OpenStreetMap**

---

## 🧠 Arquitectura (MVP)

La aplicación sigue una estructura simple basada en:

- UI en Flutter
- Backend gestionado con Firebase
- Datos estructurados en colecciones (Firestore)

---

## 📂 Estructura del proyecto

```text
lib/
 ├── data/
 ├── models/
 ├── screens/
 ├── widgets/