import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'payment_result_page_model.dart';
export 'payment_result_page_model.dart';

class PaymentResultPageWidget extends StatefulWidget {
  const PaymentResultPageWidget({
    super.key,
    required this.status,
    required this.message,
    this.compraId,
  });

  final String status; // 'success', 'failure', 'timeout'
  final String message;
  final int? compraId;

  static String routeName = 'PaymentResultPage';
  static String routePath = '/payment-result';

  @override
  State<PaymentResultPageWidget> createState() => _PaymentResultPageWidgetState();
}

class _PaymentResultPageWidgetState extends State<PaymentResultPageWidget> {
  late PaymentResultPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentResultPageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  bool get isSuccess => widget.status == 'success';

  IconData get statusIcon {
    switch (widget.status) {
      case 'success':
        return Icons.check_circle;
      case 'failure':
        return Icons.cancel;
      case 'timeout':
        return Icons.access_time;
      default:
        return Icons.info;
    }
  }

  Color get statusColor {
    switch (widget.status) {
      case 'success':
        return Color(0xFF4CAF50);
      case 'failure':
        return FlutterFlowTheme.of(context).error;
      case 'timeout':
        return Color(0xFFFF9800);
      default:
        return FlutterFlowTheme.of(context).secondaryText;
    }
  }

  String get statusTitle {
    switch (widget.status) {
      case 'success':
        return '¡Pago Exitoso!';
      case 'failure':
        return 'Pago Rechazado';
      case 'timeout':
        return 'Tiempo Agotado';
      default:
        return 'Resultado del Pago';
    }
  }

  void _navigateHome() {
    context.pushNamed('NewHomePage');
  }

  void _navigateToMyTrips() {
    context.pushNamed('MisColeccionesPage');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _navigateHome();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: statusColor,
          automaticallyImplyLeading: false,
          title: Text(
            statusTitle,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Center(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icono de estado
                  Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      statusIcon,
                      color: statusColor,
                      size: 80.0,
                    ),
                  ),

                  SizedBox(height: 32.0),

                  // Título
                  Text(
                    statusTitle,
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Outfit',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 28.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  SizedBox(height: 16.0),

                  // Mensaje
                  Text(
                    widget.message,
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                        ),
                  ),

                  if (isSuccess) ...[
                    SizedBox(height: 24.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: Color(0xFF4CAF50),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.card_travel,
                            color: Color(0xFF4CAF50),
                            size: 40.0,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            '¡Tu viaje ha sido creado!',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF2E7D32),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Puedes ver todos los detalles de tu viaje en "Mis Colecciones"',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF2E7D32),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  SizedBox(height: 40.0),

                  // Botones de acción
                  if (isSuccess) ...[
                    FFButtonWidget(
                      onPressed: _navigateToMyTrips,
                      text: 'Ver Mis Viajes',
                      icon: Icon(
                        Icons.card_travel,
                        size: 24.0,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 54.0,
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                              fontSize: 18.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                            ),
                        elevation: 3.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    SizedBox(height: 16.0),
                  ],

                  FFButtonWidget(
                    onPressed: _navigateHome,
                    text: isSuccess ? 'Volver al Inicio' : 'Volver e Intentar de Nuevo',
                    icon: Icon(
                      Icons.home,
                      size: 20.0,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                      color: isSuccess
                          ? FlutterFlowTheme.of(context).secondaryBackground
                          : FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Readex Pro',
                            color: isSuccess
                                ? FlutterFlowTheme.of(context).primaryText
                                : Colors.white,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                          ),
                      elevation: isSuccess ? 0.0 : 2.0,
                      borderSide: BorderSide(
                        color: isSuccess
                            ? FlutterFlowTheme.of(context).alternate
                            : Colors.transparent,
                        width: isSuccess ? 2.0 : 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),

                  if (!isSuccess) ...[
                    SizedBox(height: 32.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.help_outline,
                                color: Color(0xFFF57C00),
                                size: 20.0,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                '¿Necesitas ayuda?',
                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFE65100),
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Si tienes problemas con el pago, verifica tu método de pago o contacta con soporte.',
                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFFE65100),
                                  fontSize: 11.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
