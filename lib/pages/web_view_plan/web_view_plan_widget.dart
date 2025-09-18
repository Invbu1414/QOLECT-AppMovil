import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'web_view_plan_model.dart';
export 'web_view_plan_model.dart';

class WebViewPlanWidget extends StatefulWidget {
  const WebViewPlanWidget({
    super.key,
    required this.url,
  });

  final String? url;

  static String routeName = 'webViewPlan';
  static String routePath = '/webviewplan';

  @override
  State<WebViewPlanWidget> createState() => _WebViewPlanWidgetState();
}

class _WebViewPlanWidgetState extends State<WebViewPlanWidget> {
  late WebViewPlanModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WebViewPlanModel());
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
        floatingActionButton: WebViewAware(
          child: FloatingActionButton(
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
        ),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              expandedHeight: 90.0,
              pinned: false,
              floating: true,
              snap: true,
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: false,
              leading: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.safePop();
                },
                child: Icon(
                  Icons.chevron_left_outlined,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  size: 30.0,
                ),
              ),
              title: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/LOGO_3.png',
                    width: 226.0,
                    height: 63.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              actions: [
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 25.0, 0.0),
                    child: badges.Badge(
                      badgeContent: Text(
                        valueOrDefault<String>(
                          FFAppState().notificationsAmount.toString(),
                          '0',
                        ),
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              font: GoogleFonts.fredoka(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                              color: Colors.white,
                              fontSize: 11.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                      ),
                      showBadge: true,
                      shape: badges.BadgeShape.circle,
                      badgeColor: FlutterFlowTheme.of(context).error,
                      elevation: 4.0,
                      padding: EdgeInsets.all(5.0),
                      position: badges.BadgePosition.topEnd(),
                      animationType: badges.BadgeAnimationType.scale,
                      toAnimate: false,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(NotificationsPageWidget.routeName);
                        },
                        child: Icon(
                          Icons.notifications,
                          color: FlutterFlowTheme.of(context).warning,
                          size: 35.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: true,
              toolbarHeight: 90.0,
              elevation: 2.0,
            )
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
                  child: FlutterFlowWebView(
                    content: widget.url!,
                    bypass: false,
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    verticalScroll: false,
                    horizontalScroll: false,
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
