import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:google_fonts/google_fonts.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class MainSliverAppBar extends StatelessWidget {
  const MainSliverAppBar({
    super.key,
    required this.title,
    required this.onMenuTap,
    required this.onCartTap,
    required this.notificationsCount,
    required this.cartCount,
    this.titleWidget,
    this.leadingIcon,
    this.onLeadingTap,
  });

  final String title;
  final VoidCallback onMenuTap;
  final VoidCallback onCartTap;
  final int notificationsCount;
  final int cartCount;
  final Widget? titleWidget;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingTap;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 90.0,
      pinned: true,
      floating: true,
      snap: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  FlutterFlowTheme.of(context).primaryDark,
                  FlutterFlowTheme.of(context).primaryAccent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
      leading: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onLeadingTap ?? onMenuTap,
        child: Icon(
          leadingIcon ?? Icons.menu_rounded,
          color: FlutterFlowTheme.of(context).secondaryBackground,
          size: 30.0,
        ),
      ),
      title: titleWidget ??
          Text(
            title,
            style: FlutterFlowTheme.of(context).titleMedium.override(
              font: GoogleFonts.fredoka(
                fontWeight: FontWeight.w600,
                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
              ),
              fontSize: 24.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
            ),
          ),
      actions: [
        // Carrito
        Align(
          alignment: const AlignmentDirectional(-1.0, 0.0),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 16.0),
            child: badges.Badge(
              badgeContent: Text(
                cartCount.toString(),
                style: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.fredoka(),
                      color: Colors.white,
                      fontSize: 10.0,
                      letterSpacing: 0.0,
                    ),
              ),
              showBadge: true,
              shape: badges.BadgeShape.circle,
              badgeColor: cartCount > 0 ? FlutterFlowTheme.of(context).error : FlutterFlowTheme.of(context).primaryDark,
              elevation: 0.0,
              padding: const EdgeInsets.all(4.0),
              position: badges.BadgePosition.topEnd(top: -8, end: -6),
              animationType: badges.BadgeAnimationType.scale,
              toAnimate: false,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: onCartTap,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  size: 26.0,
                ),
              ),
            ),
          ),
        ),
      ],
      centerTitle: true,
      toolbarHeight: 90.0,
    );
  }
}
