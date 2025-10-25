import '/backend/api_requests/api_calls.dart';
import '/components/home_drawer/home_drawer_widget.dart';
import '/components/whatsapp_fab/whatsapp_fab_widget.dart';
import '/pages/cart_page/cart_page_widget.dart';
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
  String? _errorMessage;

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

      final response = await FastAPIHomeCall.call();

      if (response.succeeded) {
        if (mounted) {
          setState(() {
            _homeData = response.jsonBody;
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
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
          child: Icon(
            Icons.menu,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            size: 30.0,
          ),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'assets/images/LOGO_3.png',
            width: 226.0,
            height: 63.0,
            fit: BoxFit.cover,
          ),
        ),
        centerTitle: true,
        elevation: 2.0,
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
              : Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/20852675_6345959_1_(2).png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Banner
                        if (_homeData != null &&
                            _homeData['banner'] != null)
                          _buildBanner(_homeData['banner']),

                        const SizedBox(height: 20.0),

                        // Noticias Destacadas
                        if (_homeData != null &&
                            _homeData['noticias_destacadas'] != null)
                          _buildNoticiasDestacadas(
                              _homeData['noticias_destacadas']),

                        const SizedBox(height: 20.0),

                        // Planes Populares
                        if (_homeData != null &&
                            _homeData['planes_populares'] != null)
                          _buildPlanesPopulares(
                              _homeData['planes_populares']),

                        const SizedBox(height: 50.0),
                      ],
                    ),
                  ),
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
    final heroTag = 'planHero_${plan['idproducto'] ?? nombre}';
    final normalizedPlan = {
      'plan_title': nombre,
      'plan_image': imagen,
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
}
