import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'comunidadv1_widget.dart' show Comunidadv1Widget;
import 'package:flutter/material.dart';

class Comunidadv1Model extends FlutterFlowModel<Comunidadv1Widget> {
  ///  Local state fields for this page.

  String? before = '2100-09-06';

  String? after = '2000-09-06';

  bool collection = false;

  bool plans = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Wordpress Notificaciones)] action in comunidadv1 widget.
  ApiCallResponse? amountNotifications;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
