import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mqfm_apps/presentation/atoms/auth/login_button.dart';
import 'package:mqfm_apps/presentation/atoms/auth/login_title.dart';
import 'package:mqfm_apps/presentation/logic/auth/login_logic.dart';
import 'package:mqfm_apps/presentation/organisms/auth/login_form_section.dart';
import 'package:mqfm_apps/utils/helpers/message_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginLogic logic = LoginLogic();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    logic.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await logic.login(
      _emailController.text,
      _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      if (logic.successMessage != null) {
        MessageHelper.showSuccess(context, logic.successMessage!);
      }
      context.go('/dashboard');
    } else {
      if (logic.errorMessage != null) {
        MessageHelper.showError(context, logic.errorMessage!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                const LoginTitle(),
                SizedBox(height: 40.h),
                LoginFormSection(
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                SizedBox(height: 60.h),
                ListenableBuilder(
                  listenable: logic,
                  builder: (context, child) {
                    return LoginButton(
                      isLoading: logic.isLoading,
                      onPressed: logic.isLoading ? null : _handleLogin,
                    );
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
