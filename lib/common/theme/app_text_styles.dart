import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.title,
  );

  static const TextStyle button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.buttonText,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.title,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.subtitle,
  );

  static const TextStyle error = TextStyle(
    fontSize: 14,
    color: AppColors.error,
  );
}

