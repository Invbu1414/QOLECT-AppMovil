import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'restablece_page_widget.dart' show RestablecePageWidget;
import 'package:flutter/material.dart';

class RestablecePageModel extends FlutterFlowModel<RestablecePageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (Wordpress reset password)] action in Button widget.
  ApiCallResponse? apiResultwtb;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
