import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/cart_page/cart_page_widget.dart';
import '/models/cart_item.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PlanDetailPageWidget extends StatefulWidget {
  const PlanDetailPageWidget({
    super.key,
    required this.plan,
    required this.heroTag,
  });

  static String routeName = 'plan_detail_page';
  static String routePath = '/planDetail';

  final dynamic plan;
  final String heroTag;

  @override
  State<PlanDetailPageWidget> createState() => _PlanDetailPageWidgetState();
}

class _PlanDetailPageWidgetState extends State<PlanDetailPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _pageController;
  int _currentPage = 0;
  List<String>? _loadedImages;
  bool _isLoadingImages = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadPlanImagesIfNeeded();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadPlanImagesIfNeeded() async {
    final planId = getJsonField(widget.plan, r'''$.plan_id''');
    if (planId == null) return;

    setState(() {
      _isLoadingImages = true;
    });

    try {
      final response = await FastAPIPlanesCall.call(skip: 0, limit: 100);
      if (response.succeeded && response.jsonBody != null) {
        final items = getJsonField(response.jsonBody, r'''$.items''');
        if (items is List) {
          for (var item in items) {
            final itemId = getJsonField(item, r'''$.plan_id''');
            if (itemId == planId) {
              final imagesRaw = getJsonField(item, r'''$.plan_images''');
              if (imagesRaw is List) {
                final images = <String>[];
                for (var img in imagesRaw) {
                  if (img != null && img.toString().isNotEmpty) {
                    images.add(img.toString());
                  }
                }
                setState(() {
                  _loadedImages = images;
                  _isLoadingImages = false;
                });
                return;
              }
            }
          }
        }
      }
    } catch (e) {
      print('Error loading plan images: $e');
    }

    setState(() {
      _isLoadingImages = false;
    });
  }

  double _parsePrice(dynamic precioNumero, String? planPriceStr) {
    final planPrice = (planPriceStr ?? '').trim();
    final source = planPrice.isNotEmpty
        ? planPrice
        : (precioNumero?.toString() ?? '');
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
    return double.tryParse(normalized) ?? 0.0;
  }

  double _parseRating(String value) {
    try {
      return double.parse(value);
    } catch (_) {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    final title =
        getJsonField(widget.plan, r'''$.plan_title''')?.toString() ?? '';
    final imageUrl =
        getJsonField(widget.plan, r'''$.plan_image''')?.toString() ?? '';

    // Obtener array de imágenes
    // Prioridad: 1) _loadedImages del API, 2) plan_images del objeto, 3) plan_image
    List<String> planImages = [];

    if (_loadedImages != null && _loadedImages!.isNotEmpty) {
      planImages = _loadedImages!;
    } else {
      final planImagesRaw = getJsonField(widget.plan, r'''$.plan_images''');
      if (planImagesRaw is List) {
        for (var img in planImagesRaw) {
          if (img != null && img.toString().isNotEmpty) {
            planImages.add(img.toString());
          }
        }
      }
      // Si no hay imágenes en plan_images, usar plan_image
      if (planImages.isEmpty && imageUrl.isNotEmpty) {
        planImages.add(imageUrl);
      }
    }

    final description =
        getJsonField(widget.plan, r'''$.descripcion''')?.toString() ?? '';
    final planPriceStr =
        getJsonField(widget.plan, r'''$.plan_price''')?.toString();
    final precioNumero = getJsonField(widget.plan, r'''$.precio''');
    final isActive = getJsonField(widget.plan, r'''$.is_active''') == true;
    final planId = getJsonField(widget.plan, r'''$.plan_id''');
    final planIdStr = planId != null ? planId.toString() : title;
    final priceValue = _parsePrice(precioNumero, planPriceStr);
    // Nuevo: rating
    final ratingRaw = getJsonField(widget.plan, r'''$.plan_rating''');
    final rating = _parseRating((ratingRaw ?? '0').toString());

    // Nuevo: medidas para banner 4/4
    final bannerWidth = MediaQuery.of(context).size.width - 32.0;
    final bannerAspect = 4 / 4;
    final bannerHeight = bannerWidth / bannerAspect;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      // Nuevo: botón fijo al fondo
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: FFButtonWidget(
            onPressed: () {
              context.read<FFAppState>().addToCart(
                CartItem(
                  id: planIdStr,
                  name: title,
                  price: priceValue > 0 ? priceValue : 0.0,
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
            },
            text: 'Agregar al carrito',
            iconData: Icons.shopping_cart_outlined,
            options: FFButtonOptions(
              height: 52.0,
              width: double.infinity,
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 6.0, 0.0),
              color: FlutterFlowTheme.of(context).primaryDark,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                font: GoogleFonts.fredoka(),
                color: Colors.white,
                letterSpacing: 0.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/20852675_6345959_1_(2).png'),
            fit: BoxFit.cover,
          ),
        ),
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            MainSliverAppBar(
              title: 'Detalle del plan',
              leadingIcon: Icons.chevron_left_outlined,
              onLeadingTap: () => context.safePop(),
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nuevo: Hero con overlay y chip de estado + CARRUSEL DE 3 IMÁGENES
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Hero(
                      tag: widget.heroTag,
                      child: SizedBox(
                        width: bannerWidth,
                        height: bannerHeight,
                        child: Stack(
                          children: [
                            // PageView para carrusel de imágenes
                            PageView.builder(
                              controller: _pageController,
                              itemCount: planImages.length,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                return AspectRatio(
                                  aspectRatio: bannerAspect,
                                  child: planImages[index].isNotEmpty
                                      ? OptimizedImageWidget(
                                          imageUrl: planImages[index],
                                          width: bannerWidth,
                                          height: bannerHeight,
                                          fit: BoxFit.cover,
                                          borderRadius: 0.0,
                                        )
                                      : Container(
                                          width: bannerWidth,
                                          height: bannerHeight,
                                          color: FlutterFlowTheme.of(context).alternate,
                                        ),
                                );
                              },
                            ),
                            // Overlay degradado inferior
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.35),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Chip de estado
                            Positioned(
                              top: 12.0,
                              left: 12.0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                  color: (isActive ? Colors.green : Colors.red).withOpacity(0.85),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  isActive ? 'Activo' : 'Inactivo',
                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                    font: GoogleFonts.fredoka(),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ),
                            ),
                            // Indicadores de página (puntos clickeables) - solo si hay más de 1 imagen
                            if (planImages.length > 1)
                              Positioned(
                                bottom: 12.0,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    planImages.length,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        _pageController.animateToPage(
                                          index,
                                          duration: const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                        width: _currentPage == index ? 12.0 : 8.0,
                                        height: _currentPage == index ? 12.0 : 8.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _currentPage == index
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.5),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(0.8),
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Encabezado con título y rating
                  Text(
                    title,
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                      font: GoogleFonts.fredoka(fontWeight: FontWeight.w600),
                      color: Colors.black,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6.0),
                        child: Text(
                          ratingRaw?.toString() ?? '0',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.fredoka(),
                            color: Colors.black,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ),
                      RatingBarIndicator(
                        itemBuilder: (context, index) => Icon(
                          Icons.star_rounded,
                          color: FlutterFlowTheme.of(context).warning,
                        ),
                        direction: Axis.horizontal,
                        rating: rating,
                        unratedColor: Colors.black12,
                        itemCount: 5,
                        itemSize: 16.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  // “Pill” de precio
                  Row(
                    children: [
                      Text(
                        'Precio:',
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.fredoka(),
                          color: Colors.black,
                          letterSpacing: 0.0,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: FlutterFlowTheme.of(context).primary),
                        ),
                        child: Text(
                          priceValue > 0 ? priceValue.toStringAsFixed(2) : (planPriceStr ?? ''),
                          style: FlutterFlowTheme.of(context).titleSmall.override(
                            font: GoogleFonts.fredoka(),
                            color: FlutterFlowTheme.of(context).primary,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  // Descripción en tarjeta
                  if (description.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        description,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.fredoka(),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          lineHeight: 1.5,
                        ),
                      ),
                    ),
                  const SizedBox(height: 12.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
