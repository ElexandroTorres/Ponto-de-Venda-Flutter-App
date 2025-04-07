import 'package:flutter/material.dart';
import 'package:pontodevenda/common/theme/app_colors.dart';
import 'package:pontodevenda/common/theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 18),
        textStyle: AppTextStyles.button,
      ),
      child: Text(text),
    );
  }
}
