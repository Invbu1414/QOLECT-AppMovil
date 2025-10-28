import '/backend/api_requests/api_calls.dart';
import '/components/home_drawer/home_drawer_widget.dart';
import '/components/whatsapp_fab/whatsapp_fab_widget.dart';
import '/pages/cart_page/cart_page_widget.dart';
import '/pages/mis_colecciones_page/mis_colecciones_page_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'home_page';
  static String routePath = '/home';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;
  dynamic _homeData;
  dynamic _viajesData;
  String? _errorMessage;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _loadHomeData();
    });
  }

  Future<void> _loadHomeData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // Cargar datos del home
      final response = await FastAPIHomeCall.call();

      // Cargar viajes del usuario (solo si está logueado)
      dynamic viajesResponse;
      if (FFAppState().userSessionID > 0) {
        viajesResponse = await FastAPIViajesCall.call(
          author: FFAppState().userSessionID.toString(),
          token: FFAppState().token,
        );
      }

      if (response.succeeded) {
        if (mounted) {
          setState(() {
            _homeData = response.jsonBody;
            _viajesData = viajesResponse?.jsonBody;
            _isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = 'Error al cargar datos del home';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error loading home data: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Error de conexion: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      floatingActionButton: WhatsappFabWidget(),
      drawer: HomeDrawerWidget(),
      appBar: MainSliverAppBar(
        asSliver: false,
        title: '',
        titleWidget: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/Logo.png',
              width: 226.0,
              height: 63.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
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
      body: _isLoading
          ? Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            )
          : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64.0,
                          color: FlutterFlowTheme.of(context).error,
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _loadHomeData,
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    // Barra de búsqueda
                    _buildSearchBar(),
                    // Contenido scrollable
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/20852675_6345959_1_(2).png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Banner Hero
                              if (_homeData != null && _homeData['banner'] != null)
                                _buildBanner(_homeData['banner']),

                              const SizedBox(height: 20.0),

                              // NUEVO: Ofertas Especiales
                              if (_homeData != null && _homeData['planes_populares'] != null)
                                _buildOfertasEspeciales(_homeData['planes_populares']),

                              // NUEVO: Categorías
                              _buildCategoriasRapidas(),

                              const SizedBox(height: 20.0),

                              // Mi Colección (solo si está logueado y tiene viajes)
                              if (FFAppState().userSessionID > 0 &&
                                  _viajesData != null &&
                                  _viajesData is List &&
                                  (_viajesData as List).isNotEmpty)
                                _buildMiColeccion(_viajesData as List),

                              if (FFAppState().userSessionID > 0 &&
                                  _viajesData != null &&
                                  _viajesData is List &&
                                  (_viajesData as List).isNotEmpty)
                                const SizedBox(height: 20.0),

                              // Planes Populares (mejorados)
                              if (_homeData != null && _homeData['planes_populares'] != null)
                                _buildPlanesPopulares(_homeData['planes_populares']),

                              const SizedBox(height: 20.0),

                              // Noticias Destacadas
                              if (_homeData != null && _homeData['noticias_destacadas'] != null)
                                _buildNoticiasDestacadas(_homeData['noticias_destacadas']),

                              const SizedBox(height: 50.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildBanner(dynamic banner) {
    final titulo = banner['titulo'] ?? '';
    final subtitulo = banner['subtitulo'] ?? '';
    final imagen = banner['imagen'] ?? '';

    return Container(
      width: double.infinity,
      height: 250.0,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          children: [
            // Imagen de fondo
            Image.network(
              imagen,
              width: double.infinity,
              height: 250.0,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: FlutterFlowTheme.of(context).primary,
                  child: const Center(
                    child: Icon(Icons.error, color: Colors.white, size: 48.0),
                  ),
                );
              },
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            // Texto
            Positioned(
              bottom: 20.0,
              left: 20.0,
              right: 20.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          font: GoogleFonts.fredoka(
                            fontWeight: FontWeight.bold,
                          ),
                          color: Colors.white,
                          fontSize: 28.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    subtitulo,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.fredoka(),
                          color: Colors.white,
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoticiasDestacadas(List noticias) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'NOTICIAS DESTACADAS',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      font: GoogleFonts.fredoka(fontWeight: FontWeight.bold),
                      color: FlutterFlowTheme.of(context).primary,
                      letterSpacing: 0.0,
                    ),
                ),
                FFButtonWidget(
                  onPressed: () {
                    context.pushNamed(NoticesPageWidget.routeName);
                  },
                  text: 'Ver todas >',
                  options: FFButtonOptions(
                  height: 36.0,
                  padding: EdgeInsets.zero,
                  color: Colors.transparent,
                  textStyle: FlutterFlowTheme.of(context).labelLarge
                      .override(
                          font: GoogleFonts.fredoka(
                          fontWeight:
                              FlutterFlowTheme.of(context).labelLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).labelLarge.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primary,
                      )
                      .merge(const TextStyle(
                        decoration: TextDecoration.underline,
                      )),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ]
          )
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: noticias.length,
            itemBuilder: (context, index) {
              final noticia = noticias[index];
              return _buildNoticiaCard(noticia, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNoticiaCard(dynamic noticia, int index) {
    final titulo = noticia['titulo'] ?? '';
    final imagen = noticia['imagen'] ?? '';
    final fecha = noticia['created_at'] ?? '';
    final descripcion = noticia['descripcion'] ?? '';
    final heroTag = imagen.isNotEmpty
        ? 'notice_${index}_${imagen.hashCode}'
        : 'noticia_$index';
  
    return InkWell(
      onTap: () {
        context.pushNamed(
          NoticeDetailPageWidget.routeName,
          queryParameters: {
            'title': serializeParam(titulo, ParamType.String),
            'imageUrl': serializeParam(imagen, ParamType.String),
            'date': serializeParam(fecha, ParamType.String),
            'description': serializeParam(descripcion, ParamType.String),
            'heroTag': serializeParam(heroTag, ParamType.String),
          }.withoutNulls,
        );
      },
      child: Container(
        width: 280.0,
        margin: const EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Hero(
                tag: heroTag,
                transitionOnUserGestures: true,
                child: imagen.isNotEmpty
                    ? Image.network(
                        imagen,
                        width: double.infinity,
                        height: 120.0,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 120.0,
                            color: FlutterFlowTheme.of(context).alternate,
                            child: const Center(
                              child: Icon(Icons.image_not_supported, size: 48.0),
                            ),
                          );
                        },
                      )
                    : Container(
                        height: 120.0,
                        color: FlutterFlowTheme.of(context).alternate,
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 48.0),
                        ),
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.fredoka(fontWeight: FontWeight.w600),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                    const Spacer(),
                    Text(
                      fecha.split('T').first,
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            font: GoogleFonts.fredoka(),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildPlanesPopulares(List planes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PLANES POPULARES',
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    font: GoogleFonts.fredoka(fontWeight: FontWeight.bold),
                    color: FlutterFlowTheme.of(context).primary,
                    letterSpacing: 0.0,
                  ),
            ),
            FFButtonWidget(
                  onPressed: () {
                    context.pushNamed(PlansPageWidget.routeName);
                  },
                  text: 'Ver todos >',
                  options: FFButtonOptions(
                  height: 36.0,
                  padding: EdgeInsets.zero,
                  color: Colors.transparent,
                  textStyle: FlutterFlowTheme.of(context).labelLarge
                      .override(
                          font: GoogleFonts.fredoka(
                          fontWeight:
                              FlutterFlowTheme.of(context).labelLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).labelLarge.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primary,
                      )
                      .merge(const TextStyle(
                        decoration: TextDecoration.underline,
                      )),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
          ],
        ),
        ),
        const SizedBox(height: 12.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: planes.length,
          itemBuilder: (context, index) {
            final plan = planes[index];
            return _buildPlanCard(plan);
          },
        ),
      ],
    );
  }

  Widget _buildPlanCard(dynamic plan) {
    final nombre = plan['nombre'] ?? '';
    final descripcionCorta = plan['descripcioncorta'] ?? '';
    final precio = plan['precio'] ?? 0.0;
    final imagen = plan['imagen'] ?? '';
    final imagenes = plan['imagenes'] ?? plan['plan_images'] ?? (imagen != null && imagen.isNotEmpty ? [imagen] : []);
    final heroTag = 'planHero_${plan['idproducto'] ?? nombre}';
    final normalizedPlan = {
      'plan_title': nombre,
      'plan_image': imagen,
      'plan_images': imagenes,
      'descripcion': descripcionCorta,
      'precio': precio,
      'plan_price': precio.toStringAsFixed(2),
      'is_active': true,
      'plan_id': plan['idproducto'] ?? nombre,
      'plan_rating': (plan['rating'] ?? 0).toString(),
    };

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlanDetailPageWidget(
              plan: normalizedPlan,
              heroTag: heroTag,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Imagen
            ClipRRect(
              borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(12.0)),
              child: Hero(
                tag: heroTag,
                child: Image.network(
                  imagen,
                  width: 120.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 120.0,
                      height: 100.0,
                      color: FlutterFlowTheme.of(context).alternate,
                      child: const Center(
                        child: Icon(Icons.image_not_supported, size: 32.0),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Contenido
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.fredoka(fontWeight: FontWeight.w600),
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      descripcionCorta,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.fredoka(),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 13.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '\$${precio.toStringAsFixed(0)} USD',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.fredoka(fontWeight: FontWeight.bold),
                            color: FlutterFlowTheme.of(context).primary,
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiColeccion(List viajes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.luggage,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 28.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'MI COLECCIÓN',
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          font: GoogleFonts.fredoka(fontWeight: FontWeight.bold),
                          color: FlutterFlowTheme.of(context).primary,
                          letterSpacing: 0.0,
                        ),
                  ),
                ],
              ),
              // Botón para ver todas las colecciones activas
              InkWell(
                onTap: () {
                  context.pushNamed(MisColeccionesPageWidget.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Ver todas',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.fredoka(fontWeight: FontWeight.w600),
                              color: FlutterFlowTheme.of(context).primary,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                      const SizedBox(width: 4.0),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 14.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 220.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: viajes.length > 5 ? 5 : viajes.length,
            itemBuilder: (context, index) {
              final viaje = viajes[index];
              return _buildViajeCard(viaje, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildViajeCard(dynamic viaje, int index) {
    final acf = viaje['acf'] ?? {};
    final destino = acf['destino'] ?? 'Sin destino';
    final imagen = acf['imagen_para_card'] ?? acf['imagen_para_card_copiar'] ?? '';
    final fechaSalida = acf['fecha_de_salida'] ?? '';
    final calificacion = acf['calificacion'] ?? '0';

    return InkWell(
      onTap: () {
        context.pushNamed(
          ViajePageWidget.routeName,
          extra: <String, dynamic>{
            kTransitionInfoKey: const TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 300),
            ),
            'info': viaje,
          },
        );
      },
      child: Container(
        width: 280.0,
        margin: const EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
              child: imagen.isNotEmpty
                  ? Image.network(
                      imagen,
                      width: double.infinity,
                      height: 120.0,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 120.0,
                          color: FlutterFlowTheme.of(context).alternate,
                          child: Center(
                            child: Icon(
                              Icons.travel_explore,
                              size: 48.0,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      height: 120.0,
                      color: FlutterFlowTheme.of(context).alternate,
                      child: Center(
                        child: Icon(
                          Icons.travel_explore,
                          size: 48.0,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destino,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.fredoka(fontWeight: FontWeight.w600),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14.0,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        fechaSalida.isNotEmpty
                            ? '${fechaSalida.split('T').first}'
                            : 'Sin fecha',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.fredoka(),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14.0,
                        color: FlutterFlowTheme.of(context).warning,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        calificacion,
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.fredoka(fontWeight: FontWeight.w600),
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // NUEVO: Barra de búsqueda
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      color: FlutterFlowTheme.of(context).primaryBackground,
      child: TextField(
        decoration: InputDecoration(
          hintText: '¿A dónde quieres viajar?',
          prefixIcon: Icon(Icons.search, color: FlutterFlowTheme.of(context).primary),
          suffixIcon: Icon(Icons.tune, color: FlutterFlowTheme.of(context).secondaryText),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        onSubmitted: (value) {
          // Navegar a página de planes con búsqueda
          context.pushNamed(
            PlansPageWidget.routeName,
            queryParameters: {'search': value},
          );
        },
      ),
    );
  }

  // NUEVO: Ofertas especiales
  Widget _buildOfertasEspeciales(List planes) {
    // Filtrar planes con descuento
    final ofertas = planes.where((p) {
      final precioNormal = p['precio_normal'] ?? p['precio'];
      final precioRebajado = p['precio_rebajado'] ?? p['precio'];
      return precioRebajado != null && precioNormal != null && precioRebajado < precioNormal;
    }).toList();

    if (ofertas.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.local_fire_department, color: Colors.orange, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'OFERTAS ESPECIALES',
                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                        font: GoogleFonts.fredoka(fontWeight: FontWeight.bold),
                        color: Colors.orange,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    context.pushNamed(PlansPageWidget.routeName);
                  },
                  child: Text('Ver todas >'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: ofertas.length > 4 ? 4 : ofertas.length,
              itemBuilder: (context, index) {
                return _buildOfertaCard(ofertas[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfertaCard(dynamic plan) {
    final nombre = plan['nombre'] ?? '';
    final precioNormal = (plan['precio_normal'] ?? plan['precio'] ?? 0.0).toDouble();
    final precioRebajado = (plan['precio_rebajado'] ?? plan['precio'] ?? 0.0).toDouble();
    final imagen = plan['imagen'] ?? '';
    final imagenes = plan['imagenes'] ?? plan['plan_images'] ?? (imagen != null && imagen.isNotEmpty ? [imagen] : []);
    final descuento = precioNormal > 0 ? ((precioNormal - precioRebajado) / precioNormal * 100).round() : 0;
    final heroTag = 'oferta_${plan['idproducto'] ?? nombre}';

    return GestureDetector(
      onTap: () {
        final normalizedPlan = {
          'plan_title': nombre,
          'plan_image': imagen,
          'plan_images': imagenes,
          'descripcion': plan['descripcion_corta'] ?? plan['descripcioncorta'] ?? '',
          'precio': precioRebajado,
          'plan_price': precioRebajado.toStringAsFixed(2),
          'is_active': true,
          'plan_id': plan['idproducto'],
        };
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlanDetailPageWidget(
              plan: normalizedPlan,
              heroTag: heroTag,
            ),
          ),
        );
      },
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    imagen,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 140,
                        color: FlutterFlowTheme.of(context).alternate,
                        child: const Icon(Icons.image, size: 50, color: Colors.grey),
                      );
                    },
                  ),
                ),
                // Badge de descuento
                if (descuento > 0)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '-$descuento%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nombre,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (descuento > 0) ...[
                        Text(
                          '\$${precioNormal.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        '\$${precioRebajado.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final normalizedPlan = {
                          'plan_title': nombre,
                          'plan_image': imagen,
                          'plan_images': imagenes,
                          'descripcion': plan['descripcion_corta'] ?? plan['descripcioncorta'] ?? '',
                          'precio': precioRebajado,
                          'plan_price': precioRebajado.toStringAsFixed(2),
                          'is_active': true,
                          'plan_id': plan['idproducto'],
                        };
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlanDetailPageWidget(
                              plan: normalizedPlan,
                              heroTag: heroTag,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: FlutterFlowTheme.of(context).primary,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Comprar',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // NUEVO: Categorías rápidas
  Widget _buildCategoriasRapidas() {
    final categorias = [
      {'nombre': 'Playa', 'icon': Icons.beach_access, 'color': Colors.blue},
      {'nombre': 'Montaña', 'icon': Icons.terrain, 'color': Colors.green},
      {'nombre': 'Aventura', 'icon': Icons.hiking, 'color': Colors.orange},
      {'nombre': 'Romántico', 'icon': Icons.favorite, 'color': Colors.pink},
      {'nombre': 'Familiar', 'icon': Icons.family_restroom, 'color': Colors.purple},
      {'nombre': 'Nacional', 'icon': Icons.flag, 'color': Colors.amber},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'CATEGORÍAS',
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                font: GoogleFonts.fredoka(fontWeight: FontWeight.bold),
                color: FlutterFlowTheme.of(context).primaryText,
                letterSpacing: 0.0,
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final cat = categorias[index];
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      PlansPageWidget.routeName,
                      queryParameters: {'categoria': cat['nombre'] as String},
                    );
                  },
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: (cat['color'] as Color).withValues(alpha: 0.2),
                          child: Icon(
                            cat['icon'] as IconData,
                            color: cat['color'] as Color,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cat['nombre'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
