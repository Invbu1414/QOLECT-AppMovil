import '/backend/api_requests/api_calls.dart';
import '/components/noresults/noresults_widget.dart';
import '/components/home_drawer/home_drawer_widget.dart';
import '/components/viajes_list/viaje_item.dart';
import '/components/planes_list/plan_item.dart';
import '/components/whatsapp_fab/whatsapp_fab_widget.dart';
import '/components/app_bar/main_sliver_app_bar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'dart:async';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
import '/pages/cart_page/cart_page_widget.dart';
export 'home_page_model.dart';
import 'dart:ui';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'home_page';
  static String routePath = '/home';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // Optimizar carga inicial
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.after = '2000-09-06';

      // Cargar datos de forma asíncrona sin bloquear la UI
      _loadInitialData();
    });
  }

  Future<void> _loadInitialData() async {
    try {
      final notificationsResponse = await WordpressNotificacionesCall.call(
        author: FFAppState().userSessionID.toString(),
      );

      if (notificationsResponse.succeeded) {
        FFAppState().notificationsAmount =
            WordpressNotificacionesCall.id(notificationsResponse.jsonBody ?? '')
                    ?.length ??
                0;
      } else {
        FFAppState().notificationsAmount = 0;
      }

      if (mounted) setState(() {});
    } catch (e) {
      print('Error loading initial data: $e');
      FFAppState().notificationsAmount = 0;
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,

      //Boton WhatsApp
      floatingActionButton: WhatsappFabWidget(),

      //Menu lateral
      drawer: HomeDrawerWidget(),

      //AppBar
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, _) => [
          MainSliverAppBar(
            title: 'EXPERIENCIAS',
            onMenuTap: () => scaffoldKey.currentState!.openDrawer(),
            onCartTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const CartPageWidget(),
                ),
              );
            },
            notificationsCount: FFAppState().notificationsAmount,
            cartCount: FFAppState().cartItems.length,
          ),
        ],
        body: Builder(
          builder: (context) {
            return Container(
              width: 439.0,
              height: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/20852675_6345959_1_(2).png',
                  ).image,
                ),
                shape: BoxShape.rectangle,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    // Botones de planes y colecciones
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FFButtonWidget(
                            showLoadingIndicator: false,
                            onPressed: _model.plans
                                ? null
                                : () async {
                                    safeSetState(() =>
                                        _model.apiRequestCompleter1 = null);
                                    await _model.waitForApiRequestCompleted1();
                                    _model.plans = true;
                                    _model.collection = false;
                                    safeSetState(() {});
                                  },
                            text: 'Planes',
                            icon: FaIcon(
                              FontAwesomeIcons.earthAmericas,
                              size: 15.0,
                            ),
                            options: FFButtonOptions(
                              width: 130.0,
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 5.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconColor: _model.plans == true
                                  ? FlutterFlowTheme.of(context)
                                      .secondaryBackground
                                  : FlutterFlowTheme.of(context).primary,
                              color: _model.plans == true
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.fredoka(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: _model.plans == true
                                        ? FlutterFlowTheme.of(context)
                                            .secondaryBackground
                                        : FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          FFButtonWidget(
                            showLoadingIndicator: false,
                            onPressed: _model.collection
                                ? null
                                : () async {
                                    safeSetState(() =>
                                        _model.apiRequestCompleter2 = null);
                                    await _model.waitForApiRequestCompleted2();
                                    _model.collection = true;
                                    _model.plans = false;
                                    safeSetState(() {});
                                  },
                            text: 'Tu colección',
                            icon: Icon(
                              Icons.history,
                              size: 22.0,
                            ),
                            options: FFButtonOptions(
                              width: 140.0,
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 5.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconColor: _model.collection == true
                                  ? FlutterFlowTheme.of(context)
                                      .secondaryBackground
                                  : FlutterFlowTheme.of(context).primary,
                              color: _model.collection == true
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.fredoka(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: _model.collection == true
                                        ? FlutterFlowTheme.of(context)
                                            .secondaryBackground
                                        : FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Listas de viajes
                    if (_model.collection == true)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 20.0, 15.0, 20.0),
                        child: FutureBuilder<ApiCallResponse>(
                          future: _model.apiRequestCompleter1?.future ??
                              (_model.apiRequestCompleter1 =
                                      Completer<ApiCallResponse>()
                                        ..complete(WordpressViajesCall.call(
                                          author: FFAppState()
                                              .userSessionID
                                              .toString(),
                                          after: _model.after,
                                          before: _model.before,
                                        )))
                                  .future,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            final listViewCollectionWordpressViajesResponse =
                                snapshot.data!;

                            return Builder(
                              builder: (context) {
                                final viajesList =
                                    listViewCollectionWordpressViajesResponse
                                        .jsonBody
                                        .toList();
                                if (viajesList.isEmpty) {
                                  return Center(child: NoresultsWidget());
                                }

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: viajesList.length,
                                  itemBuilder: (context, index) {
                                    final viajesListItem = viajesList[index];
                                    return ViajeItem(
                                      viajesListItem: viajesListItem,
                                      index: index,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),

                    // Lista de planes
                    if (_model.plans == true)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 20.0, 15.0, 20.0),
                        child: FutureBuilder<ApiCallResponse>(
                          future: (_model.apiRequestCompleter2 ??=
                                  Completer<ApiCallResponse>()
                                    ..complete(WordpressPlanesCall.call()))
                              .future,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            final listViewPlansWordpressPlanesResponse =
                                snapshot.data!;
                            return Builder(
                              builder: (context) {
                                final plansList = getJsonField(
                                  listViewPlansWordpressPlanesResponse.jsonBody,
                                  r'''$''',
                                ).toList();

                                if (plansList.isEmpty) {
                                  return const Center(child: NoresultsWidget());
                                }

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: plansList.length,
                                  itemBuilder: (context, index) {
                                    final item = plansList[index];
                                    return PlanItem(plan: item);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      )
                  ]
                      .addToStart(SizedBox(height: 0.0))
                      .addToEnd(SizedBox(height: 50.0)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}