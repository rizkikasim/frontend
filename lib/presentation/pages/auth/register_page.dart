import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mqfm_apps/presentation/atoms/auth/register_button.dart';
import 'package:mqfm_apps/presentation/atoms/auth/register_title.dart';
import 'package:mqfm_apps/presentation/logic/auth/register_logic.dart';
import 'package:mqfm_apps/presentation/organisms/auth/register_form_section.dart';
import 'package:mqfm_apps/utils/helpers/message_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterLogic logic = RegisterLogic();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    logic.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await logic.register(
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      if (logic.successMessage != null) {
        MessageHelper.showSuccess(context, logic.successMessage!);
      }
      context.go('/login-form');
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
                const RegisterTitle(),
                SizedBox(height: 40.h),
                RegisterFormSection(
                  usernameController: _usernameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                SizedBox(height: 60.h),
                ListenableBuilder(
                  listenable: logic,
                  builder: (context, child) {
                    return RegisterButton(
                      isLoading: logic.isLoading,
                      onPressed: logic.isLoading ? null : _handleRegister,
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
