/// Configuración de la aplicación para diferentes ambientes
class AppConfig {
  // ========== URLs DE API ==========

  /// URL base para desarrollo local
  static const String API_BASE_URL_DEV = "http://localhost:8000";

  /// URL base para producción en Google Cloud Run
  static const String API_BASE_URL_PROD =
      "https://qolect-api-820237834683.us-central1.run.app";

  // ========== API KEYS ==========

  /// API Key para desarrollo (puede ser vacía o "dev")
  static const String API_KEY_DEV = "";

  /// API Key para producción
  static const String API_KEY_PROD = "qolect-api-key-prod-2024-secure-abc123xyz";

  // ========== DETECCIÓN DE AMBIENTE ==========

  /// Determina si estamos en modo producción
  /// En Flutter, dart.vm.product es true cuando compilas con --release
  static const bool IS_PRODUCTION = bool.fromEnvironment(
    'dart.vm.product',
    defaultValue: false,
  );

  // ========== GETTERS PARA USO EN LA APP ==========

  /// Obtiene la URL base de la API según el ambiente
  static String get apiBaseUrl =>
      IS_PRODUCTION ? API_BASE_URL_PROD : API_BASE_URL_PROD;

  /// Obtiene la API Key según el ambiente
  /// NOTA: Siempre usa la API key de producción porque siempre nos conectamos a producción
  static String get apiKey => API_KEY_PROD;

  /// Obtiene el nombre del ambiente actual (para debug)
  static String get environment => IS_PRODUCTION ? "PRODUCCIÓN" : "DESARROLLO";

  // ========== MÉTODOS DE UTILIDAD ==========

  /// Imprime información de configuración (solo en debug)
  static void printConfig() {
    if (!IS_PRODUCTION) {
      print('=== CONFIGURACIÓN DE LA APP ===');
      print('Ambiente: $environment');
      print('API Base URL: $apiBaseUrl');
      print('API Key configurada: ${apiKey.isNotEmpty ? "Sí" : "No"}');
      print('================================');
    }
  }

  /// Verifica si la configuración está completa
  static bool isConfigured() {
    if (IS_PRODUCTION) {
      // En producción, verificar que la URL no sea la de ejemplo
      return !API_BASE_URL_PROD.contains('xxxxx') && apiKey.isNotEmpty;
    }
    // En desarrollo, siempre está configurado
    return true;
  }

  /// Obtiene el mensaje de error si la configuración está incompleta
  static String? getConfigError() {
    if (!isConfigured()) {
      return 'La configuración de producción no está completa. '
          'Verifica lib/core/config.dart';
    }
    return null;
  }
}

