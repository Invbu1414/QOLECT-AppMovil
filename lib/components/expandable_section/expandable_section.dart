import 'package:flutter/material.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:google_fonts/google_fonts.dart';
import '../noresults/noresults_widget.dart';

class ExpandableSection extends StatelessWidget {
  final dynamic info;
  final bool expanded;
  final VoidCallback onToggle;

  final String title;
  final IconData leadingIcon;

  // Rutas JSON para listar e item fields
  final String listJsonPath;
  final String itemTitleJsonPath;
  final String? itemUrlJsonPath;
  final String? itemAvailabilityJsonPath;

  // Personalización opcional del ícono en cada fila
  final IconData rowTrailingIcon;

  const ExpandableSection({
    super.key,
    required this.info,
    required this.expanded,
    required this.onToggle,
    required this.title,
    required this.leadingIcon,
    required this.listJsonPath,
    required this.itemTitleJsonPath,
    this.itemUrlJsonPath,
    this.itemAvailabilityJsonPath,
    this.rowTrailingIcon = Icons.find_in_page_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            width: double.infinity,
            height: 52.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10.0,
                  color: Color(0x1F000000),
                  offset: Offset(0.0, 6.0),
                ),
              ],
              border: Border.all(
                color: expanded
                    ? FlutterFlowTheme.of(context)
                        .primary
                        .withOpacity(0.25)
                    : Colors.transparent,
                width: 1.0,
              ),
            ),
            child: InkWell(
              splashColor:
                  FlutterFlowTheme.of(context).primary.withOpacity(0.08),
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: onToggle,
              child: Material(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16.0),
                  leading: Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .primary
                          .withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      leadingIcon,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 20.0,
                    ),
                  ),
                  title: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          font: GoogleFonts.fredoka(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                          ),
                          color: Colors.black,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .fontStyle,
                        ),
                  ),
                  trailing: AnimatedRotation(
                    turns: expanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                  ),
                  tileColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  dense: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 20.0, 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8.0,
                      color: Color(0x13000000),
                      offset: Offset(0.0, 4.0),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Builder(
                      builder: (context) {
                        final list = getJsonField(
                          info,
                          listJsonPath,
                        ).toList();

                        if (list.isEmpty) {
                          return const NoresultsWidget();
                        }

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            final item = list[index];

                            final String label = getJsonField(
                              item,
                              itemTitleJsonPath,
                            ).toString();

                            final dynamic availabilityValue =
                                itemAvailabilityJsonPath != null
                                    ? getJsonField(
                                        item, itemAvailabilityJsonPath!)
                                    : null;

                            final bool? isAvailable =
                                availabilityValue is bool
                                    ? availabilityValue
                                    : availabilityValue == null
                                        ? null
                                        : availabilityValue != false;

                            final dynamic urlValue = itemUrlJsonPath != null
                                ? getJsonField(item, itemUrlJsonPath!)
                                : null;

                            return Column(
                              children: [
                                ListTile(
                                  contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                  onTap: () async {
                                    if (itemUrlJsonPath == null) return;
                                    if (urlValue == false) return;
                                    await launchURL(urlValue.toString());
                                  },
                                  leading: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: isAvailable == false
                                          ? Colors.transparent
                                          : FlutterFlowTheme.of(context)
                                              .warning,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 4.0,
                                          color: Color(0x33000000),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.edit_document,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      size: 22.0,
                                    ),
                                  ),
                                  title: Text(
                                    label.maybeHandleOverflow(
                                      maxChars: 22,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.fredoka(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: isAvailable == false
                                              ? FlutterFlowTheme.of(context)
                                                  .alternate
                                              : FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          fontSize: 13.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        rowTrailingIcon,
                                        color: isAvailable == false
                                            ? FlutterFlowTheme.of(context)
                                                .alternate
                                            : FlutterFlowTheme.of(context)
                                                .primaryText,
                                        size: 22.0,
                                      ),
                                      if (isAvailable != null &&
                                          isAvailable == false)
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 0.0, 0.0),
                                          child: Icon(
                                            Icons
                                                .check_box_outline_blank,
                                            color:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            size: 22.0,
                                          ),
                                        ),
                                      if (isAvailable != null &&
                                          isAvailable != false)
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 0.0, 0.0),
                                          child: Icon(
                                            Icons.check_box_sharp,
                                            color:
                                                FlutterFlowTheme.of(context)
                                                    .success,
                                            size: 22.0,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: FlutterFlowTheme.of(context)
                                      .alternate
                                      .withOpacity(0.2),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          crossFadeState: expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 220),
          sizeCurve: Curves.easeOut,
        ),
      ],
    );
  }
}
