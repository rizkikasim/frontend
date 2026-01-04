import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/presentation/molecules/auth/email_field.dart';
import 'package:mqfm_apps/presentation/molecules/auth/password_field.dart';

class LoginFormSection extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormSection({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10.h),
        CustomEmailField(controller: emailController),
        SizedBox(height: 20.h),
        Text(
          "Password",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10.h),
        CustomPasswordField(controller: passwordController),
        SizedBox(height: 8.h),
        Text(
          "Pastikan email dan password anda benar.",
          style: TextStyle(color: Colors.grey, fontSize: 10.sp),
        ),
      ],
    );
  }
}
