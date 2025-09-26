import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:async';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  String? before = '2100-09-06';

  String? after = '2000-09-06';

  bool collection = false;

  bool plans = true;

  int currentPage = 1;
  int itemsPerPage = 10;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  List<dynamic> allViajesList = [];

  List<dynamic> listCollections = [];
  void addToListCollections(dynamic item) => listCollections.add(item);
  void removeFromListCollections(dynamic item) => listCollections.remove(item);
  void removeAtIndexFromListCollections(int index) =>
      listCollections.removeAt(index);
  void insertAtIndexInListCollections(int index, dynamic item) =>
      listCollections.insert(index, item);
  void updateListCollectionsAtIndex(int index, Function(dynamic) updateFn) =>
      listCollections[index] = updateFn(listCollections[index]);

  List<dynamic> listPlans = [];
  void addToListPlans(dynamic item) => listPlans.add(item);
  void removeFromListPlans(dynamic item) => listPlans.remove(item);
  void removeAtIndexFromListPlans(int index) => listPlans.removeAt(index);
  void insertAtIndexInListPlans(int index, dynamic item) =>
      listPlans.insert(index, item);
  void updateListPlansAtIndex(int index, Function(dynamic) updateFn) =>
      listPlans[index] = updateFn(listPlans[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Wordpress Notificaciones)] action in home_page widget.
  ApiCallResponse? amountNotifications;
  Completer<ApiCallResponse>? apiRequestCompleter1;
  Completer<ApiCallResponse>? apiRequestCompleter2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  Future waitForApiRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter1?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future<void> loadMoreViajes() async {
    if (isLoadingMore || !hasMoreData) return;

    isLoadingMore = true;

    try {
      final response = await WordpressViajesCall.call(
        author: FFAppState().userSessionID.toString(),
        after: after,
        before: before,
        // Agregar parámetros de paginación si la API los soporta
      );

      if (response.succeeded) {
        final newItems = response.jsonBody as List<dynamic>;
        if (newItems.length < itemsPerPage) {
          hasMoreData = false;
        }
        allViajesList.addAll(newItems);
        currentPage++;
      }
    } catch (e) {
      print('Error loading more viajes: $e');
    } finally {
      isLoadingMore = false;
    }
  }
}
