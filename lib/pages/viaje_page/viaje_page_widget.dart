import '/components/noresults/noresults_widget.dart';
import '/components/whatsapp_fab/whatsapp_fab_widget.dart';
import '/components/app_bar/main_sliver_app_bar.dart';
import '/pages/cart_page/cart_page_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import '/components/optimized_image/optimized_image_widget.dart';
import '../../components/expandable_section/expandable_section.dart';
import '/components/bottom_sheet/viaje_bottom_bar.dart';
import 'viaje_page_model.dart';
export 'viaje_page_model.dart';

class ViajePageWidget extends StatefulWidget {
  const ViajePageWidget({
    super.key,
    required this.info,
  });

  final dynamic info;

  static String routeName = 'viaje_page';
  static String routePath = '/viaje';

  @override
  State<ViajePageWidget> createState() => _ViajePageWidgetState();
}

class _ViajePageWidgetState extends State<ViajePageWidget> {
  late ViajePageModel _model;
  late final ScrollController _scrollController;
  bool _bottomVisible = true;
  double _lastOffset = 0.0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViajePageModel());
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final offset = _scrollController.position.pixels;
      if (offset > _lastOffset + 2 && _bottomVisible) {
        setState(() => _bottomVisible = false);
      } else if (offset < _lastOffset - 2 && !_bottomVisible) {
        setState(() => _bottomVisible = true);
      }
      _lastOffset = offset;
    });

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
    _scrollController.dispose();

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
        extendBody: true,
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: NestedScrollView(
          controller: _scrollController,
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            MainSliverAppBar(
              title: '',
              titleWidget: Padding(
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
              leadingIcon: Icons.chevron_left_outlined,
              onLeadingTap: () async {
                context.safePop();
              },
              onMenuTap: () {},
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

          // Content
          body: Builder(
            builder: (context) {
              return Container(
                width: 439.0,
                height: double.infinity,

                //Background
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
                alignment: AlignmentDirectional(0.0, -1.0),

                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 0.0),
                        child: Container(
                          width: 400.0,
                          height: 300.0,
                          child: Stack(
                            children: [
                              // Principal image
                              if (false !=
                                  getJsonField(
                                    widget.info,
                                    r'''$.acf.imagen_para_card_copiar''',
                                  ))
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: OptimizedImageWidget(
                                      imageUrl: valueOrDefault<String>(
                                        getJsonField(
                                          widget.info,
                                          r'''$.acf.imagen_para_card_copiar''',
                                        )?.toString(),
                                        'https://app.qolect.co/wp-content/uploads/2023/09/8-1.png',
                                      ),
                                      width: 400.0,
                                      height: 300.0,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      // Banner 
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                        child: Card(
                          elevation: 3,
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.asset(
                                    'assets/images/Group_2181_(1).png',
                                    width: 110.0,
                                    height: 64.0,
                                    fit: BoxFit.cover,
                                    alignment: const Alignment(-1.0, -1.0),
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          getJsonField(widget.info, r'''$.title.rendered''')?.toString(),
                                          'Sin datos',
                                        ),
                                        style: FlutterFlowTheme.of(context).titleMedium.override(
                                              font: GoogleFonts.fredoka(
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                              ),
                                              color: Colors.black,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                            ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            RatingPageWidget.routeName,
                                            queryParameters: {
                                              'id': serializeParam(
                                                getJsonField(widget.info, r'''$.id'''),
                                                ParamType.int,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            RatingBarIndicator(
                                              itemBuilder: (context, index) => Icon(
                                                Icons.star_rounded,
                                                color: FlutterFlowTheme.of(context).warning,
                                              ),
                                              direction: Axis.horizontal,
                                              rating: valueOrDefault<double>(
                                                double.parse(
                                                  valueOrDefault<String>(
                                                    getJsonField(widget.info, r'''$.acf.calificacion''')?.toString(),
                                                    '0',
                                                  ),
                                                ),
                                                0.0,
                                              ),
                                              unratedColor: FlutterFlowTheme.of(context).secondaryText,
                                              itemCount: 5,
                                              itemSize: 22.0,
                                            ),
                                            const SizedBox(width: 8.0),
                                            Text(
                                              valueOrDefault<double>(
                                                double.parse(
                                                  valueOrDefault<String>(
                                                    getJsonField(widget.info, r'''$.acf.calificacion''')?.toString(),
                                                    '0',
                                                  ),
                                                ),
                                                0.0,
                                              ).toStringAsFixed(1),
                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                    font: GoogleFonts.fredoka(
                                                      fontWeight: FlutterFlowTheme.of(context)
                                                          .bodySmall
                                                          .fontWeight,
                                                      fontStyle: FlutterFlowTheme.of(context)
                                                          .bodySmall
                                                          .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).primary.withOpacity(0.08),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.location_on_rounded,
                                              size: 18.0,
                                              color: FlutterFlowTheme.of(context).primary,
                                            ),
                                            const SizedBox(width: 6.0),
                                            Text(
                                              valueOrDefault<String>(
                                                getJsonField(widget.info, r'''$.acf.destino''')?.toString(),
                                                'Sin datos',
                                              ),
                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                    font: GoogleFonts.fredoka(
                                                      fontWeight: FlutterFlowTheme.of(context)
                                                          .bodySmall
                                                          .fontWeight,
                                                      fontStyle: FlutterFlowTheme.of(context)
                                                          .bodySmall
                                                          .fontStyle,
                                                    ),
                                                    color: Colors.black,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Prepare your trip documents
                      if (false !=
                          getJsonField(
                            widget.info,
                            r'''$.acf.prepara_tu_viaje_documentos''',
                          ))
                        ExpandableSection(
                          info: widget.info,
                          expanded: _model.expandable1 == true,
                          onToggle: () {
                            _model.expandable1 = !_model.expandable1;
                            safeSetState(() {});
                          },
                          title: 'PREPARA TU VIAJE',
                          leadingIcon: Icons.shopping_bag,
                          listJsonPath: r'''$.acf.prepara_tu_viaje_documentos''',
                          itemTitleJsonPath: r'''$.nombre''',
                          itemUrlJsonPath: r'''$.pdf''',
                          itemAvailabilityJsonPath: r'''$.pdf''',
                        ),

                      // Prepare your trip documents
                      if (false !=
                          getJsonField(
                            widget.info,
                            r'''$.acf.en_destino_documentos''',
                          ))
                        ExpandableSection(
                          info: widget.info,
                          expanded: _model.expandable2,
                          onToggle: () {
                            _model.expandable2 = !_model.expandable2;
                            safeSetState(() {});
                          },
                          title: 'EN DESTINO',
                          leadingIcon: Icons.tsunami,
                          listJsonPath: r'''$.acf.en_destino_documentos''',
                          itemTitleJsonPath: r'''$.nombre''',
                          itemUrlJsonPath: r'''$.pdf''',
                          itemAvailabilityJsonPath: r'''$.pdf''',
                        ),

                      // Expandable Section "De regreso a casa"
                      if (false !=
                          getJsonField(
                            widget.info,
                            r'''$.acf.de_regreso_a_casa_documentos''',
                          ))
                        ExpandableSection(
                          info: widget.info,
                          expanded: _model.expandable3 == true,
                          onToggle: () {
                            _model.expandable3 = !_model.expandable3;
                            safeSetState(() {});
                          },
                          title: 'DE REGRESO A CASA',
                          leadingIcon: Icons.flight_outlined,
                          listJsonPath: r'''$.acf.de_regreso_a_casa_documentos''',
                          itemTitleJsonPath: r'''$.nombre''',
                          itemUrlJsonPath: r'''$.pdf''',
                          itemAvailabilityJsonPath: r'''$.pdf''',
                          // rowTrailingIcon: Icons.find_in_page_outlined, // opcional
                        ),
                        SizedBox(height: 140.0),
                    ]
                  ),
                ),
              );
            },
          ),
        ),

    
        // Bottom Sheet
        bottomSheet: ViajeBottomBar(
          visible: _bottomVisible,
          info: widget.info,
        ),
      ),
    );
  }
}
