import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'optimized_image_model.dart';
export 'optimized_image_model.dart';

class OptimizedImageWidget extends StatefulWidget {
  const OptimizedImageWidget({
    super.key,
    this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.borderRadius = 0.0,
    this.enableMemoryCache = true,
    this.enableDiskCache = true,
  });

  final String? imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final String? placeholder;
  final double borderRadius;
  final bool enableMemoryCache;
  final bool enableDiskCache;

  @override
  State<OptimizedImageWidget> createState() => _OptimizedImageWidgetState();
}

class _OptimizedImageWidgetState extends State<OptimizedImageWidget> {
  late OptimizedImageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OptimizedImageModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Si no hay URL de imagen, mostrar placeholder o asset por defecto
    if (widget.imageUrl == null || widget.imageUrl!.isEmpty) {
      return _buildPlaceholderWidget();
    }

    // Si es una imagen de assets local
    if (!widget.imageUrl!.startsWith('http')) {
      return _buildAssetImage();
    }

    // Imagen de red con caché optimizado
    return _buildNetworkImage();
  }

  Widget _buildPlaceholderWidget() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: widget.placeholder != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: Image.asset(
                widget.placeholder!,
                width: widget.width,
                height: widget.height,
                fit: widget.fit,
              ),
            )
          : Icon(
              Icons.image_outlined,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: widget.width * 0.3,
            ),
    );
  }

  Widget _buildAssetImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Image.asset(
        widget.imageUrl!,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      ),
    );
  }

  Widget _buildNetworkImage() {
    final dpr = MediaQuery.of(context).devicePixelRatio;
    final cacheW = (widget.width * dpr).round();
    final cacheH = (widget.height * dpr).round();

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: CachedNetworkImage(
        imageUrl: widget.imageUrl!,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        placeholder: (context, url) => _buildLoadingWidget(),
        errorWidget: (context, url, error) => _buildErrorWidget(),
        memCacheWidth: widget.enableMemoryCache ? cacheW : null,
        memCacheHeight: widget.enableMemoryCache ? cacheH : null,
        cacheManager: widget.enableDiskCache ? null : null,
        imageBuilder: (context, imageProvider) => Image(
          image: imageProvider,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          filterQuality: FilterQuality.high,
        ),
        fadeInDuration: const Duration(milliseconds: 300),
        fadeOutDuration: const Duration(milliseconds: 100),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Center(
        child: SizedBox(
          width: 24.0,
          height: 24.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              FlutterFlowTheme.of(context).primary,
            ),
            strokeWidth: 2.0,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: FlutterFlowTheme.of(context).error.withOpacity(0.3),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_outlined,
            color: FlutterFlowTheme.of(context).error,
            size: widget.width * 0.2,
          ),
          if (widget.height > 60)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'Error al cargar',
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      color: FlutterFlowTheme.of(context).error,
                      fontSize: 10.0,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
