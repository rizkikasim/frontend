import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_dims.dart';

class AppStyles {
  static TextStyle get displayLarge => GoogleFonts.poppins(
    fontSize: AppDims.sp32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get titleLarge => GoogleFonts.poppins(
    fontSize: AppDims.sp24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get titleMedium => GoogleFonts.poppins(
    fontSize: AppDims.sp20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyLarge =>
      GoogleFonts.poppins(fontSize: AppDims.sp16, color: AppColors.textPrimary);

  static TextStyle get bodyMedium => GoogleFonts.poppins(
    fontSize: AppDims.sp14,
    color: AppColors.textSecondary,
  );

  static TextStyle get bodySmall => GoogleFonts.poppins(
    fontSize: AppDims.sp12,
    color: AppColors.textSecondary,
  );

  static TextStyle get buttonText => GoogleFonts.poppins(
    fontSize: AppDims.sp16,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
  );

  static TextStyle get inputHint => GoogleFonts.poppins(
    fontSize: AppDims.sp14,
    color: AppColors.textSecondary.withOpacity(0.6),
  );

  static TextStyle get linkText => GoogleFonts.poppins(
    fontSize: AppDims.sp14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );
}
