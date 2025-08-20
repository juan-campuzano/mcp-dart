# 🔑 Configuración de Variables de Entorno

## ¿Por qué usar .env?

Las variables de entorno mantienen información sensible (como API keys) fuera del código fuente, lo que es una práctica de seguridad esencial.

## 📋 Instrucciones de Configuración

### 1. Crear el archivo .env

```bash
# En la raíz del proyecto, copia el archivo de ejemplo:
cp .env.example .env
```

### 2. Obtener tu API Key de Gemini

1. Ve a [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Inicia sesión con tu cuenta de Google
3. Haz clic en "Create API Key"
4. Copia la API key generada

### 3. Configurar el archivo .env

Abre el archivo `.env` y reemplaza `tu_api_key_aqui` con tu API key real:

```bash
# Antes:
GEMINI_API_KEY=tu_api_key_aqui

# Después:
GEMINI_API_KEY=AIzaSyD...Tu_API_Key_Real_Aqui...XYZ123
```

### 4. Verificar la configuración

El archivo `.env` debe verse así:

```bash
# Configuración de API Keys
GEMINI_API_KEY=AIzaSyD...Tu_API_Key_Real_Aqui...XYZ123
```

## ⚠️ Importante - Seguridad

- ✅ **SÍ incluir**: `.env.example` en Git
- ❌ **NO incluir**: `.env` en Git (ya está en .gitignore)
- 🔒 **Mantener privado**: Tu archivo `.env` con las API keys reales
- 🔄 **Regenerar**: API keys si se comprometen

## 🚀 Ejecutar la aplicación

Una vez configurado:

```bash
flutter pub get
flutter run
```

## 🐛 Solución de Problemas

### Error: "GEMINI_API_KEY no encontrada en el archivo .env"

1. Verifica que el archivo `.env` existe en la raíz del proyecto
2. Verifica que la variable está escrita correctamente: `GEMINI_API_KEY=tu_key_aqui`
3. Reinicia la aplicación después de cambiar el .env

### Error: "Invalid API Key"

1. Verifica que copiaste la API key completa
2. Asegúrate de que no hay espacios extra antes o después de la key
3. Genera una nueva API key en Google AI Studio

## 📁 Estructura de Archivos

```
proyecto/
├── .env                 ← Tu archivo privado (no en Git)
├── .env.example         ← Plantilla pública (sí en Git)
├── .gitignore          ← Incluye .env
└── lib/
    └── services/
        └── gemini_service.dart  ← Carga las variables
```
