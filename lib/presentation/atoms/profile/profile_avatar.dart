import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAvatar extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Color textColor;
  final String text;

  const ProfileAvatar({
    super.key,
    this.size = 40,
    this.backgroundColor = const Color(
      0xFF8B5A3C,
    ), // Default to Brown (Sidebar style)
    this.textColor = Colors.white,
    this.text = "K",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize:
                (size * 0.45).sp, // Responsive font size based on container
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
