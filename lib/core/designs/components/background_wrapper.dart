import 'package:flutter/material.dart';
import 'package:splittr/core/designs/color/app_colors.dart';

class BackgroundWrapper extends StatelessWidget {
  const BackgroundWrapper({
    required this.heightFactor,
    required this.child,
    super.key,
  });
  final double heightFactor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
          child: FractionallySizedBox(
            heightFactor: heightFactor,
            alignment: Alignment.topCenter,
            child: Container(color: AppColors.blueBgColor),
          ),
        ),
        child,
      ],
    );
  }
}
