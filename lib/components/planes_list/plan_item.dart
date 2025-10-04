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
    final hasImage = getJsonField(plan, r'''$.plan_has_image''') == true;
    final ratingRaw = getJsonField(plan, r'''$.plan_rating''');
    final rating = _parseRating((ratingRaw ?? '5.0').toString());
    final bannerWidth = MediaQuery.of(context).size.width - 30.0;
    final bannerAspect = 16 / 9;
    final bannerHeight = bannerWidth / bannerAspect;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15.0, 16.0, 15.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10.0,
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Stack(
                children: [
                  AspectRatio(aspectRatio: bannerAspect,
                  child: SizedBox(
                    width: double.infinity,
                    height: 160.0,
                    child: hasImage
                        ? OptimizedImageWidget(
                            imageUrl: getJsonField(plan, r'''$.plan_image''').toString(),
                            width: bannerWidth,
                            height: bannerHeight,
                            fit: BoxFit.fill,//Boxfit.contain
                            borderRadius: 0.0,
                            enableMemoryCache: true,
                            enableDiskCache: true,
                          )
                        : Container(
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                  ),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getJsonField(plan, r'''$.plan_title''').toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          font: GoogleFonts.fredoka(
                            fontWeight: FontWeight.w600,
                          ),
                          color: Colors.black,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6.0),
                        child: Text(
                          valueOrDefault<String>(
                            (ratingRaw ?? '4.5').toString(),
                            '4.5',
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.fredoka(
                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                ),
                                color: Colors.black,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      RatingBarIndicator(
                        itemBuilder: (context, index) => Icon(
                          Icons.star_rounded,
                          color: FlutterFlowTheme.of(context).warning,
                        ),
                        direction: Axis.horizontal,
                        rating: rating,
                        unratedColor: Colors.white24,
                        itemCount: 5,
                        itemSize: 14.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.center,
                    child: FFButtonWidget(
                      onPressed: () async {
                        context.pushNamed(
                          WebViewPlanWidget.routeName,
                          queryParameters: {
                            'url': serializeParam(
                              '${getJsonField(plan, r'''$.plan_url''').toString()}/?nocache',
                              ParamType.String,
                            ),
                          }.withoutNulls,
                        );
                      },
                      text: 'Ver más',
                      options: FFButtonOptions(
                        height: 40.0,
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              font: GoogleFonts.fredoka(
                                fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                              ),
                              color: Colors.white,
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                            ),
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _parseRating(String value) {
    try {
      return double.parse(value);
    } catch (_) {
      return 0.0;
    }
  }
}