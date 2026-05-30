import 'package:flutter/material.dart';
import 'package:splittr/core/designs/color/app_colors.dart';

class AppTransparentButton extends StatelessWidget {
  const AppTransparentButton({
    required this.text,
    required this.onTap,
    super.key,
  });
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: const TextStyle(color: AppColors.blackColor),
          ),
        ),
      ),
    );
  }
}
