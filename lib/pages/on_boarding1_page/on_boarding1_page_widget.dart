import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnBoarding1PageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 2000));

      if (FFAppState().token != '') {
        context.goNamed(
          HomePageWidget.routeName,
          extra: {
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: const Duration(milliseconds: 600),
            ),
          },
        );
        return;
      } else {
        context.goNamed(
          LoginPageWidget.routeName,
          extra: {
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: const Duration(milliseconds: 600),
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

    return PopScope(
      canPop: false, // canPop: false
      child: GestureDetector(
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final maxWidth = constraints.maxWidth == double.infinity
                        ? MediaQuery.sizeOf(context).width
                        : constraints.maxWidth;

                    const aspectRatio = 3.5;
                    final width = maxWidth * 0.8;
                    final height = width / aspectRatio;

                    return SizedBox(
                      width: width,
                      height: height,
                      child: Image.asset(
                        'assets/images/Logo.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    );
                  },
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
      ),
    );
  }
}
