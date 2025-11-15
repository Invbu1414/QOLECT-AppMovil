import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'checkout_page_model.dart';
export 'checkout_page_model.dart';

class CheckoutPageWidget extends StatefulWidget {
  const CheckoutPageWidget({
    super.key,
    required this.planId,
    required this.planTitle,
    required this.planPrice,
    required this.planImage,
    this.planDescription,
  });

  final int planId;
  final String planTitle;
  final double planPrice;
  final String planImage;
  final String? planDescription;

  static String routeName = 'CheckoutPage';
  static String routePath = '/checkout';

  @override
  State<CheckoutPageWidget> createState() => _CheckoutPageWidgetState();
}

class _CheckoutPageWidgetState extends State<CheckoutPageWidget> {
  late CheckoutPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckoutPageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _createCheckout() async {
    setState(() {
      _model.isLoading = true;
    });

    try {
      final response = await FastAPICreateCheckoutCall.call(
        authToken: FFAppState().token,
        itemId: widget.planId.toString(),
        itemTitle: widget.planTitle,
        itemDescription: widget.planDescription ?? '',
        itemQuantity: 1,
        itemUnitPrice: widget.planPrice,
        currencyId: 'COP',
        tipoCompra: 'plan',
        idproducto: widget.planId,
      );

      if (response.succeeded) {
        final compraId = FastAPICreateCheckoutCall.compraId(response.jsonBody);
        final initPoint = FastAPICreateCheckoutCall.sandboxInitPoint(response.jsonBody) ??
            FastAPICreateCheckoutCall.initPoint(response.jsonBody);

        if (initPoint != null && compraId != null) {
          // Navegar a página de espera de pago
          context.pushNamed(
            'PaymentWaitingPage',
            queryParameters: {
              'compra_id': compraId.toString(),
              'payment_url': initPoint,
            },
          );
        } else {
          _showError('Error al obtener URL de pago');
        }
      } else {
        _showError('Error al crear checkout');
      }
    } catch (e) {
      _showError('Error: ${e.toString()}');
    } finally {
      setState(() {
        _model.isLoading = false;
      });
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
            onPressed: () => context.pop(),
          ),
          title: Text(
            'Confirmar Compra',
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
          child: _model.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Imagen del plan
                      Container(
                        width: double.infinity,
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: Image.network(
                            widget.planImage,
                            width: double.infinity,
                            height: 200.0,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 200.0,
                                color: FlutterFlowTheme.of(context).alternate,
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 50.0,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Detalles de la compra
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Título
                            Text(
                              widget.planTitle,
                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                    fontFamily: 'Outfit',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 24.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),

                            if (widget.planDescription != null && widget.planDescription!.isNotEmpty)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                child: Text(
                                  widget.planDescription!,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),

                            Divider(
                              height: 40.0,
                              thickness: 1.0,
                              color: FlutterFlowTheme.of(context).alternate,
                            ),

                            // Resumen de compra
                            Text(
                              'Resumen de compra',
                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),

                            SizedBox(height: 16.0),

                            // Fila de precio
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Precio',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Text(
                                  '\$${widget.planPrice.toStringAsFixed(0)} COP',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),

                            SizedBox(height: 12.0),

                            // Fila de cantidad
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cantidad',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Text(
                                  '1',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),

                            Divider(
                              height: 32.0,
                              thickness: 2.0,
                              color: FlutterFlowTheme.of(context).primary,
                            ),

                            // Total
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 22.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  '\$${widget.planPrice.toStringAsFixed(0)} COP',
                                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context).primary,
                                        fontSize: 22.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),

                            SizedBox(height: 32.0),

                            // Botón de pago
                            FFButtonWidget(
                              onPressed: _createCheckout,
                              text: 'Pagar con Mercado Pago',
                              icon: Icon(
                                Icons.payment,
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
                                        Icons.lock_outline,
                                        color: FlutterFlowTheme.of(context).primary,
                                        size: 20.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        'Pago seguro con Mercado Pago',
                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                              fontFamily: 'Readex Pro',
                                              color: FlutterFlowTheme.of(context).secondaryText,
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Tu información está protegida. Serás redirigido a Mercado Pago para completar el pago de forma segura.',
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
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
