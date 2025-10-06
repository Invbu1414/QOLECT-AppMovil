import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/pages/rating_page/rating_page_widget.dart';

class ViajeBottomBar extends StatelessWidget {
  const ViajeBottomBar({
    super.key,
    required this.visible,
    required this.info,
  });

  final bool visible;
  final dynamic info;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: visible ? Offset.zero : const Offset(0, 1),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      child: BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (context) {
          return SafeArea(
            top: false,
            child: Container(
              width: double.infinity,
              height: visible ? 100.0 : 0.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: Color(0x33000000),
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Califica nuestro servicio',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.fredoka(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primary,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 5.0, 0.0, 5.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(
                              RatingPageWidget.routeName,
                              queryParameters: {
                                'id': serializeParam(
                                  getJsonField(
                                    info,
                                    r'''$.id''',
                                  ),
                                  ParamType.int,
                                ),
                              }.withoutNulls,
                            );
                          },
                          child: RatingBarIndicator(
                            itemBuilder: (context, index) => Icon(
                              Icons.star_rounded,
                              color: FlutterFlowTheme.of(context).warning,
                            ),
                            direction: Axis.horizontal,
                            rating: valueOrDefault<double>(
                              double.parse(
                                valueOrDefault<String>(
                                  getJsonField(
                                    info,
                                    r'''$.acf.calificacion''',
                                  )?.toString(),
                                  '0',
                                ),
                              ),
                              0.0,
                            ),
                            unratedColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            itemCount: 5,
                            itemSize: 25.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      await actions.launchInBrowser(
                        'https://api.whatsapp.com/send?phone=573245104231&text=Hola%2C%20quiero%20armar%20mi%20plan%20de%20vacaciones%20%F0%9F%9B%AB.%0AViajo%20desde%20(Ingresa%20lugar%20de%20salida)%2C%20hac%C3%ADa%20(Ingresa%20lugar%20de%20destino)%20%F0%9F%98%8E',
                      );
                    },
                    text: 'Contacto',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 0.0, 24.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).warning,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.fredoka(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      elevation: 3.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
