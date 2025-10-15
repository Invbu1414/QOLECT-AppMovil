import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:ui' show ImageFilter;
import 'on_boarding1_page_model.dart';
export 'on_boarding1_page_model.dart';

class OnBoarding1PageWidget extends StatefulWidget {
  const OnBoarding1PageWidget({super.key});

  static String routeName = 'onBoarding1_page';
  static String routePath = '/onBoarding1page';

  @override
  State<OnBoarding1PageWidget> createState() => _OnBoarding1PageWidgetState();
}

class _OnBoarding1PageWidgetState extends State<OnBoarding1PageWidget> {
  late OnBoarding1PageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Transición personalizada: fade + scale
  PageRouteBuilder _fadeScaleRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 600),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.98, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnBoarding1PageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(
        Duration(
          milliseconds: 2000,
        ),
      );
      if (FFAppState().token != '') {
        if (Navigator.of(context).canPop()) {
          context.pop();
        }
        // Transición fade hacia Home usando FlutterFlow
        context.pushNamed(
          HomePageWidget.routeName,
          extra: {
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 600),
            ),
          },
        );
        return;
      } else {
        if (Navigator.of(context).canPop()) {
          context.pop();
        }
        // Transición fade hacia Login usando FlutterFlow
        context.pushNamed(
          LoginPageWidget.routeName,
          extra: {
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 600),
            ),
          },
        );
        return;
      }
    });
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
        body: Stack(
          children: [
            // Overlay sutil para mejorar legibilidad del texto
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).primary,
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 28.0, 24.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Encuentra tu siguiente aventura',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .titleLarge
                              .override(
                                fontSize: 32.0,
                                fontWeight: FontWeight.w800,
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Despierta al viajero consciente',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                fontSize: 14.0,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryText,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Image.asset(
                'assets/images/LOGO_3.png',
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
            // Imagen inferior: ancho completo, altura proporcional de la imagen
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/onboarding_background2.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
