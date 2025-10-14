import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/add_experience/add_experience_widget.dart';
import '/components/noresults/noresults_widget.dart';
import '/components/view_experience/view_experience_widget.dart';
import '/components/home_drawer/home_drawer_widget.dart';
import '/components/whatsapp_fab/whatsapp_fab_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'comunidad_model.dart';
export 'comunidad_model.dart';

class ComunidadWidget extends StatefulWidget {
  const ComunidadWidget({super.key});

  static String routeName = 'comunidad';
  static String routePath = '/comunidad';

  @override
  State<ComunidadWidget> createState() => _ComunidadWidgetState();
}

class _ComunidadWidgetState extends State<ComunidadWidget> {
  late ComunidadModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ComunidadModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: HomeDrawerWidget(),
        body: Stack(
          children: [
            NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              expandedHeight: 90.0,
              pinned: false,
              floating: true,
              snap: true,
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: false,
              leading: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  scaffoldKey.currentState!.openDrawer();
                },
                child: Icon(
                  Icons.menu,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  size: 30.0,
                ),
              ),
              title: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/LOGO_3.png',
                    width: 226.0,
                    height: 63.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              actions: [
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 25.0, 0.0),
                    child: badges.Badge(
                      badgeContent: Text(
                        valueOrDefault<String>(
                          FFAppState().notificationsAmount.toString(),
                          '0',
                        ),
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              font: GoogleFonts.fredoka(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                              color: Colors.white,
                              fontSize: 10.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                      ),
                      showBadge: true,
                      shape: badges.BadgeShape.circle,
                      badgeColor: FlutterFlowTheme.of(context).error,
                      elevation: 4.0,
                      padding: EdgeInsets.all(5.0),
                      position: badges.BadgePosition.topEnd(),
                      animationType: badges.BadgeAnimationType.scale,
                      toAnimate: false,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(NotificationsPageWidget.routeName);
                        },
                        child: Icon(
                          Icons.notifications,
                          color: FlutterFlowTheme.of(context).warning,
                          size: 35.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: true,
              toolbarHeight: 90.0,
              elevation: 2.0,
            )
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
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                        child: Container(
                          width: 200.0,
                          height: 34.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primary,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              'COMUNIDAD',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.fredoka(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    fontSize: 24.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 20.0, 15.0, 20.0),
                        child: FutureBuilder<ApiCallResponse>(
                          future: WordPressExperienciasComunidadCall.call(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
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
                            final listViewComunidadWordPressExperienciasComunidadResponse =
                                snapshot.data!;

                            return Builder(
                              builder: (context) {
                                final experiencia = getJsonField(
                                  listViewComunidadWordPressExperienciasComunidadResponse
                                      .jsonBody,
                                  r'''$''',
                                ).toList();
                                if (experiencia.isEmpty) {
                                  return Center(
                                    child: NoresultsWidget(),
                                  );
                                }

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: experiencia.length,
                                  itemBuilder: (context, experienciaIndex) {
                                    final experienciaItem =
                                        experiencia[experienciaIndex];

                                    String? _toUrl(dynamic v) {
                                      if (v == null) return null;
                                      final s = v.toString().trim();
                                      if (s.isEmpty ||
                                          s == 'false' ||
                                          s == 'null') return null;
                                      final uri = Uri.tryParse(s);
                                      if (uri == null) return null;
                                      return (uri.hasScheme &&
                                              (uri.scheme == 'http' ||
                                                  uri.scheme == 'https'))
                                          ? s
                                          : null;
                                    }

                                    bool _toBool(dynamic v) {
                                      if (v is bool) return v;
                                      if (v is num) return v != 0;
                                      if (v is String)
                                        return v.toLowerCase() == 'true' ||
                                            v == '1';
                                      return false;
                                    }

                                    final String? imageUrl =
                                        _toUrl(getJsonField(
                                      experienciaItem,
                                      r'''$.experience_image''',
                                    ));
                                    final String? videoUrl =
                                        _toUrl(getJsonField(
                                      experienciaItem,
                                      r'''$.experience_video''',
                                    ));
                                    final String? avatarUrl =
                                        _toUrl(getJsonField(
                                      experienciaItem,
                                      r'''$.user_image''',
                                    ));
                                    final bool hasVideo = _toBool(getJsonField(
                                      experienciaItem,
                                      r'''$.experience_has_video''',
                                    ));
                                    final String userName = getJsonField(
                                      experienciaItem,
                                      r'''$.user_name''',
                                    ).toString();
                                    final String comments = getJsonField(
                                      experienciaItem,
                                      r'''$.experience_comments''',
                                    ).toString();

                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return WebViewAware(
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child: ViewExperienceWidget(
                                                    hasVideo: hasVideo,
                                                    videoUrl: videoUrl ?? '',
                                                    imageUrl: imageUrl ?? '',
                                                    comments: comments,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 20.0, 20.0, 0.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 12.0,
                                                offset: Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(16.0),
                                                  topRight:
                                                      Radius.circular(16.0),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    AspectRatio(
                                                      aspectRatio: 4 / 4,
                                                      child: imageUrl != null
                                                          ? Image.network(
                                                              imageUrl,
                                                              width: double
                                                                  .infinity,
                                                              fit: BoxFit.cover,
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Container(
                                                                    width: double
                                                                        .infinity,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    child:
                                                                        Center(
                                                                          child: Image
                                                                              .network(
                                                                            'https://app.qolect.co/wp-content/uploads/2025/05/hermosa-chica-de-pie-en-el-barco-y-mirando-las-montanas-en-la-presa-ratchaprapha-en-el-parque-nacional-khao-sok-provincia-de-surat-thani-tailandia-scaled.jpg',
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                        )
                                                                    );
                                                              },
                                                            )
                                                          : Container(
                                                              width: double
                                                                  .infinity,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              child: Center(
                                                                child: Image
                                                                    .network(
                                                                  'https://app.qolect.co/wp-content/uploads/2025/05/hermosa-chica-de-pie-en-el-barco-y-mirando-las-montanas-en-la-presa-ratchaprapha-en-el-parque-nacional-khao-sok-provincia-de-surat-thani-tailandia-scaled.jpg',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                    if (hasVideo)
                                                      Positioned.fill(
                                                        child: Container(
                                                          color: Colors.black26,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .play_circle_outline,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              size: 56.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24.0),
                                                      child: avatarUrl != null
                                                          ? Image.network(
                                                              avatarUrl,
                                                              width: 40.0,
                                                              height: 40.0,
                                                              fit: BoxFit.cover,
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Container(
                                                                  width: 40.0,
                                                                  height: 40.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .person,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                );
                                                              },
                                                            )
                                                          : Container(
                                                              width: 40.0,
                                                              height: 40.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                              ),
                                                              child: Icon(
                                                                Icons.person,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                              ),
                                                            ),
                                                    ),
                                                    const SizedBox(width: 12.0),
                                                    Expanded(
                                                      child: Text(
                                                        userName,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .fredoka(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        16.0, 0.0, 16.0, 16.0),
                                                child: Text(
                                                  comments,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.fredoka(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ]
                        .addToStart(SizedBox(height: 0.0))
                        .addToEnd(SizedBox(height: 100.0)),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
              left: 0,
              right: 0,
              bottom: 0.0,
              child: SafeArea(
                minimum: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    elevation: 12.0,
                    borderRadius: BorderRadius.circular(20.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20.0),
                      onTap: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: true,
                          context: context,
                          builder: (context) {
                            return WebViewAware(
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: AddExperienceWidget(),
                                ),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: FlutterFlowTheme.of(context).warning,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 16.0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.upload_file,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                size: 26.0,
                              ),
                              const SizedBox(width: 12.0),
                              Text(
                                'Subir mi experiencia',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.fredoka(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
