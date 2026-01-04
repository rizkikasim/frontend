import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:mqfm_apps/utils/app_dims.dart';
import 'package:mqfm_apps/utils/app_styles.dart';
import 'package:mqfm_apps/utils/app_strings.dart';
import 'package:mqfm_apps/presentation/atoms/common/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDims.w24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/img_splash.png',
                width: 250.w, // Increased size
                fit: BoxFit.contain,
              ),

              SizedBox(height: AppDims.h48),

              Text(
                AppStrings.onboardingTagline1,
                style: AppStyles.titleMedium.copyWith(
                  color: AppColors.textWhite,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                AppStrings.onboardingTagline2,
                style: AppStyles.titleMedium.copyWith(
                  color: AppColors.textWhite,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              CustomButton(
                text: AppStrings.btnDaftar,
                onPressed: () {
                  context.push('/register');
                },
                backgroundColor: AppColors.primary,
                textColor: AppColors.backgroundBlack,
              ),

              SizedBox(height: AppDims.h16),

              CustomButton(
                text: AppStrings.btnLoginMQFM,
                onPressed: () {
                  context.push('/login-form');
                },
                backgroundColor: Colors.transparent,
                textColor: AppColors.textWhite,
                borderColor: AppColors.textSecondary,
              ),

              SizedBox(height: AppDims.h40),
            ],
          ),
        ),
      ),
    );
  }
}
