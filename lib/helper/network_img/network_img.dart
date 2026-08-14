import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../Utils/AppColors/app_colors.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) => Container(
        height: height,
        width: width,
        color: AppColors.border,
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2.0),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        color: AppColors.border,
        child: const Icon(Icons.error_outline, color: AppColors.errorColor),
      ),
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
