import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomPasswordField({
    super.key,
    required this.controller,
    this.hintText = "Password",
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        style: const TextStyle(color: Colors.white),
        cursorColor: AppColors.primary,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password tidak boleh kosong';
          }
          if (value.length < 6) {
            return 'Password minimal 6 karakter';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Colors.white54,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
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
