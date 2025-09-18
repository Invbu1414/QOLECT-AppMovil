import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:async';
import 'notifications_page_widget.dart' show NotificationsPageWidget;
import 'package:flutter/material.dart';

class NotificationsPageModel extends FlutterFlowModel<NotificationsPageWidget> {
  ///  Local state fields for this page.

  String? notiAmount = '0';

  List<dynamic> notifObject = [];
  void addToNotifObject(dynamic item) => notifObject.add(item);
  void removeFromNotifObject(dynamic item) => notifObject.remove(item);
  void removeAtIndexFromNotifObject(int index) => notifObject.removeAt(index);
  void insertAtIndexInNotifObject(int index, dynamic item) =>
      notifObject.insert(index, item);
  void updateNotifObjectAtIndex(int index, Function(dynamic) updateFn) =>
      notifObject[index] = updateFn(notifObject[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Wordpress Notificaciones)] action in notifications_page widget.
  ApiCallResponse? startApiResult;
  Completer<ApiCallResponse>? apiRequestCompleter;
  // Stores action output result for [Backend Call - API (Wordpress Notificaciones)] action in ListView widget.
  ApiCallResponse? updateNotificationsApi;
  // Stores action output result for [Backend Call - API (WordPress Notifications update)] action in Icon widget.
  ApiCallResponse? apiResultnw0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
