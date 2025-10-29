import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/components/app_bar/main_sliver_app_bar.dart';
import '/components/optimized_image/optimized_image_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartPageWidget extends StatefulWidget {
  const CartPageWidget({Key? key}) : super(key: key);

  @override
  State<CartPageWidget> createState() => _CartPageWidgetState();
}

class _CartPageWidgetState extends State<CartPageWidget> {
  Future<bool> _confirmDeleteItem(BuildContext context, String itemName) async {
    final theme = FlutterFlowTheme.of(context);
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: theme.secondaryBackground,
          title: Text('Eliminar ítem', style: theme.titleMedium),
          content: Text(
            '¿Quieres eliminar "$itemName" del carrito?',
            style: theme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text('Cancelar', style: theme.bodyMedium),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(
                'Eliminar',
                style: theme.bodyMedium.override(
                  color: theme.error,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }
  @override
  void initState() {
    super.initState();
  }

  Future<void> _checkoutWhatsApp(FFAppState state) async {
    if (state.cartItems.isEmpty) return;

    // Generar mensaje para WhatsApp
    String mensaje = '¡Hola! 👋 Quiero comprar las siguientes experiencias:\n\n';

    for (var item in state.cartItems) {
      mensaje += '• ${item.name}\n';
      mensaje += '  Cantidad: ${item.quantity}\n';
      mensaje += '  Precio: \$${item.price.toStringAsFixed(2)}\n\n';
    }

    mensaje += '*Total: \$${state.cartTotal.toStringAsFixed(2)}*\n\n';
    mensaje += '¿Podrías ayudarme con el proceso de compra? 😊';

    // Número de WhatsApp
    const String phoneNumber = '573105158593'; // +57 310 5158593 (sin espacios ni +)

    // URL de WhatsApp con mensaje
    final whatsappUrl = 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(mensaje)}';

    await actions.launchInBrowser(whatsappUrl);
  }

  Future<void> _checkoutMercadoPago(FFAppState state) async {
    if (state.cartItems.isEmpty) return;

    // TODO: Implementar integración con Mercado Pago
    // Por ahora está deshabilitado
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FFAppState>();
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, _) => [
          MainSliverAppBar(
            title: 'CARRITO',
            leadingIcon: Icons.chevron_left_outlined,
            onLeadingTap: () async {
              context.safePop();
            },
            onMenuTap: () {},
            onCartTap: () {},
            notificationsCount: FFAppState().notificationsAmount,
            cartCount: FFAppState().cartItems.length,
          ),
        ],
        body: state.cartItems.isEmpty
            ? const Center(child: Text('Tu carrito está vacío'))
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: state.cartItems.length,
                itemBuilder: (context, idx) {
                  final item = state.cartItems[idx];
                  return Dismissible(
                    key: ValueKey(item.id),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) => _confirmDeleteItem(context, item.name),
                    onDismissed: (_) => state.removeFromCart(item.id),
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 6.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(12.0),
                            ),
                            child: (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                                ? OptimizedImageWidget(
                                    imageUrl: item.imageUrl,
                                    width: 120.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                    borderRadius: 0.0,
                                  )
                                : Container(
                                    width: 120.0,
                                    height: 100.0,
                                    color: FlutterFlowTheme.of(context).alternate,
                                    child: const Center(
                                      child: Icon(Icons.image_not_supported, size: 32.0),
                                    ),
                                  ),
                          ),
                          // Contenido (tipografías y tamaños iguales)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                font: GoogleFonts.fredoka(fontWeight: FontWeight.w600),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                      IconButton(
                                        tooltip: 'Eliminar',
                                        icon: const Icon(Icons.delete_outline),
                                        onPressed: () async {
                                          final confirmed = await _confirmDeleteItem(context, item.name);
                                          if (confirmed) {
                                            state.removeFromCart(item.id);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    '\$${item.price.toStringAsFixed(0)} USD',
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
                },
              ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
        color: FlutterFlowTheme.of(context).secondaryBackground,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total: \$${state.cartTotal.toStringAsFixed(2)}',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                  font: GoogleFonts.fredoka(
                    fontWeight: FontWeight.w600,
                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primary,
                  fontSize: 24.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Botón de WhatsApp (Activo)
            FFButtonWidget(
              onPressed: state.cartItems.isEmpty ? null : () => _checkoutWhatsApp(state),
              text: 'Comprar por WhatsApp',
              icon: const FaIcon(
                FontAwesomeIcons.whatsapp,
                size: 24,
              ),
              options: FFButtonOptions(
                width: double.infinity,
                height: 52,
                color: const Color(0xFF25D366), // Verde de WhatsApp
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  font: GoogleFonts.fredoka(fontWeight: FontWeight.w600),
                  color: Colors.white,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                ),
                elevation: 2.0,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            const SizedBox(height: 10),
            // Botón de Mercado Pago (Deshabilitado)
            Opacity(
              opacity: 0.5,
              child: FFButtonWidget(
                onPressed: null, // Deshabilitado
                text: 'Pagar con Mercado Pago',
                icon: Icon(
                  Icons.credit_card,
                  size: 24,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 52,
                  color: const Color(0xFF009EE3), // Azul de Mercado Pago
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    font: GoogleFonts.fredoka(fontWeight: FontWeight.w600),
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                  ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Próximamente: Pago con tarjeta',
              style: FlutterFlowTheme.of(context).bodySmall.override(
                font: GoogleFonts.fredoka(),
                color: FlutterFlowTheme.of(context).secondaryText,
                fontSize: 12.0,
                letterSpacing: 0.0,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
