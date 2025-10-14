import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/pages/viaje_page/viaje_page_widget.dart';
import 'viaje_content.dart';

class ViajeItem extends StatelessWidget {
  const ViajeItem({
    super.key,
    required this.viajesListItem,
    required this.index,
  });

  final dynamic viajesListItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('viaje_$index'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction > 0.5) {
          // Precargar datos si es necesario
        }
      },
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          context.pushNamed(
            ViajePageWidget.routeName,
            queryParameters: {
              'info': serializeParam(
                getJsonField(viajesListItem, r'''$'''),
                ParamType.JSON,
              ),
            }.withoutNulls,
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ViajeContent(
                  viajesListItem: viajesListItem,
                  index: index,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
