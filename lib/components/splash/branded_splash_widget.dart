import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';

class BrandedSplashWidget extends StatefulWidget {
  const BrandedSplashWidget({super.key});

  @override
  State<BrandedSplashWidget> createState() => _BrandedSplashWidgetState();
}

class _BrandedSplashWidgetState extends State<BrandedSplashWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200)).then((_) {
      if (!mounted) return;
      context.goNamed(
        OnBoarding1PageWidget.routeName,
        extra: {
          kTransitionInfoKey: TransitionInfo(
            hasTransition: true,
            transitionType: PageTransitionType.fade,
            duration: const Duration(milliseconds: 600),
          ),
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      backgroundColor: theme.primary,
      body: Stack(
        children: [
          // Fondo degradado con color de marca
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.primary,
                  theme.alternate,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Contenido centrado con animación suave
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.98 + (value * 0.02),
                    child: child,
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'assets/images/LOGO_3.png',
                      width: 220.0,
                      height: 62.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.secondaryBackground,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
