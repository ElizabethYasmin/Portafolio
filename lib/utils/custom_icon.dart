import 'package:flutter/material.dart';
import 'package:portafolio_yasmin/utils/load_image.dart';

class CustomIcon extends StatelessWidget {
  final String path;
  final String ext;
  final double size;

  const CustomIcon({
    super.key,
    required this.path,
    required this.ext,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return LoadImage(
      path: path,
      ext: ext,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
