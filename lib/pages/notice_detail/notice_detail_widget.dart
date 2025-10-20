import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoticeDetailPageWidget extends StatefulWidget {
  const NoticeDetailPageWidget({
    super.key,
    this.title,
    this.imageUrl,
    this.date,
    this.description,
  });

  static String routeName = 'notice_detail_page';
  static String routePath = '/notice-detail';

  final String? title;
  final String? imageUrl;
  final String? date;
  final String? description;

  @override
  State<NoticeDetailPageWidget> createState() => _NoticeDetailPageWidgetState();
}

class _NoticeDetailPageWidgetState extends State<NoticeDetailPageWidget> {
  @override
  Widget build(BuildContext context) {
    final titleText = valueOrDefault<String>(widget.title, 'Noticia');
    final dateRaw = widget.date;
    final dateFmt = (dateRaw != null && dateRaw.isNotEmpty)
        ? dateTimeFormat('yMMMd', DateTime.tryParse(dateRaw))
        : null;
    final imageUrl = widget.imageUrl ?? '';
    final descriptionText = valueOrDefault<String>(
      widget.description,
      'Sin contenido disponible.',
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: true,
            title: Text(
              'NOTICIA',
              style: FlutterFlowTheme.of(context).titleMedium.override(
                font: GoogleFonts.fredoka(
                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                ),
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
              ),
            ),
            centerTitle: true,
            elevation: 2.0,
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/20852675_6345959_1_(2).png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    16.0, 20.0, 16.0, 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Imagen principal con Hero para transición más fluida
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Hero(
                        tag: imageUrl.isNotEmpty
                            ? imageUrl
                            : 'notice_detail_image',
                        transitionOnUserGestures: true,
                        child: AspectRatio(
                          aspectRatio: 4 / 4,
                          child: imageUrl.isNotEmpty
                              ? Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/Group_2181_(1).png',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/images/Group_2181_(1).png',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Título completo (sin límite de líneas)
                    Text(
                      titleText,
                      softWrap: true,
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                font: GoogleFonts.fredoka(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                                color: Colors.black,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                    ),
                    const SizedBox(height: 10),
                    // Chip de fecha (opcional) con estilo sutil
                    if (dateFmt != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          dateFmt,
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                font: GoogleFonts.fredoka(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    // Contenedor del texto completo con fondo y bordes para legibilidad
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        descriptionText,
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.fredoka(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
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
}
