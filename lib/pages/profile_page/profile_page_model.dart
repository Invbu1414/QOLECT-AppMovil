import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfilePageModel extends FlutterFlowModel<ProfilePageWidget> {
  ///  Local state fields for this page.

  String? foto = '';

  String? celular = '';

  String? nombre = '';

  FFUploadedFile? fotoAsset;

  bool assetUploadState = false;

  int? assetId;

  String? fotoidX = 'x';

  String? contrasenaX = 'x';

  String? celularX = 'x';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (WordPress User)] action in profile_page widget.
  ApiCallResponse? apiResultUser;
  bool isDataUploading_uploadData1 = false;
  FFUploadedFile uploadedLocalFile_uploadData1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (UploadMedia)] action in Image widget.
  ApiCallResponse? uploadResult;
  bool isDataUploading_uploadData2 = false;
  FFUploadedFile uploadedLocalFile_uploadData2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (UploadMedia)] action in Image widget.
  ApiCallResponse? uploadResult2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  late MaskTextInputFormatter textFieldMask2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  late bool passwordVisibility1;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  late bool passwordVisibility2;
  String? Function(BuildContext, String?)? textController4Validator;
  // Stores action output result for [Backend Call - API (WordPress Profile)] action in Button widget.
  ApiCallResponse? apiResultnsiw;
  // Stores action output result for [Backend Call - API (WordPress Profile)] action in Button widget.
  ApiCallResponse? apiResultnsi;
  // Stores action output result for [Backend Call - API (WordPress delete user)] action in Button widget.
  ApiCallResponse? apiResultg4m;

  @override
  void initState(BuildContext context) {
    passwordVisibility1 = false;
    passwordVisibility2 = false;
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();
  }
}
