import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'payment_waiting_page_model.dart';
export 'payment_waiting_page_model.dart';

class PaymentWaitingPageWidget extends StatefulWidget {
  const PaymentWaitingPageWidget({
    super.key,
    required this.compraId,
    required this.paymentUrl,
  });

  final int compraId;
  final String paymentUrl;

  static String routeName = 'PaymentWaitingPage';
  static String routePath = '/payment-waiting';

  @override
  State<PaymentWaitingPageWidget> createState() => _PaymentWaitingPageWidgetState();
}

class _PaymentWaitingPageWidgetState extends State<PaymentWaitingPageWidget> {
  late PaymentWaitingPageModel _model;
  Timer? _pollTimer;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentWaitingPageModel());

    // Abrir URL de pago en navegador externo
    _openPaymentUrl();

    // Iniciar polling para verificar estado del pago cada 3 segundos
    _startPolling();
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _model.dispose();
    super.dispose();
  }

  Future<void> _openPaymentUrl() async {
    try {
      final uri = Uri.parse(widget.paymentUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        _showError('No se pudo abrir el navegador');
      }
    } catch (e) {
      _showError('Error al abrir URL de pago: ${e.toString()}');
    }
  }

  void _startPolling() {
    _pollTimer = Timer.periodic(Duration(seconds: 3), (timer) async {
      await _checkPaymentStatus();
    });

    // Cancelar polling después de 10 minutos (timeout)
    Future.delayed(Duration(minutes: 10), () {
      if (_pollTimer?.isActive ?? false) {
        _pollTimer?.cancel();
        if (mounted) {
          _navigateToResult('timeout', 'Tiempo de espera agotado');
        }
      }
    });
  }

  Future<void> _checkPaymentStatus() async {
    try {
      final response = await FastAPIGetPurchaseCall.call(
        authToken: FFAppState().token,
        purchaseId: widget.compraId,
      );

      if (response.succeeded) {
        final estado = FastAPIGetPurchaseCall.estado(response.jsonBody);

        print('[Payment Waiting] Estado actual: $estado');

        if (estado == 'approved') {
          _pollTimer?.cancel();
          _navigateToResult('success', 'Pago aprobado exitosamente');
        } else if (estado == 'rejected' || estado == 'cancelled') {
          _pollTimer?.cancel();
          _navigateToResult('failure', 'Pago rechazado o cancelado');
        }
        // Si está en 'pending', continuar polling
      }
    } catch (e) {
      print('[Payment Waiting] Error checking status: $e');
    }
  }

  void _navigateToResult(String status, String message) {
    if (mounted) {
      context.pushReplacementNamed(
        'PaymentResultPage',
        queryParameters: {
          'status': status,
          'message': message,
          'compra_id': widget.compraId.toString(),
        },
      );
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: FlutterFlowTheme.of(context).error,
      ),
    );
  }

  void _cancelPayment() {
    _pollTimer?.cancel();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _pollTimer?.cancel();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Procesando Pago',
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
                  // Icono de espera
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).accent1,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.payment,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 60.0,
                    ),
                  ),

                  SizedBox(height: 32.0),

                  // Texto principal
                  Text(
                    'Esperando confirmación del pago',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Outfit',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 24.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),

                  SizedBox(height: 16.0),

                  // Descripción
                  Text(
                    'Completa el pago en la ventana de Mercado Pago que se abrió en tu navegador.',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                        ),
                  ),

                  SizedBox(height: 32.0),

                  // Indicador de carga
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),

                  SizedBox(height: 16.0),

                  Text(
                    'Verificando estado del pago...',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                        ),
                  ),

                  SizedBox(height: 48.0),

                  // Botón para reabrir URL
                  FFButtonWidget(
                    onPressed: _openPaymentUrl,
                    text: 'Volver a abrir Mercado Pago',
                    icon: Icon(
                      Icons.open_in_browser,
                      size: 20.0,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Readex Pro',
                            color: Colors.white,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                          ),
                      elevation: 2.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),

                  SizedBox(height: 16.0),

                  // Botón cancelar
                  FFButtonWidget(
                    onPressed: _cancelPayment,
                    text: 'Cancelar y volver',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Readex Pro',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),

                  SizedBox(height: 24.0),

                  // Información adicional
                  Container(
                    width: double.infinity,
                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F4F8),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 20.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Ten en cuenta',
                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'No cierres esta pantalla hasta que se confirme tu pago. Estamos verificando automáticamente el estado de tu transacción.',
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 11.0,
                                letterSpacing: 0.0,
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
      ),
    );
  }
}
