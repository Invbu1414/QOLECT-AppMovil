import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanItem extends StatelessWidget {
  final dynamic plan;

  const PlanItem({
    super.key,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = getJsonField(plan, r'''$.plan_has_image''');

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(-1.0, -1.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/Group_2181_(1).png',
                    width: 104.0,
                    height: 56.0,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment(-1.0, -1.0),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment:
                                AlignmentDirectional(
                                    0.0,
                                    0.0),
                            child:
                                Padding(
                              padding: EdgeInsetsDirectional
                                  .fromSTEB(
                                      0.0,
                                      0.0,
                                      0.0,
                                      10.0),
                              child: Text(
                                getJsonField(
                                  plan,
                                  r'''$.plan_title''',
                                ).toString(),
                                style: FlutterFlowTheme.of(
                                        context)
                                    .bodyMedium
                                    .override(
                                      font:
                                          GoogleFonts.fredoka(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                      ),
                                      color:
                                          Colors.black,
                                      letterSpacing:
                                          0.0,
                                      fontWeight:
                                          FontWeight.w600,
                                      fontStyle:
                                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                    ),
                              ),
                            ),
                          ),
                          Align(
                            alignment:
                                AlignmentDirectional(
                                    0.0,
                                    0.0),
                            child:
                                Padding(
                              padding: EdgeInsetsDirectional
                                  .fromSTEB(
                                      0.0,
                                      0.0,
                                      0.0,
                                      15.0),
                              child: Row(
                                mainAxisSize:
                                    MainAxisSize
                                        .max,
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        0.0,
                                        5.0,
                                        0.0),
                                    child:
                                        Text(
                                      '4,5 ',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            font: GoogleFonts.fredoka(
                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                            ),
                                            color: Colors.black,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                          ),
                                    ),
                                  ),
                                  RatingBarIndicator(
                                    itemBuilder: (context, index) =>
                                        Icon(
                                      Icons.star_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).warning,
                                    ),
                                    direction:
                                        Axis.horizontal,
                                    rating:
                                        5.0,
                                    unratedColor:
                                        FlutterFlowTheme.of(context).secondaryText,
                                    itemCount:
                                        5,
                                    itemSize:
                                        13.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize:
                                MainAxisSize
                                    .max,
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                            children: [
                              FFButtonWidget(
                                onPressed:
                                    () async {
                                  context
                                      .pushNamed(
                                    WebViewPlanWidget
                                        .routeName,
                                    queryParameters:
                                        {
                                      'url':
                                          serializeParam(
                                        '${getJsonField(
                                          plan,
                                          r'''$.plan_url''',
                                        ).toString()}/?nocache',
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                text:
                                    'Ver más',
                                options:
                                    FFButtonOptions(
                                  height:
                                      40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0,
                                      0.0,
                                      16.0,
                                      0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0),
                                  color: FlutterFlowTheme.of(context)
                                      .primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.fredoka(
                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                        ),
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                      ),
                                  elevation:
                                      0.0,
                                  borderRadius:
                                      BorderRadius.circular(8.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (hasImage == true)
                    Flexible(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                        child: OptimizedImageWidget(
                          imageUrl:
                              getJsonField(plan, r'''$.plan_image''').toString(),
                          width: 120.0,
                          height: 120.0,
                          fit: BoxFit.cover,
                          borderRadius: 20.0,
                          enableMemoryCache: true,
                          enableDiskCache: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}