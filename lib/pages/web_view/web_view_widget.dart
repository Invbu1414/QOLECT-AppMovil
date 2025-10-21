import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'web_view_model.dart';
export 'web_view_model.dart';
import '/components/app_bar/main_sliver_app_bar.dart';
import '/components/optimized_image/optimized_image_widget.dart';
import '/pages/cart_page/cart_page_widget.dart';

class WebViewWidget extends StatefulWidget {
  const WebViewWidget({
    super.key,
    required this.url,
  });

  final String? url;

  static String routeName = 'webView';
  static String routePath = '/webview';

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  late WebViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WebViewModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('FloatingActionButton pressed ...');
          },
          backgroundColor: Color(0x004078A8),
          elevation: 8.0,
          child: Align(
            alignment: AlignmentDirectional(0.75, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                await actions.launchInBrowser(
                  'https://api.whatsapp.com/send?phone=+573018119374&text=Hola%2C%20quiero%20armar%20mi%20plan%20de%20vacaciones%20%F0%9F%9B%AB.%0AViajo%20desde%20(Ingresa%20lugar%20de%20salida)%2C%20hac%C3%ADa%20(Ingresa%20lugar%20de%20destino)%20%F0%9F%98%8E',
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/Group_48.png',
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            MainSliverAppBar(
              title: '',
              titleWidget: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                child: OptimizedImageWidget(
                  imageUrl: 'assets/images/LOGO_3.png',
                  width: 226.0,
                  height: 63.0,
                  fit: BoxFit.cover,
                  borderRadius: 8.0,
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
                  width: 400.0,
                  height: MediaQuery.sizeOf(context).height * 1.0,
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
                  child: Align(
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: FlutterFlowPdfViewer(
                      networkPath: widget.url!,
                      width: 400.0,
                      height: 600.0,
                      horizontalScroll: false,
                    ),
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
