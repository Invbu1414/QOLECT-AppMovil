import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'package:provider/provider.dart';

import 'home_drawer_model.dart';
export 'home_drawer_model.dart';

class HomeDrawerWidget extends StatefulWidget {
  const HomeDrawerWidget({super.key});

  @override
  State<HomeDrawerWidget> createState() => _HomeDrawerWidgetState();
}

class _HomeDrawerWidgetState extends State<HomeDrawerWidget> {
  late HomeDrawerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeDrawerModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    
    return Opacity(
      opacity: 0.9,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.95,
        child: Drawer(
          elevation: 20.0,
          child: WebViewAware(
            child: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              decoration: BoxDecoration(
                color: Color(0xFF427AAB),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(30.0),
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20.0,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Background pattern overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.05),
                            Colors.transparent,
                            Colors.black.withOpacity(0.05),
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),

                  // Main content
                  SafeArea(
                    child: Column(
                      children: [
                        // Header with close button
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Logo
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/10_1.png',
                                      width: 60.0,
                                      height: 60.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'QOLECT',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              color: Colors.white,
                                              fontSize: 24.0,
                                              letterSpacing: 1.0,
                                            ),
                                      ),
                                      Text(
                                        'Tu próxima aventura',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.roboto(),
                                              color: Colors.white.withOpacity(0.7),
                                              fontSize: 16.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Close button
                              Container(
                                width: 45.0,
                                height: 45.0,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1.5,
                                  ),
                                ),
                                child: InkWell(
                                  splashColor: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(25.0),
                                  onTap: () async {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: Colors.white,
                                    size: 22.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Menu title
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white.withOpacity(0.3),
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 4.0,
                                height: 25.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                              ),
                              SizedBox(width: 15.0),
                              Text(
                                'Menú Principal',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      letterSpacing: 0.5,
                                    ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 15.0),

                        // Menu items
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                _buildMinimalMenuItem(
                                  context: context,
                                  title: 'Mis Viajes',
                                  subtitle: 'Ver mis reservas',
                                  icon: FontAwesomeIcons.planeArrival,
                                  onTap: () async {
                                    context.pushNamed(HomePageWidget.routeName);
                                  },
                                ),

                                if (FFAppState().userSessionID != 83)
                                  _buildMinimalMenuItem(
                                    context: context,
                                    title: 'Mi Perfil',
                                    subtitle: 'Configuración personal',
                                    icon: Icons.person_outline_rounded,
                                    onTap: () async {
                                      context.pushNamed(ProfilePageWidget.routeName);
                                    },
                                  ),

                                _buildMinimalMenuItem(
                                  context: context,
                                  title: 'Noticias',
                                  subtitle: 'Últimas actualizaciones',
                                  icon: Icons.article_outlined,
                                  onTap: () async {
                                    context.pushNamed(NoticesPageWidget.routeName);
                                  },
                                ),

                                _buildMinimalMenuItem(
                                  context: context,
                                  title: 'Comunidad',
                                  subtitle: 'Conecta con otros viajeros',
                                  icon: Icons.people_outline_rounded,
                                  onTap: () async {
                                    context.pushNamed(ComunidadWidget.routeName);
                                  },
                                ),

                                SizedBox(height: 20.0),

                                // Logout button
                                Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.red.shade50.withOpacity(0.3),
                                        Colors.red.shade100.withOpacity(0.2),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    border: Border.all(
                                      color: Colors.red.withOpacity(0.3),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withOpacity(0.1),
                                        blurRadius: 6.0,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      splashColor: Colors.red.withOpacity(0.2),
                                      highlightColor: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(15.0),
                                      onTap: () async {
                                        FFAppState().token = '';
                                        FFAppState().userSessionID = 0;
                                        FFAppState().userEmail = '';
                                        FFAppState().notificationsAmount = 0;
                                        safeSetState(() {});
                                        GoRouter.of(context).prepareAuthEvent();
                                        await authManager.signOut();
                                        GoRouter.of(context).clearRedirectLocation();

                                        context.pushNamedAuth(
                                            LoginPageWidget.routeName,
                                            context.mounted);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(6.0),
                                              decoration: BoxDecoration(
                                                color: Colors.red.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: Icon(
                                                Icons.logout_rounded,
                                                color: Colors.red.shade400,
                                                size: 18.0,
                                              ),
                                            ),
                                            SizedBox(width: 12.0),
                                            Text(
                                              'Cerrar Sesión',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.fredoka(
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    color: Colors.red.shade400,
                                                    fontSize: 15.0,
                                                    letterSpacing: 0.5,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Footer section
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              // Divider
                              Container(
                                height: 1.0,
                                margin: EdgeInsets.only(bottom: 20.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.white.withOpacity(0.4),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),

                              // Social media section
                              Text(
                                'Síguenos',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                      ),
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 14.0,
                                      letterSpacing: 0.5,
                                    ),
                              ),
                              SizedBox(height: 15.0),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildSocialIconMinimal(
                                    icon: FontAwesomeIcons.whatsapp,
                                    onTap: () async {
                                      await actions.launchInBrowser(
                                        'https://api.whatsapp.com/send?phone=+573018119374&text=Hola%2C%20quiero%20armar%20mi%20plan%20de%20vacaciones%20%F0%9F%9B%AB.%0AViajo%20desde%20(Ingresa%20lugar%20de%20salida)%2C%20hac%C3%ADa%20(Ingresa%20lugar%20de%20destino)%20%F0%9F%98%8E',
                                      );
                                    },
                                  ),
                                  _buildSocialIconMinimal(
                                    icon: FontAwesomeIcons.instagram,
                                    onTap: () async {
                                      await actions.launchInBrowser(
                                        'https://www.instagram.com/qolect/',
                                      );
                                    },
                                  ),
                                  _buildSocialIconMinimal(
                                    icon: Icons.facebook,
                                    onTap: () async {
                                      await actions.launchInBrowser(
                                        'https://www.facebook.com/people/Qolect/100068115511444/',
                                      );
                                    },
                                  ),
                                  _buildSocialIconMinimal(
                                    icon: Icons.tiktok_sharp,
                                    onTap: () async {
                                      await actions.launchInBrowser(
                                        'https://www.tiktok.com/@qolect',
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),

                              // Company logo and brand
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.asset(
                                        'assets/images/LOGO_3.png',
                                        width: 120.0,
                                        height: 80.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
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
      ),
    );
  }

  Widget _buildMinimalMenuItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        splashColor: Colors.white.withOpacity(0.1),
        highlightColor: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                            ),
                            color: Colors.white,
                            fontSize: 15.0,
                            letterSpacing: 0.3,
                          ),
                    ),
                    SizedBox(height: 1.0),
                    Text(
                      subtitle,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.roboto(),
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 12.0,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white.withOpacity(0.5),
                size: 14.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIconMinimal({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      splashColor: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(12.0),
      onTap: onTap,
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Icon(
          icon,
          color: Colors.white.withOpacity(0.9),
          size: 20.0,
        ),
      ),
    );
  }
}
