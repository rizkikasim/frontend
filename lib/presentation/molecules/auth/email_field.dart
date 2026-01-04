import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomEmailField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomEmailField({
    super.key,
    required this.controller,
    this.hintText = "Email",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(color: Colors.white),
        cursorColor: AppColors.primary,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email tidak boleh kosong';
          }
          final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
          ).hasMatch(value);

          if (!emailValid) {
            return 'Masukkan format email yang valid';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: const Icon(Icons.email_outlined, color: Colors.white70),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          isDense: true,
          errorStyle: const TextStyle(color: Colors.redAccent),
        ),
      ),
    );
  }
}
