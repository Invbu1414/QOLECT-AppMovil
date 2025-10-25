import '/backend/api_requests/api_calls.dart';
import '/components/noresults/noresults_widget.dart';
import '/components/home_drawer/home_drawer_widget.dart';
import '/components/whatsapp_fab/whatsapp_fab_widget.dart';
import '/components/app_bar/main_sliver_app_bar.dart';
import '/pages/cart_page/cart_page_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'notices_page_model.dart';
export 'notices_page_model.dart';

class NoticesPageWidget extends StatefulWidget {
  const NoticesPageWidget({super.key});

  static String routeName = 'notices_page';
  static String routePath = '/notices';

  @override
  State<NoticesPageWidget> createState() => _NoticesPageWidgetState();
}

class _NoticesPageWidgetState extends State<NoticesPageWidget> {
  late NoticesPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoticesPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.after = dateTimeFormat(
        "yyyy-MM-ddTkk:mm:ss",
        getCurrentTimestamp,
        locale: FFLocalizations.of(context).languageCode,
      );
      safeSetState(() {});
    });
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
        floatingActionButton: WhatsappFabWidget(),
        drawer: HomeDrawerWidget(),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            MainSliverAppBar(
              title: 'NOTICIAS',
              onMenuTap: () async {
                scaffoldKey.currentState!.openDrawer();
              },
              onCartTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartPageWidget()),
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
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 20.0, 15.0, 20.0),
                        child: FutureBuilder<ApiCallResponse>(
                          future: FastAPINoticiasCall.call(
                            skip: 0,
                            limit: 50,
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
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
                            final listViewFastAPINoticiasResponse =
                                snapshot.data!;

                            return Builder(
                              builder: (context) {
                                final noticias = getJsonField(
                                  listViewFastAPINoticiasResponse.jsonBody,
                                  r'''$.items''',
                                ).toList();

                                if (noticias.isEmpty) {
                                  return Center(
                                    child: NoresultsWidget(),
                                  );
                                }

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: noticias.length,
                                  itemBuilder: (context, noticiasIndex) {
                                    final noticiasItem = noticias[noticiasIndex];
                                    // Datos seguros con fallbacks - Adaptado para FastAPI
                                    final imageUrl = valueOrDefault<String>(
                                      getJsonField(noticiasItem, r'''$.imagen''')?.toString(),
                                      '',
                                    );
                                    final titleText = valueOrDefault<String>(
                                      getJsonField(noticiasItem, r'''$.titulo''')?.toString(),
                                      'Noticia',
                                    );
                                    final dateRaw = getJsonField(noticiasItem, r'''$.created_at''')?.toString();
                                    final dateFmt = (dateRaw != null && dateRaw.isNotEmpty)
                                        ? dateTimeFormat('yMMMd', DateTime.tryParse(dateRaw))
                                        : 'Fecha no disponible';
                                    final descriptionText = valueOrDefault<String>(
                                      getJsonField(noticiasItem, r'''$.descripcion''')?.toString(),
                                      'Sin contenido disponible.',
                                    );
                                    // Tag único y URL-safe para el Hero
                                    final heroTag = imageUrl.isNotEmpty
                                        ? 'notice_${noticiasIndex}_${imageUrl.hashCode}'
                                        : 'noticia_$noticiasIndex';
                                
                                    return Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 16.0, 10.0, 0.0),
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        elevation: 6,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            context.pushNamed(
                                              NoticeDetailPageWidget.routeName,
                                              queryParameters: {
                                                'title': serializeParam(titleText, ParamType.String),
                                                'imageUrl': serializeParam(imageUrl, ParamType.String),
                                                'date': serializeParam(dateRaw ?? '', ParamType.String),
                                                'description': serializeParam(descriptionText, ParamType.String),
                                                'heroTag': serializeParam(heroTag, ParamType.String),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              AspectRatio(
                                                aspectRatio: 4 / 4,
                                                child: Hero(
                                                  tag: heroTag,
                                                  transitionOnUserGestures: true,
                                                  child: imageUrl.isNotEmpty
                                                      ? Image.network(
                                                          imageUrl,
                                                          fit: BoxFit.cover,
                                                          loadingBuilder: (context, child, progress) {
                                                            if (progress == null) return child;
                                                            return Container(
                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                            );
                                                          },
                                                          errorBuilder: (context, error, stackTrace) {
                                                            return Image.asset(
                                                              'assets/images/new_logo.png',
                                                              fit: BoxFit.cover,
                                                            );
                                                          },
                                                        )
                                                      : Image.asset(
                                                          'assets/images/new_logo.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 16.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      titleText,
                                                      softWrap: true,
                                                      style: FlutterFlowTheme.of(context).titleLarge.override(
                                                            font: GoogleFonts.fredoka(
                                                              fontWeight: FontWeight.w700,
                                                              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                            ),
                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                            letterSpacing: 0.0,
                                                            fontWeight: FontWeight.w700,
                                                            fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                          ),
                                                    ),
                                                    const SizedBox(height: 8.0),
                                                    Text(
                                                      dateFmt,
                                                      style: FlutterFlowTheme.of(context).labelMedium.override(
                                                            font: GoogleFonts.fredoka(
                                                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                            ),
                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                            letterSpacing: 0.0,
                                                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                          ),
                                                    ),
                                                    const SizedBox(height: 12.0),
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: FFButtonWidget(
                                                        onPressed: () {
                                                          context.pushNamed(
                                                            NoticeDetailPageWidget.routeName,
                                                              queryParameters: {
                                                                'title': serializeParam(titleText, ParamType.String),
                                                                'imageUrl': serializeParam(imageUrl, ParamType.String),
                                                                'date': serializeParam(dateRaw ?? '', ParamType.String),
                                                                'description': serializeParam(descriptionText, ParamType.String),
                                                                'heroTag': serializeParam(heroTag, ParamType.String),
                                                              }.withoutNulls,
                                                            );
                                                        },
                                                        text: 'Ver más',
                                                        icon: const Icon(
                                                          Icons.arrow_forward_rounded,
                                                          size: 18.0,
                                                          color: Colors.white,
                                                        ),
                                                        options: FFButtonOptions(
                                                          height: 36.0,
                                                          padding: const EdgeInsetsDirectional.fromSTEB(14.0, 0.0, 16.0, 0.0),
                                                          color: FlutterFlowTheme.of(context).primary,
                                                          textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                                                                font: GoogleFonts.fredoka(
                                                                  fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                ),
                                                                color: Colors.white,
                                                              ),
                                                          elevation: 3.0,
                                                          borderRadius: BorderRadius.circular(12.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
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
                        .addToEnd(SizedBox(height: 50.0)),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
