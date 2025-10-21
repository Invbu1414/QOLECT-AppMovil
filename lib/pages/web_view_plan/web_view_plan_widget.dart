import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/components/whatsapp_fab/whatsapp_fab_widget.dart';
import '/components/app_bar/main_sliver_app_bar.dart';
import '/pages/cart_page/cart_page_widget.dart';
import '/models/cart_item.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'web_view_plan_model.dart';
export 'web_view_plan_model.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/optimized_image/optimized_image_widget.dart';

class WebViewPlanWidget extends StatefulWidget {
  const WebViewPlanWidget({
    super.key,
    required this.url,
    // Nuevo: planId para consultar el servicio
    this.planId,
  });

  final String? url;
  final int? planId;

  static String routeName = 'webViewPlan';
  static String routePath = '/webviewplan';

  @override
  State<WebViewPlanWidget> createState() => _WebViewPlanWidgetState();
}

class _WebViewPlanWidgetState extends State<WebViewPlanWidget> {
  late WebViewPlanModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;
  String? _error;
  dynamic _plan;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WebViewPlanModel());
    _fetchPlan();
  }

  Future<void> _fetchPlan() async {
    final id = widget.planId;
    if (id == null) {
      setState(() {
        _isLoading = false;
        _error = 'Falta el planId para consultar el detalle.';
      });
      return;
    }

    final resp = await WordpressPlanDetailCall.call(id: id);
    if (!mounted) return;

    if (resp.succeeded) {
      final body = resp.jsonBody;
      final item = body is List ? body.firstOrNull : body;
      setState(() {
        _plan = item;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        _error = 'No fue posible cargar el plan (HTTP ${resp.statusCode}).';
      });
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

    final String rawTitle =
        getJsonField(_plan, r'''$.plan_title''')?.toString() ?? '';
    final String title =
        rawTitle.isNotEmpty ? rawTitle : 'Plan de Cobertura Básica';

    final String imageUrl =
        getJsonField(_plan, r'''$.plan_image''')?.toString() ?? '';

    final String rawPrice =
        getJsonField(_plan, r'''$.plan_price''')?.toString() ?? '';
    final String price =
        rawPrice.isNotEmpty ? rawPrice : 'Desde \$49.900 COP';

    final String rawDescription =
        getJsonField(_plan, r'''$.plan_description''')?.toString() ?? '';
    final String description = rawDescription.isNotEmpty
        ? rawDescription
        : 'Incluye asistencia 24/7, cobertura médica básica y soporte en línea.';

    final String purchaseUrl =
        getJsonField(_plan, r'''$.plan_url''')?.toString() ?? '';

    final bool isFallback =
        rawTitle.isEmpty && rawDescription.isEmpty && rawPrice.isEmpty;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        // Quitamos cualquier wrapper de WebView y dejamos el FAB normal
        floatingActionButton: WhatsappFabWidget(),
        body: NestedScrollView(
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
          body: Builder(
            builder: (context) {
              return Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: Container(
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
                  child: Stack(
                    children: [
                      // Removido: FlutterFlowWebView. Mostramos la ficha del plan con datos del servicio.
                      SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Título al principio de la pantalla
                            Text(
                              title,
                              style: FlutterFlowTheme.of(context).headlineMedium.override(
                                    font: GoogleFonts.fredoka(
                                      fontWeight:
                                          FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                                      fontStyle:
                                          FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                    ),
                                    color: Colors.black,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    lineHeight: 1.2,
                                  ),
                              ),
                              const SizedBox(height: 16.0),

                              // Imagen principal con fallback local
                              if (imageUrl.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    imageUrl,
                                    width: double.infinity,
                                    height: 240.0,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              else
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: OptimizedImageWidget(
                                    imageUrl: imageUrl.isNotEmpty ? imageUrl : 'assets/images/new_logo.png',
                                    width: double.infinity,
                                    height: 240.0,
                                    fit: imageUrl.isNotEmpty ? BoxFit.cover : BoxFit.contain,
                                    borderRadius: 20.0,
                                  ),
                                ),
                              const SizedBox(height: 16.0),

                              // Descripción
                              Text(
                                description,
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.fredoka(
                                        fontWeight:
                                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                        fontStyle:
                                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.5,
                                    ),
                              ),

                              // Fichas de características cuando usamos datos por defecto
                              if (isFallback) ...[
                                const SizedBox(height: 12.0),
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 8.0,
                                  children: const [
                                    Chip(
                                      avatar: Icon(Icons.support_agent, size: 18),
                                      label: Text('Atención 24/7'),
                                    ),
                                    Chip(
                                      avatar: Icon(Icons.health_and_safety_outlined, size: 18),
                                      label: Text('Cobertura básica'),
                                    ),
                                    Chip(
                                      avatar: Icon(Icons.headset_mic_outlined, size: 18),
                                      label: Text('Soporte en línea'),
                                    ),
                                  ],
                                ),
                              ],

                              // Precio
                              const SizedBox(height: 12.0),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 4.0),
                                    Text(
                                      price,
                                      style: FlutterFlowTheme.of(context).titleSmall.override(
                                            font: GoogleFonts.fredoka(
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                            ),
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24.0),

                              // Botón "Realizar compra" con icono
                              FFButtonWidget(
                                onPressed: () async {
                                  if (purchaseUrl.isNotEmpty) {
                                    await actions.launchInBrowser(purchaseUrl);
                                  } else {
                                    // ID del plan: usa planId del widget o el id del objeto, fallback al título
                                    final planIdStr = widget.planId?.toString() ??
                                        getJsonField(_plan, r'''$.id''')?.toString() ??
                                        title;
                                    
                                    // Normalizar y parsear el precio (soporta ',' y '.')
                                    final source = rawPrice.trim().isNotEmpty ? rawPrice : price;
                                    final cleaned = source.replaceAll(RegExp(r'[^0-9.,-]'), '');
                                    String normalized = cleaned;
                                    if (cleaned.contains('.') && cleaned.contains(',')) {
                                      normalized = cleaned.replaceAll('.', '').replaceAll(',', '.');
                                    } else if (cleaned.contains(',')) {
                                      normalized = cleaned.replaceAll(',', '.');
                                    } else if (cleaned.contains('.')) {
                                      final hasDecimal = RegExp(r'\.\d{1,2}$').hasMatch(cleaned);
                                      normalized = hasDecimal ? cleaned : cleaned.replaceAll('.', '');
                                    }
                                    final priceValue = double.tryParse(normalized) ?? 0.0;
                                    
                                    context.read<FFAppState>().addToCart(
                                      CartItem(
                                        id: planIdStr,
                                        name: title,
                                        price: priceValue,
                                        quantity: 1,
                                        imageUrl: imageUrl.isNotEmpty ? imageUrl : null,
                                      ),
                                    );
                                    
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '$title ha sido agregado al carrito.',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            font: GoogleFonts.fredoka(),
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                        ),
                                        backgroundColor: FlutterFlowTheme.of(context).primary,
                                      ),
                                    );
                                  }
                                },
                                text: 'Agregar al carrito',
                                iconData: Icons.shopping_cart_outlined,
                                options: FFButtonOptions(
                                  height: 48.0,
                                  width: double.infinity,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 6.0, 0.0),
                                  iconSize: 20.0,
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle:
                                      FlutterFlowTheme.of(context).titleSmall.override(
                                            font: GoogleFonts.fredoka(
                                              fontWeight: FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                              fontStyle: FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                            ),
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                  elevation: 3.0,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (_isLoading)
                        Positioned.fill(
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        ),
                    ],
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
