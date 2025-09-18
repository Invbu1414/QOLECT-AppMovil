import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_experience_widget.dart' show AddExperienceWidget;
import 'package:flutter/material.dart';

class AddExperienceModel extends FlutterFlowModel<AddExperienceWidget> {
  ///  Local state fields for this component.

  FFUploadedFile? uploadFile;

  String? typeResource;

  int? idImage;

  int? idVideo;

  ///  State fields for stateful widgets in this component.

  bool isDataUploading_uploadDataJ1x = false;
  FFUploadedFile uploadedLocalFile_uploadDataJ1x =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for categoria widget.
  String? categoriaValue;
  FormFieldController<String>? categoriaValueController;
  // State field(s) for comentarios widget.
  FocusNode? comentariosFocusNode;
  TextEditingController? comentariosTextController;
  String? Function(BuildContext, String?)? comentariosTextControllerValidator;
  // Stores action output result for [Backend Call - API (UploadMedia)] action in Button widget.
  ApiCallResponse? apiResultUploadMedia;
  // Stores action output result for [Backend Call - API (WordPress guardar experiencia)] action in Button widget.
  ApiCallResponse? apiResultGuardarExperiencia;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    comentariosFocusNode?.dispose();
    comentariosTextController?.dispose();
  }
}
