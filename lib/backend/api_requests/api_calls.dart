import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';
import '/core/config.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class WordPressLoginCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "${username}",
  "password": "${password}",
  "token": "!?zEJ4!g~?o\$ZqMaP#k-2C>;}#m26w0@H9a"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'WordPress Login',
      apiUrl: 'https://app.qolect.co/wp-json/jwt-auth/v1/token',
      callType: ApiCallType.POST,
      headers: _apiHeaders,
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? token(dynamic response) => (getJsonField(
        response,
        r'''$.token''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? email(dynamic response) => (getJsonField(
        response,
        r'''$.user_email''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? nicename(dynamic response) => (getJsonField(
        response,
        r'''$.user_nicename''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? displayName(dynamic response) => (getJsonField(
        response,
        r'''$.user_display_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
}

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
      headers: _apiHeaders,
      params: {
        'acf_format': "standard",
        'acf_author': author,
        'acf_after': after,
        'acf_before': before,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? date(dynamic response) => (getJsonField(
        response,
        r'''$[:].date''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? dateGmt(dynamic response) => (getJsonField(
        response,
        r'''$[:].date_gmt''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorId(dynamic response) => (getJsonField(
        response,
        r'''$[:].author''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? destino(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.destino''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? descripcion(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.descripcion''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? direccion(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.direccion_detallada''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? fechaSalida(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.fecha_de_salida''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? fechLlegada(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.fecha_de_llegada''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? calificacion(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.calificacion''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? imagenCard(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.imagen_para_card''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? imagenCopiar(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.imagen_para_card_copiar''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$[:].title.rendered''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? destinoNombre(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.en_destino_documentos[:].nombre''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? destinoPdf(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.en_destino_documentos[:].pdf''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? destinoIcono(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.en_destino_documentos[:].icono''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? regresoNombre(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.de_regreso_a_casa_documentos[:].nombre''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? regresoPdf(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.de_regreso_a_casa_documentos[:].pdf''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<String>? regresoIcono(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.de_regreso_a_casa_documentos[:].icono''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? viajeIcono(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.prepara_tu_viaje_documentos[:].icono''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? viajePdf(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.prepara_tu_viaje_documentos[:].pdf''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? viajeNombre(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.prepara_tu_viaje_documentos[:].nombre''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? arrayDestino(dynamic response) => getJsonField(
        response,
        r'''$[:].acf.en_destino_documentos''',
        true,
      ) as List?;
  static List? arrayRegreso(dynamic response) => getJsonField(
        response,
        r'''$[:].acf.de_regreso_a_casa_documentos''',
        true,
      ) as List?;
  static List? arrayViaje(dynamic response) => getJsonField(
        response,
        r'''$[:].acf.prepara_tu_viaje_documentos''',
        true,
      ) as List?;
}

class WordpressNoticiasCall {
  static Future<ApiCallResponse> call({
    String? author = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Wordpress Noticias',
      apiUrl: 'https://app.qolect.co/wp-json/wp/v2/noticias/?nocachee',
      callType: ApiCallType.GET,
      headers: _apiHeaders,
      params: {
        'acf_format': "standard",
        'acf_author': author,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? date(dynamic response) => (getJsonField(
        response,
        r'''$[:].date''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$[:].title.rendered''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? author(dynamic response) => (getJsonField(
        response,
        r'''$[:].author''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? imagen(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.imagen.url''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? descripcion(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.descripcion''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? adjunto(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.adjunto''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class WordpressNotificacionesCall {
  static Future<ApiCallResponse> call({
    String? author = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Wordpress Notificaciones',
      apiUrl: 'https://app.qolect.co/wp-json/wp/v2/notificaciones',
      callType: ApiCallType.GET,
      headers: _apiHeaders,
      params: {
        'acf_format': "standard",
        'acf_author': author,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? id(dynamic response) => getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?;
  static List? date(dynamic response) => getJsonField(
        response,
        r'''$[:].date''',
        true,
      ) as List?;
  static List? title(dynamic response) => getJsonField(
        response,
        r'''$[:].title.rendered''',
        true,
      ) as List?;
  static List? author(dynamic response) => getJsonField(
        response,
        r'''$[:].author''',
        true,
      ) as List?;
  static List? textoNotificacion(dynamic response) => getJsonField(
        response,
        r'''$[:].acf.texto_notificacion''',
        true,
      ) as List?;
}

class WordPressUserCall {
  static Future<ApiCallResponse> call({
    String? author = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'WordPress User',
      apiUrl:
          'https://app.qolect.co/wp-json/wp/v2/users/${author}/?acf_format=standard',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  static String? nombre(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
  static String? foto(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.acf.foto.url''',
      ));
  static String? telefono(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.acf.telefono''',
      ));
  static bool? verificado(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.acf.verificado''',
      ));
}

class WordPressRateCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    int? postId,
    double? calificacion,
    String? calificacionTexto = '',
  }) async {
    final ffApiRequestBody = '''
{
  "acf": {
    "calificacion": ${calificacion},
    "calificacion_texto": "${calificacionTexto}"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'WordPress rate',
      apiUrl:
          'https://app.qolect.co/wp-json/wp/v2/viaje/${postId}?acf_format=standard',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class WordPressProfileCall {
  static Future<ApiCallResponse> call({
    int? id,
    String? token = '',
    String? celular = '',
    String? contrasena = '',
    int? pictureId,
    String? pictureIdX = '',
    String? celularX = '',
    String? contrasenaX = '',
  }) async {
    final ffApiRequestBody = '''
{
  "password${contrasenaX}": "${contrasena}",
  "acf": {
    "telefono${celularX}": "${celular}",
    "foto${pictureIdX}": "${pictureId}"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'WordPress Profile',
      apiUrl: 'https://app.qolect.co/wp-json/wp/v2/users/${id}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class WordpressResetPasswordCall {
  static Future<ApiCallResponse> call({
    String? email = '',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "${email}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Wordpress reset password',
      apiUrl: 'https://app.qolect.co/wp-json/sense/v1/forgot-password',
      callType: ApiCallType.POST,
      headers: _apiHeaders,
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class WordPressNotificationsUpdateCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    int? userId,
    int? notiId,
  }) async {
    final ffApiRequestBody = '''
{
  "user_id": "${userId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'WordPress Notifications update',
      apiUrl:
          'https://app.qolect.co/wp-json/sense/v1/editar-notificacion/${notiId}',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UploadMediaCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    FFUploadedFile? file,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'UploadMedia',
      apiUrl: 'https://app.qolect.co/wp-json/wp/v2/media',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {
        'file': file,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class WordpressSendLeadCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? adultos = '',
    String? ninos = '',
    String? infantes = '',
    String? trayecto = '',
    String? origen = '',
    String? destino = '',
    String? ida = '',
    String? vuelta = '',
    String? equipaje = '',
    String? nombre = '',
    String? email = '',
    String? telefono = '',
    String? tipo = '',
  }) async {
    final ffApiRequestBody = '''
{
  "numero_de_adultos": "${adultos}",
  "numero_de_ninos": "${ninos}",
  "numero_de_infantes": "${infantes}",
  "trayecto": "${trayecto}",
  "origen": "${origen}",
  "destino": "${destino}",
  "fecha_ida": "${ida}",
  "fecha_vuelta": "${vuelta}",
  "equipaje": "${equipaje}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Wordpress Send lead',
      apiUrl: 'https://app.qolect.co/wp-json/miplugin/v1/enviar-correo/',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class WordPRessRegisterUserCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? email = '',
    String? password = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'WordPRess Register User',
      apiUrl: 'https://app.qolect.co/wp-json/wp/v2/users',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {
        'username': username,
        'email': email,
        'password': password,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? username(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.username''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
}

class WordPressDeleteUserCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    int? id,
  }) async {
    final ffApiRequestBody = '''
{
  "user_id": "${id}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'WordPress delete user',
      apiUrl: 'https://app.qolect.co/wp-json/user-delete-api/v1/delete-user/',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class WordpressPlanesCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'Wordpress Planes',
      apiUrl: 'https://app.qolect.co/wp-json/v2/plans',
      callType: ApiCallType.GET,
      headers: _apiHeaders,
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? planId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].plan_id''',
      ));
  static String? planTitle(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].plan_title''',
      ));
  static String? planImage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].plan_image''',
      ));
  static String? planPrice(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].plan_price''',
      ));
  static String? planUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].plan_url''',
      ));
}

class WordPressExperienciasComunidadCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'WordPress Experiencias Comunidad',
      apiUrl: 'https://app.qolect.co/wp-json/v2/experiences',
      callType: ApiCallType.GET,
      headers: _apiHeaders,
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? experienceId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].experience_id''',
      ));
  static String? experienceComments(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].experience_comments''',
      ));
  static String? experienceTextPrev(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].experience_text_prev''',
      ));
  static String? experienceImage(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].experience_image''',
      ));
  static String? experienceVideo(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].experience_video''',
      ));
  static String? experienceUserImage(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].user_image''',
      ));
  static String? experienceUserName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].user_name''',
      ));
  static bool? experienceHasVideo(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$[:].experience_has_video''',
      ));
}

class WordPressGuardarExperienciaCall {
  static Future<ApiCallResponse> call({
    String? comentario = '',
    int? idImagen,
    int? idVideo,
    String? textoPrev = '',
    int? idUsuario,
  }) async {
    final ffApiRequestBody = '''
{
  "comentario": "${escapeStringForJson(comentario)}",
  "id_imagen": ${idImagen},
  "id_video": ${idVideo},
  "id_usuario": ${idUsuario}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'WordPress guardar experiencia',
      apiUrl: 'https://app.qolect.co/wp-json/v2/experiences',
      callType: ApiCallType.POST,
      headers: _apiHeaders,
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class WordPressValidarExistenciaCall {
  static Future<ApiCallResponse> call({
    String? email = '',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "email"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'WordPress Validar existencia',
      apiUrl: 'https://app.qolect.co/wp-json/v2/email-exist',
      callType: ApiCallType.POST,
      headers: _apiHeaders,
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static bool? userExist(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.userExist''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}


class WordpressPlanDetailCall {
  static Future<ApiCallResponse> call({
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Wordpress Plan Detail',
      apiUrl: 'https://app.qolect.co/wp-json/v2/plans/${id}',
      callType: ApiCallType.GET,
      headers: _apiHeaders,
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

// ============================================================================
// NUEVAS API CALLS - PYTHON FASTAPI
// Base URL: Configurada dinámicamente según ambiente (dev/prod) en AppConfig
// ============================================================================

/// Base URL para la nueva API Python FastAPI
// Usa AppConfig.apiBaseUrl que cambia automáticamente según el ambiente
String get _pythonApiBaseUrl => '${AppConfig.apiBaseUrl}/api/v1/mobile';

/// Headers comunes para todas las llamadas a la API
// Incluye X-API-Key solo en producción
Map<String, String> get _apiHeaders => {
  'Content-Type': 'application/json',
  if (AppConfig.apiKey.isNotEmpty) 'X-API-Key': AppConfig.apiKey,
};

/// GET /noticias - Listar noticias (público)
class FastAPINoticiasCall {
  static Future<ApiCallResponse> call({
    int skip = 0,
    int limit = 20,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Noticias',
      apiUrl: '${_pythonApiBaseUrl}/noticias',
      callType: ApiCallType.GET,
      headers: _apiHeaders,
      params: {
        'skip': skip,
        'limit': limit,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].idnoticia''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<String>? titulo(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].titulo''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? descripcion(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].descripcion''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? imagenUrl(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].imagen''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? adjuntoUrl(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].adjunto_url''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? fechaCreacion(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].created_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static int? total(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.total''',
      ));
}

/// GET /planes - Listar planes/productos (público)
class FastAPIPlanesCall {
  static Future<ApiCallResponse> call({
    int skip = 0,
    int limit = 20,
    String? categoria,
  }) async {
    final params = <String, dynamic>{
      'skip': skip,
      'limit': limit,
    };

    if (categoria != null && categoria.isNotEmpty) {
      params['categoria'] = categoria;
    }

    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Planes',
      apiUrl: '${_pythonApiBaseUrl}/planes',
      callType: ApiCallType.GET,
      headers: _apiHeaders,
      params: params,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<String>? nombre(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].nombre''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? descripcion(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].descripcion''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<double>? precio(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].precio''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();

  static List<String>? imagenUrl(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].imagen_url''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? categoria(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].categoria.nombre''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static int? total(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.total''',
      ));
}

/// GET /viajes - Listar viajes del usuario (requiere auth)
/// GET /viajes - Obtener viajes del usuario (Python API - Compatible con WordPress ACF)
class FastAPIViajesCall {
  static Future<ApiCallResponse> call({
    String? author = '',
    String? after = '2000-09-06',
    String? before = '2100-09-06',
    String? token = '',
    bool? isActive,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Viajes',
      apiUrl: '${_pythonApiBaseUrl}/viajes',
      callType: ApiCallType.GET,
      headers: {
        ..._apiHeaders,
        'Authorization': 'Bearer ${token}',
      },
      params: {
        'user_id': author,
        'after': after,
        'before': before,
        if (isActive != null) 'is_active': isActive,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  // Extractors - Mismos que WordpressViajesCall para compatibilidad
  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<String>? date(dynamic response) => (getJsonField(
        response,
        r'''$[:].date''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? dateGmt(dynamic response) => (getJsonField(
        response,
        r'''$[:].date_gmt''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<int>? authorId(dynamic response) => (getJsonField(
        response,
        r'''$[:].author''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<String>? destino(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.destino''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? descripcion(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.descripcion''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? direccion(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.direccion_detallada''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? fechaSalida(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.fecha_de_salida''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? fechLlegada(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.fecha_de_llegada''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? calificacion(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.calificacion''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? imagenCard(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.imagen_para_card''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? imagenCopiar(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.imagen_para_card_copiar''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$[:].title.rendered''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? destinoNombre(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.en_destino_documentos[:].nombre''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? destinoPdf(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.en_destino_documentos[:].pdf''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? destinoIcono(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.en_destino_documentos[:].icono''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? regresoNombre(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.de_regreso_a_casa_documentos[:].nombre''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<bool>? regresoPdf(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.de_regreso_a_casa_documentos[:].pdf''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();

  static List<String>? regresoIcono(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.de_regreso_a_casa_documentos[:].icono''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? viajeIcono(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.prepara_tu_viaje_documentos[:].icono''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? viajePdf(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.prepara_tu_viaje_documentos[:].pdf''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? viajeNombre(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.prepara_tu_viaje_documentos[:].nombre''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List? arrayDestino(dynamic response) => getJsonField(
        response,
        r'''$[:].acf.en_destino_documentos''',
        true,
      ) as List?;

  static List? arrayRegreso(dynamic response) => getJsonField(
        response,
        r'''$[:].acf.de_regreso_a_casa_documentos''',
        true,
      ) as List?;

  static List? arrayViaje(dynamic response) => getJsonField(
        response,
        r'''$[:].acf.prepara_tu_viaje_documentos''',
        true,
      ) as List?;
}

/// GET /viajes/{id} - Detalle de un viaje (requiere auth)
class FastAPIViajeDetalleCall {
  static Future<ApiCallResponse> call({
    String? firebaseToken = '',
    required int viajeId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Viaje Detalle',
      apiUrl: '${_pythonApiBaseUrl}/viajes/${viajeId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${firebaseToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));

  static String? destino(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.destino''',
      ));

  static String? descripcion(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.descripcion''',
      ));

  static String? direccion(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.direccion_detallada''',
      ));

  static String? fechaSalida(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.fecha_salida''',
      ));

  static String? fechaLlegada(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.fecha_llegada''',
      ));

  static double? calificacion(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.calificacion''',
      ));

  static String? calificacionTexto(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.calificacion_texto''',
      ));

  static String? imagenCardUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.imagen_card_url''',
      ));

  // Documentos JSONB
  static dynamic documentosDestino(dynamic response) => getJsonField(
        response,
        r'''$.documentos.en_destino''',
      );

  static dynamic documentosViaje(dynamic response) => getJsonField(
        response,
        r'''$.documentos.prepara_viaje''',
      );

  static dynamic documentosRegreso(dynamic response) => getJsonField(
        response,
        r'''$.documentos.regreso_casa''',
      );
}

/// PUT /viajes/{id}/rate - Calificar un viaje (requiere auth)
class FastAPIViajeCalificarCall {
  static Future<ApiCallResponse> call({
    String? firebaseToken = '',
    required int viajeId,
    required double calificacion,
    String? comentario = '',
  }) async {
    final ffApiRequestBody = '''
{
  "calificacion": ${calificacion},
  "comentario": "${escapeStringForJson(comentario)}"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Viaje Calificar',
      apiUrl: '${_pythonApiBaseUrl}/viajes/${viajeId}/rate',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${firebaseToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// GET /notificaciones - Listar notificaciones del usuario (requiere auth) - Compatible con WordPress
class FastAPINotificacionesCall {
  static Future<ApiCallResponse> call({
    String? author = '',
    String? token = '',
    bool? onlyUnread,
  }) async {
    final params = <String, dynamic>{
      'user_id': author,
    };

    if (onlyUnread != null) {
      params['only_unread'] = onlyUnread;
    }

    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Notificaciones',
      apiUrl: '${_pythonApiBaseUrl}/notificaciones',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: params,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  // Extractors - Compatible con WordPress ACF format
  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<String>? date(dynamic response) => (getJsonField(
        response,
        r'''$[:].date''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<int>? author(dynamic response) => (getJsonField(
        response,
        r'''$[:].author''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$[:].title.rendered''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? textoNotificacion(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.texto_notificacion''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? tipo(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.tipo''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<bool>? leida(dynamic response) => (getJsonField(
        response,
        r'''$[:].acf.leida''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
}

/// PUT /notifications/{id}/read - Marcar notificación como leída (requiere auth)
class FastAPINotificacionLeerCall {
  static Future<ApiCallResponse> call({
    String? firebaseToken = '',
    required int notificacionId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Notificacion Leer',
      apiUrl: '${_pythonApiBaseUrl}/notifications/${notificacionId}/read',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${firebaseToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// GET /experiencias - Listar experiencias de la comunidad (público)
class FastAPIExperienciasCall {
  static Future<ApiCallResponse> call({
    int skip = 0,
    int limit = 20,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Experiencias',
      apiUrl: '${_pythonApiBaseUrl}/experiencias',
      callType: ApiCallType.GET,
      headers: _apiHeaders,
      params: {
        'skip': skip,
        'limit': limit,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<String>? comentario(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].comentario''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? imagenUrl(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].imagen_url''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? videoUrl(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].video_url''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? usuarioNombre(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].usuario.nombre_completo''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? usuarioFoto(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].usuario.foto_url''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static int? total(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.total''',
      ));
}

/// GET /home - Datos para pantalla HOME (banner + noticias destacadas + planes populares)
class FastAPIHomeCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Home',
      apiUrl: '${_pythonApiBaseUrl}/home',
      callType: ApiCallType.GET,
      headers: _apiHeaders,
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  // Banner
  static String? bannerTitulo(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.banner.titulo''',
      ));

  static String? bannerSubtitulo(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.banner.subtitulo''',
      ));

  static String? bannerImagen(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.banner.imagen''',
      ));

  static String? bannerCtaText(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.banner.cta_text''',
      ));

  // Noticias destacadas (5)
  static List? noticiasDestacadas(dynamic response) => getJsonField(
        response,
        r'''$.noticias_destacadas''',
        true,
      ) as List?;

  static List<int>? noticiasId(dynamic response) => (getJsonField(
        response,
        r'''$.noticias_destacadas[:].idnoticia''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<String>? noticiasTitulo(dynamic response) => (getJsonField(
        response,
        r'''$.noticias_destacadas[:].titulo''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? noticiasDescripcion(dynamic response) => (getJsonField(
        response,
        r'''$.noticias_destacadas[:].descripcion''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? noticiasImagen(dynamic response) => (getJsonField(
        response,
        r'''$.noticias_destacadas[:].imagen''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? noticiasFecha(dynamic response) => (getJsonField(
        response,
        r'''$.noticias_destacadas[:].created_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  // Planes populares (3)
  static List? planesPopulares(dynamic response) => getJsonField(
        response,
        r'''$.planes_populares''',
        true,
      ) as List?;

  static List<int>? planesId(dynamic response) => (getJsonField(
        response,
        r'''$.planes_populares[:].idproducto''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<String>? planesNombre(dynamic response) => (getJsonField(
        response,
        r'''$.planes_populares[:].nombre''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? planesDescripcion(dynamic response) => (getJsonField(
        response,
        r'''$.planes_populares[:].descripcion''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? planesDescripcionCorta(dynamic response) => (getJsonField(
        response,
        r'''$.planes_populares[:].descripcioncorta''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<double>? planesPrecio(dynamic response) => (getJsonField(
        response,
        r'''$.planes_populares[:].precio''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();

  static List<String>? planesImagen(dynamic response) => (getJsonField(
        response,
        r'''$.planes_populares[:].imagen''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

/// POST /login - Login con Python API (compatible con WordPress JWT)
class FastAPILoginCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "${username}",
  "password": "${password}"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Login',
      apiUrl: '${_pythonApiBaseUrl}/login',
      callType: ApiCallType.POST,
      headers: _apiHeaders,
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  // Response fields (compatible con WordPress JWT format)
  static String? token(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.token''',
      ));

  static String? userEmail(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user_email''',
      ));

  static String? userNicename(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user_nicename''',
      ));

  static String? userDisplayName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user_display_name''',
      ));

  static int? userId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
}

/// POST /auth/google-login - Login with Google
class FastAPIGoogleLoginCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? name = '',
    String? photoUrl = '',
    String? firebaseUid = '',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "${email}",
  "name": "${name}",
  "photo_url": "${photoUrl}",
  "firebase_uid": "${firebaseUid}"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Google Login',
      apiUrl: '${AppConfig.apiBaseUrl}/api/v1/auth/google-login',
      callType: ApiCallType.POST,
      headers: _apiHeaders,
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  // Response fields
  static String? token(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.token''',
      ));

  static int? userId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.user_id''',
      ));

  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));

  static String? nombre(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.nombre''',
      ));

  static String? fotoUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.foto_url''',
      ));

  static String? telefono(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.telefono''',
      ));

  static String? nombreusuario(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.nombreusuario''',
      ));

  static bool? verificado(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.verificado''',
      ));

  static bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  // NUEVO: Refresh Token
  static String? refreshToken(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.refresh_token''',
      ));
}

/// POST /validate-email - Validar si email existe
class FastAPIValidateEmailCall {
  static Future<ApiCallResponse> call({
    String? email = '',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "${email}"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Validate Email',
      apiUrl: '${_pythonApiBaseUrl}/validate-email',
      callType: ApiCallType.POST,
      headers: _apiHeaders,
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static bool? exists(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.exists''',
      ));

  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
}

/// POST /register - Registro de nuevo usuario
class FastAPIRegisterCall {
  static Future<ApiCallResponse> call({
    String? name = '',
    String? email = '',
    String? password = '',
    String? telefono = '',
  }) async {
    final ffApiRequestBody = '''
{
  "name": "${name}",
  "email": "${email}",
  "password": "${password}"${telefono != null && telefono.isNotEmpty ? ',\n  "telefono": "${telefono}"' : ''}
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Register',
      apiUrl: '${_pythonApiBaseUrl}/register',
      callType: ApiCallType.POST,
      headers: _apiHeaders,
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? userId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.user_id''',
      ));

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));

  static String? userEmail(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user_email''',
      ));

  static String? userDisplayName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user_display_name''',
      ));

  static String? userNicename(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user_nicename''',
      ));
}

/// GET /users/{id} - Obtener perfil de usuario
class FastAPIGetUserCall {
  static Future<ApiCallResponse> call({
    required int userId,
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Get User',
      apiUrl: '${_pythonApiBaseUrl}/users/${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));

  static String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));

  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));

  static String? username(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.username''',
      ));

  static String? telefono(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.telefono''',
      ));

  static String? fotoUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.foto_url''',
      ));

  static bool? verificado(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.verificado''',
      ));

  static String? createdAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.created_at''',
      ));

  static bool? isActive(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.is_active''',
      ));
}

/// PUT /users/{id} - Actualizar perfil de usuario
class FastAPIUpdateUserCall {
  static Future<ApiCallResponse> call({
    required int userId,
    String? name,
    String? telefono,
    String? fotoUrl,
    String? password,
    String? token = '',
  }) async {
    final Map<String, dynamic> bodyData = {};

    if (name != null) bodyData['name'] = name;
    if (telefono != null) bodyData['telefono'] = telefono;
    if (fotoUrl != null) bodyData['foto_url'] = fotoUrl;
    if (password != null) bodyData['password'] = password;

    final ffApiRequestBody = jsonEncode(bodyData);

    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Update User',
      apiUrl: '${_pythonApiBaseUrl}/users/${userId}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));

  static int? userId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.user_id''',
      ));

  static List? updatedFields(dynamic response) => getJsonField(
        response,
        r'''$.updated_fields''',
        true,
      ) as List?;
}

/// DELETE /users/{id} - Eliminar cuenta de usuario
class FastAPIDeleteUserCall {
  static Future<ApiCallResponse> call({
    required int userId,
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Delete User',
      apiUrl: '${_pythonApiBaseUrl}/users/${userId}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));

  static int? userId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.user_id''',
      ));
}

/// POST /users/upload-profile-photo - Upload profile photo
class FastAPIUploadProfilePhotoCall {
  static Future<ApiCallResponse> call({
    String? authToken = '',
    FFUploadedFile? photo,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Upload Profile Photo',
      apiUrl: '${_pythonApiBaseUrl}/users/upload-profile-photo',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {
        'file': photo,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  static String? fotoUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.foto_url''',
      ));

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

/// POST /experiencias/{experiencia_id}/upload-photo - Upload photo to experiencia
class FastAPIUploadExperienciaPhotoCall {
  static Future<ApiCallResponse> call({
    String? authToken = '',
    required int experienciaId,
    FFUploadedFile? photo,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Upload Experiencia Photo',
      apiUrl: '${_pythonApiBaseUrl}/experiencias/$experienciaId/upload-photo',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {
        'file': photo,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  static String? fotoUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.foto_url''',
      ));

  static int? totalFotos(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.total_fotos''',
      ));

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

/// DELETE /experiencias/{experiencia_id}/delete-photo - Delete photo from experiencia
class FastAPIDeleteExperienciaPhotoCall {
  static Future<ApiCallResponse> call({
    String? authToken = '',
    required int experienciaId,
    required String fotoUrl,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Delete Experiencia Photo',
      apiUrl: '${_pythonApiBaseUrl}/experiencias/$experienciaId/delete-photo?foto_url=$fotoUrl',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  static int? totalFotos(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.total_fotos''',
      ));

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

/// DELETE /users/delete-profile-photo - Delete profile photo
class FastAPIDeleteProfilePhotoCall {
  static Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Delete Profile Photo',
      apiUrl: '${_pythonApiBaseUrl}/users/delete-profile-photo',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

/// POST /auth/refresh - Renovar access token
class FastAPIRefreshTokenCall {
  static Future<ApiCallResponse> call({
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "refresh_token": "$refreshToken"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Refresh Token',
      apiUrl: '${AppConfig.apiBaseUrl}/api/v1/auth/refresh',
      callType: ApiCallType.POST,
      headers: _apiHeaders,
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? accessToken(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.access_token''',
      ));

  static String? refreshToken(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.refresh_token''',
      ));

  static bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}

/// POST /auth/logout - Cerrar sesión revocando refresh token
class FastAPILogoutCall {
  static Future<ApiCallResponse> call({
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "refresh_token": "$refreshToken"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Logout',
      apiUrl: '${AppConfig.apiBaseUrl}/api/v1/auth/logout',
      callType: ApiCallType.POST,
      headers: _apiHeaders,
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

/// GET /planes/{plan_id} - Obtener detalle de un plan
class FastAPIPlanDetailCall {
  static Future<ApiCallResponse> call({
    required int planId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Plan Detail',
      apiUrl: '${_pythonApiBaseUrl}/planes/$planId',
      callType: ApiCallType.GET,
      headers: _apiHeaders,
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? planId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.plan_id''',
      ));

  static String? planTitle(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.plan_title''',
      ));

  static String? planImage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.plan_image''',
      ));

  static String? planPrice(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.plan_price''',
      ));

  static String? descripcion(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.descripcion''',
      ));

  static double? precio(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.precio''',
      ));

  static String? categoria(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.categoria''',
      ));

  static int? duracionDias(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.duracion_dias''',
      ));

  static String? destino(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.destino''',
      ));
}

/// POST /payments/create-checkout - Crear checkout de pago
class FastAPICreateCheckoutCall {
  static Future<ApiCallResponse> call({
    String? authToken = '',
    required String itemId,
    required String itemTitle,
    String? itemDescription = '',
    int? itemQuantity = 1,
    required double itemUnitPrice,
    String? currencyId = 'COP',
    String? tipoCompra = 'plan',
    int? idproducto,
  }) async {
    final ffApiRequestBody = '''
{
  "items": [
    {
      "id": "$itemId",
      "title": "$itemTitle",
      "description": "$itemDescription",
      "quantity": $itemQuantity,
      "unit_price": $itemUnitPrice,
      "currency_id": "$currencyId"
    }
  ],
  "tipo_compra": "$tipoCompra",
  "idproducto": $idproducto,
  "metadata": {}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Create Checkout',
      apiUrl: '${_pythonApiBaseUrl}/payments/create-checkout',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  static String? preferenceId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.preference_id''',
      ));

  static String? initPoint(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.init_point''',
      ));

  static String? sandboxInitPoint(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.sandbox_init_point''',
      ));

  static int? compraId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.compra_id''',
      ));

  static String? externalReference(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.external_reference''',
      ));
}

/// GET /payments/purchases/{purchase_id} - Obtener estado de una compra
class FastAPIGetPurchaseCall {
  static Future<ApiCallResponse> call({
    String? authToken = '',
    required int purchaseId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'FastAPI Get Purchase',
      apiUrl: '${_pythonApiBaseUrl}/payments/purchases/$purchaseId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  static String? estado(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.purchase.estado''',
      ));

  static String? titulo(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.purchase.titulo''',
      ));

  static double? precioTotal(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.purchase.precio_total''',
      ));

  static String? fechaPago(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.purchase.fecha_pago''',
      ));
}
