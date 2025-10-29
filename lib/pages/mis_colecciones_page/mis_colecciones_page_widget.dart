import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/viaje_page/viaje_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mis_colecciones_page_model.dart';
export 'mis_colecciones_page_model.dart';

class MisColeccionesPageWidget extends StatefulWidget {
  const MisColeccionesPageWidget({super.key});

  static String routeName = 'mis_colecciones_page';
  static String routePath = '/mis-colecciones';

  @override
  State<MisColeccionesPageWidget> createState() =>
      _MisColeccionesPageWidgetState();
}

class _MisColeccionesPageWidgetState extends State<MisColeccionesPageWidget> {
  late MisColeccionesPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = true;
  List<dynamic> _viajesActivos = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MisColeccionesPageModel());

    // Cargar viajes activos al iniciar
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _loadViajesActivos();
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _loadViajesActivos() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Llamar a la API para obtener solo viajes activos
      final response = await FastAPIViajesCall.call(
        author: FFAppState().userSessionID.toString(),
        token: FFAppState().token,
        isActive: true, // Filtrar solo viajes activos
      );

      if (response.succeeded) {
        final data = response.jsonBody;
        setState(() {
          if (data is List) {
            _viajesActivos = data;
          } else {
            _viajesActivos = [];
          }
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Error al cargar viajes activos';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24.0,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.luggage,
                color: Colors.white,
                size: 28.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                'MIS COLECCIONES ACTIVAS',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      font: GoogleFonts.fredoka(fontWeight: FontWeight.bold),
                      color: Colors.white,
                      fontSize: 20.0,
                      letterSpacing: 0.0,
                    ),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
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
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.fredoka(),
                                    color: FlutterFlowTheme.of(context).error,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : _viajesActivos.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.luggage_outlined,
                                  size: 80.0,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  'No tienes colecciones activas',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        font: GoogleFonts.fredoka(
                                            fontWeight: FontWeight.bold),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Activa tus colecciones desde la página de viaje',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.fredoka(),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _loadViajesActivos,
                          child: ListView(
                            padding: const EdgeInsets.all(16.0),
                            children: [
                              // Header con contador
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${_viajesActivos.length} ${_viajesActivos.length == 1 ? 'colección activa' : 'colecciones activas'}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.fredoka(
                                                fontWeight: FontWeight.w600),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              // Grid de viajes activos
                              ...List.generate(
                                _viajesActivos.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: _buildViajeCard(_viajesActivos[index]),
                                ),
                              ),
                            ],
                          ),
                        ),
        ),
      ),
    );
  }

  Widget _buildViajeCard(dynamic viaje) {
    final acf = viaje['acf'] ?? {};
    final destino = acf['destino'] ?? 'Sin destino';
    final descripcion = acf['descripcion'] ?? '';
    final imagen = acf['imagen_para_card'] ?? acf['imagen_para_card_copiar'] ?? '';
    final fechaSalida = acf['fecha_de_salida'] ?? '';
    final fechaLlegada = acf['fecha_de_llegada'] ?? '';
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
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del viaje
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16.0)),
              child: imagen.isNotEmpty
                  ? Image.network(
                      imagen,
                      width: double.infinity,
                      height: 200.0,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200.0,
                          color: FlutterFlowTheme.of(context).alternate,
                          child: Center(
                            child: Icon(
                              Icons.travel_explore,
                              size: 64.0,
                              color:
                                  FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      height: 200.0,
                      color: FlutterFlowTheme.of(context).alternate,
                      child: Center(
                        child: Icon(
                          Icons.travel_explore,
                          size: 64.0,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                    ),
            ),
            // Contenido
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Destino
                  Text(
                    destino,
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          font: GoogleFonts.fredoka(fontWeight: FontWeight.bold),
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 20.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  // Descripción
                  if (descripcion.isNotEmpty)
                    Text(
                      descripcion,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.fredoka(),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  const SizedBox(height: 12.0),
                  // Fechas
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16.0,
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        fechaSalida.isNotEmpty && fechaLlegada.isNotEmpty
                            ? '${fechaSalida.split('T').first} - ${fechaLlegada.split('T').first}'
                            : fechaSalida.isNotEmpty
                                ? fechaSalida.split('T').first
                                : 'Sin fechas',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.fredoka(),
                              color:
                                  FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 13.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  // Calificación
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 18.0,
                        color: FlutterFlowTheme.of(context).warning,
                      ),
                      const SizedBox(width: 6.0),
                      Flexible(
                        child: Text(
                          calificacion,
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.fredoka(
                                    fontWeight: FontWeight.w600),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      // Badge de "Activo"
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).success,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 14.0,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              'ACTIVO',
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    font: GoogleFonts.fredoka(
                                        fontWeight: FontWeight.bold),
                                    color: Colors.white,
                                    fontSize: 11.0,
                                    letterSpacing: 0.5,
                                  ),
                            ),
                          ],
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
}

