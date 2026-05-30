import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage({required this.path, super.key});
  final String path;

  @override
  Widget build(BuildContext context) {
    return Image.asset(path);
  }
}
