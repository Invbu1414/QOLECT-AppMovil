import '/backend/api_requests/api_calls.dart';
import '/components/loading/loading_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:flutter/material.dart';

class LoginPageModel extends FlutterFlowModel<LoginPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? textController2Validator;
  // Stores action output result for [Backend Call - API (WordPress Login)] action in Button widget.
  ApiCallResponse? apiLoginResult;
  // Stores action output result for [Backend Call - API (WordPress Login)] action in ImageGoogleDeprecated widget.
  ApiCallResponse? apiLoginGResponse;
  // Stores action output result for [Backend Call - API (WordPress User)] action in ImageGoogleDeprecated widget.
  ApiCallResponse? getUserVerfied;
  // Stores action output result for [Backend Call - API (WordPress Login)] action in ImageGoogleDeprecated widget.
  ApiCallResponse? loginDemoGVerified;
  // Stores action output result for [Backend Call - API (WordPress Login)] action in ImageGoogleDeprecated widget.
  ApiCallResponse? loginDemoG;
  // Stores action output result for [Backend Call - API (WordPRess Register User)] action in ImageGoogleDeprecated widget.
  ApiCallResponse? registerUserGoogle;
  // Stores action output result for [Backend Call - API (WordPress Login)] action in ImageGoogle widget.
  ApiCallResponse? apiResultLoginWordPress;
  // Stores action output result for [Backend Call - API (WordPress Login)] action in ImageGoogle widget.
  ApiCallResponse? resultApiLoginAdmin;
  // Stores action output result for [Backend Call - API (WordPRess Register User)] action in ImageGoogle widget.
  ApiCallResponse? apiResultRegisterWordPress;
  // Stores action output result for [Backend Call - API (WordPress Login)] action in ImageGoogle widget.
  ApiCallResponse? apiResultLoginAfterRegister;
  // Stores action output result for [Backend Call - API (WordPress Login)] action in Image widget.
  ApiCallResponse? apiLoginAppleResponse;
  // Stores action output result for [Backend Call - API (WordPress User)] action in Image widget.
  ApiCallResponse? getUserVerfiedApple;
  // Stores action output result for [Backend Call - API (WordPress Login)] action in Image widget.
  ApiCallResponse? loginDemoAVerified;
  // Stores action output result for [Backend Call - API (WordPress Login)] action in Image widget.
  ApiCallResponse? loginDemoApple;
  // Stores action output result for [Backend Call - API (WordPRess Register User)] action in Image widget.
  ApiCallResponse? registerUserApple;
  // Stores action output result for [Backend Call - API (WordPress Login)] action in Button widget.
  ApiCallResponse? loginDemo;
  // Model for Loading component.
  late LoadingModel loadingModel;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
    loadingModel = createModel(context, () => LoadingModel());
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    loadingModel.dispose();
  }
}
