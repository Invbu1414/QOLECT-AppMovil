import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'rating_page_widget.dart' show RatingPageWidget;
import 'package:flutter/material.dart';

class RatingPageModel extends FlutterFlowModel<RatingPageWidget> {
  ///  Local state fields for this page.

  double rate = 0.0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for RatingBar widget.
  double? ratingBarValue;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (WordPress rate)] action in Button widget.
  ApiCallResponse? apiResults00;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
