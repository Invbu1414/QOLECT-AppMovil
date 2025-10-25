import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
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
  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    
    return Opacity(
      opacity: 1.0,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.95,
        child: Drawer(
          elevation: 12.0,
          child: WebViewAware(
            child: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Header banner con degradado y sombra sutil
                    Container(
                      margin: EdgeInsets.all(16.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            FlutterFlowTheme.of(context).primaryDark.withValues(alpha: 0.95),
                            FlutterFlowTheme.of(context).secondary.withValues(alpha: 0.95),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 16.0,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              'assets/images/10_1.png',
                              width: 64.0,
                              height: 64.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 14.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'QOLECT',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        font: GoogleFonts.fredoka(
                                          fontWeight: FontWeight.w700,
                                        ),
                                        color: FlutterFlowTheme.of(context).info,
                                      ),
                                ),
                                Text(
                                  'Tu próxima aventura',
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.roboto(),
                                        color: FlutterFlowTheme.of(context).accent4,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(24.0),
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 44.0,
                              height: 44.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).info.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).info.withValues(alpha: 0.25),
                                  width: 1.25,
                                ),
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                color: FlutterFlowTheme.of(context).info,
                                size: 22.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Título de sección
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Container(
                            width: 6.0,
                            height: 26.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary,
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Text(
                            'Menú Principal',
                            style: FlutterFlowTheme.of(context).titleLarge.override(
                                  font: GoogleFonts.roboto(fontWeight: FontWeight.w600),
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.0),

                    // Contenido principal
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
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
                              title: 'Experiencias',
                              subtitle: 'Descubre',
                              icon: Icons.home_outlined,
                              onTap: () async {
                                context.pushNamed(HomePageWidget.routeName);
                              },
                            ),
                            _buildMinimalMenuItem(
                              context: context,
                              title: 'Mis Viajes',
                              subtitle: 'Ver mis reservas',
                              icon: Icons.travel_explore_outlined,
                              onTap: () async {

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
                              title: 'Notificaciones',
                              subtitle: 'Avisos y alertas',
                              icon: Icons.notifications_outlined,
                              badgeCount: FFAppState().notificationsAmount,
                              onTap: () async {
                                context.pushNamed(NotificationsPageWidget.routeName);
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
                            SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ),

                    // Footer simple con redes
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Divider(
                            color: FlutterFlowTheme.of(context)
                                .alternate
                                .withValues(alpha: 0.5),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildSocialIconMinimal(
                                context: context,
                                icon: FontAwesomeIcons.whatsapp,
                                onTap: () async {
                                  await actions.launchInBrowser(
                                    'https://api.whatsapp.com/send?phone=+573018119374&text=Hola%2C%20quiero%20armar%20mi%20plan%20de%20vacaciones%20%F0%9F%9B%AB.%0AViajo%20desde%20(Ingresa%20lugar%20de%20salida)%2C%20hac%C3%ADa%20(Ingresa%20lugar%20de%20destino)%20%F0%9F%98%8E',
                                  );
                                },
                              ),
                              _buildSocialIconMinimal(
                                context: context,
                                icon: FontAwesomeIcons.instagram,
                                onTap: () async {
                                  await actions.launchInBrowser('https://www.instagram.com/qolect/');
                                },
                              ),
                              _buildSocialIconMinimal(
                                context: context,
                                icon: FontAwesomeIcons.facebookF,
                                onTap: () async {
                                  await actions.launchInBrowser(
                                      'https://www.facebook.com/people/Qolect/100068115511444/');
                                },
                              ),
                              _buildSocialIconMinimal(
                                context: context,
                                icon: FontAwesomeIcons.tiktok,
                                onTap: () async {
                                  await actions.launchInBrowser('https://www.tiktok.com/@qolect');
                                },
                              ),
                            ],
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
      ),
    );
  }

  
  Widget _buildMinimalMenuItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    int? badgeCount,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16.0),
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          splashColor: FlutterFlowTheme.of(context).primary.withValues(alpha: 0.1),
          highlightColor: FlutterFlowTheme.of(context).primary.withValues(alpha: 0.06),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: FlutterFlowTheme.of(context).alternate.withValues(alpha: 0.5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              children: [
                Container(
                  width: 46.0,
                  height: 46.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(
                    icon,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 22.0,
                  ),
                ),
                SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: FlutterFlowTheme.of(context).titleMedium.override(
                              font: GoogleFonts.fredoka(fontWeight: FontWeight.w600),
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        subtitle,
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.roboto(),
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                      ),
                    ],
                  ),
                ),
                if (badgeCount != null && badgeCount >= 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primary,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      badgeCount.toString(),
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                        font: GoogleFonts.fredoka(),
                        color: Colors.white,
                      ),
                    ),
                  ),
                SizedBox(width: 8.0),
                Icon(
                  Icons.chevron_right_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIconMinimal({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      splashColor: FlutterFlowTheme.of(context).primary.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(12.0),
      onTap: onTap,
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primary.withValues(alpha: 0.08),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate.withValues(alpha: 0.6),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Icon(
          icon,
          color: FlutterFlowTheme.of(context).primaryDark,
          size: 20.0,
        ),
      ),
    );
  }
}
