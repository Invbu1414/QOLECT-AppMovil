import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/components/planes_list/plan_item.dart';
import '/components/app_bar/main_sliver_app_bar.dart';
import '/pages/cart_page/cart_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//TODO: REMOVE
import 'dart:convert'; // NUEVO: para pretty-print JSON

class PlansPageWidget extends StatefulWidget {
  const PlansPageWidget({super.key});

  static String routeName = 'plans_page';
  static String routePath = '/plans';

  @override
  State<PlansPageWidget> createState() => _PlansPageWidgetState();
}

class _PlansPageWidgetState extends State<PlansPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = true;
  String? _error;
  List<dynamic> _planes = const [];

  @override
  void initState() {
    super.initState();
    _fetchPlanes();
  }

  Future<void> _fetchPlanes() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _planes = const [];
    });

    final resp = await FastAPIPlanesCall.call(skip: 0, limit: 50);
    if (!mounted) return;

    if (resp.succeeded) {
      final body = resp.jsonBody;
      try {
        final pretty = const JsonEncoder.withIndent('  ').convert(body);
        debugPrint('FastAPIPlanesCall response: $pretty');
        debugPrint(pretty, wrapWidth: 2048);
      } catch (_) {
        debugPrint('HOME DATA: $body', wrapWidth: 2048);
      }
      final items = getJsonField(body, r'''$.items''', true) as List? ?? [];
      final mapped = items.map(_mapFastAPIItemToPlan).toList();
      setState(() {
        _planes = mapped;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        _error = 'No fue posible cargar los planes (HTTP ${resp.statusCode}).';
      });
    }
  }

  Map<String, dynamic> _mapFastAPIItemToPlan(dynamic item) {
    final id = getJsonField(item, r'''$.plan_id''');
    final nombre = getJsonField(item, r'''$.plan_title''')?.toString() ?? '';
    final imagenUrl = getJsonField(item, r'''$.plan_image''')?.toString() ?? '';
    final precio = getJsonField(item, r'''$.precio''');

    return {
      'plan_id': id,
      'plan_title': nombre,
      'plan_image': imagenUrl,
      'plan_price': precio?.toString() ?? '',
      'plan_has_image': imagenUrl.isNotEmpty,
      'plan_rating': getJsonField(item, r'''$.plan_rating''')?.toString() ?? '',
      'plan_url': getJsonField(item, r'''$.plan_url''')?.toString() ??
          getJsonField(item, r'''$.url''')?.toString() ??
          '',
      'descripcion': getJsonField(item, r'''$.descripcion''')?.toString() ?? '',
      'precio': precio,
      'is_active': getJsonField(item, r'''$.is_active''') == true,
    };
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
              title: 'Todos los planes',
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
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
                  ? _buildError(context)
                  : MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        primary: false,
                        itemCount: _planes.length,
                        itemBuilder: (context, index) {
                          final plan = _planes[index];
                          return PlanItem(plan: plan);
                        },
                      ),
                    ),
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _error ?? 'Error desconocido',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.fredoka(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                ),
          ),
          const SizedBox(height: 16.0),
          FFButtonWidget(
            onPressed: _fetchPlanes,
            text: 'Reintentar',
            options: FFButtonOptions(
              height: 40.0,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              color: FlutterFlowTheme.of(context).primary,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    font: GoogleFonts.fredoka(
                      fontWeight:
                          FlutterFlowTheme.of(context).titleSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                    ),
                    color: Colors.white,
                    letterSpacing: 0.0,
                  ),
              elevation: 2.0,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ],
      ),
    );
  }
}
