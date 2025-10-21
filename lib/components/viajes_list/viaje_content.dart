import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '/components/optimized_image/optimized_image_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ViajeContent extends StatelessWidget {
  const ViajeContent({
    super.key,
    required this.viajesListItem,
    required this.index,
  });

  final dynamic viajesListItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentDirectional(-1.0, -1.0),
            child: AspectRatio(aspectRatio: 4 / 4,
                  child: SizedBox(
                    width: double.infinity,
                    height: 160.0,
                    child: OptimizedImageWidget(
                        imageUrl: getJsonField(
                              viajesListItem,
                              r'''$.acf.imagen_para_card''',
                            )?.toString() ??
                            getJsonField(
                              viajesListItem,
                              r'''$.acf.imagen_para_card_copiar''',
                            )?.toString(),
                        width: MediaQuery.of(context).size.width - 32.0,
                        height: 200.0,
                        fit: BoxFit.fill,
                        borderRadius: 12.0,
                      )
                    ),
                  )
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  valueOrDefault<String>(
                    getJsonField(viajesListItem, r'''$.title.rendered''')
                        ?.toString(),
                    'Sin nombre',
                  ),
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        font: GoogleFonts.fredoka(
                          fontWeight: FontWeight.w600,
                        ),
                        color: Colors.black,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 8.0),
                if (getJsonField(viajesListItem, r'''$.acf.destino''') != null)
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 16.0,
                      ),
                      SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          getJsonField(viajesListItem, r'''$.acf.destino''')
                                  ?.toString() ??
                              '',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.fredoka(),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 8.0),
                if (_buildDateRange(viajesListItem).isNotEmpty)
                  Text(
                    _buildDateRange(viajesListItem),
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          font: GoogleFonts.fredoka(),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                        ),
                  ),
                SizedBox(height: 12.0),
                if (getJsonField(viajesListItem, r'''$.acf.descripcion''') !=
                    null)
                  Text(
                    getJsonField(viajesListItem, r'''$.acf.descripcion''')
                            ?.toString() ??
                        '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.fredoka(),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          lineHeight: 1.4,
                        ),
                  ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (getJsonField(
                            viajesListItem, r'''$.acf.calificacion''') !=
                        null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              getJsonField(viajesListItem,
                                          r'''$.acf.calificacion''')
                                      ?.toString() ??
                                  '0.0',
                              '0.0',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.fredoka(),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(width: 4.0),
                          RatingBarIndicator(
                            itemBuilder: (context, index) => Icon(
                                Icons.star_rounded,
                                color: FlutterFlowTheme.of(context).warning),
                            direction: Axis.horizontal,
                            rating: _parseRating(getJsonField(viajesListItem,
                                        r'''$.acf.calificacion''')
                                    ?.toString() ??
                                '0.0'),
                            unratedColor: FlutterFlowTheme.of(context)
                                .accent1
                                .withOpacity(0.3),
                            itemCount: 5,
                            itemSize: 16.0,
                          ),
                        ],
                      ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.place,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 14.0,
                          ),
                          SizedBox(width: 2.0),
                          Flexible(
                            child: Text(
                              getJsonField(viajesListItem,
                                          r'''$.acf.direccion_detallada''')
                                      ?.toString() ??
                                  '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    font: GoogleFonts.fredoka(),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildDateRange(dynamic item) {
    final fechaSalida =
        getJsonField(item, r'''$.acf.fecha_de_salida''')?.toString() ?? '';
    final fechaLlegada =
        getJsonField(item, r'''$.acf.fecha_de_llegada''')?.toString() ?? '';

    if (fechaSalida.isNotEmpty && fechaLlegada.isNotEmpty) {
      return '$fechaSalida - $fechaLlegada';
    } else if (fechaSalida.isNotEmpty) {
      return 'Desde: $fechaSalida';
    } else if (fechaLlegada.isNotEmpty) {
      return 'Hasta: $fechaLlegada';
    }
    return '';
  }

  double _parseRating(String value) {
    try {
      return double.parse(value);
    } catch (_) {
      return 0.0;
    }
  }
}
