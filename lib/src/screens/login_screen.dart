import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_quiz/src/constants/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:online_quiz/src/constants/services/api_caller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedLogin();
  }

  Future<void> _loadSavedLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '';
    setState(() {
      _usernameController.text = username;
      _rememberMe = username.isNotEmpty;
    });
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        "id": _usernameController.text.trim(),
        "passWord": _passwordController.text,
      };

      try {
        final res = await APICaller().post("api/user/login", body: data);

        // Kiểm tra response từ API
        if (res != null && res['id'] != null) {
          // Lưu thông tin đăng nhập bất kể "Nhớ tài khoản" có được chọn hay không
          await SharedPreferencesHelper.saveLoginInfo(
            _usernameController.text.trim(),
            _passwordController.text,
            res, // Dữ liệu người dùng trả về từ API
          );

          if (!mounted) return;

          // Chuyển hướng đến trang Dashboard và gửi dữ liệu người dùng
          context.go('/dashboard', extra: res);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Đăng nhập thành công!")),
          );
        } else {
          if (!mounted) return;

          // Hiển thị thông báo lỗi nếu API trả về lỗi
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(res?['error'] ?? "Sai tài khoản hoặc mật khẩu!"),
            ),
          );
        }
      } catch (e) {
        if (!mounted) return;

        // Xử lý lỗi khi có lỗi kết nối hoặc lỗi từ API
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Lỗi đăng nhập: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 650),
            padding: const EdgeInsets.all(8),
            child: Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child:
                  isMobile
                      ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          children: [
                            _WelcomePanel(fullWidth: true),
                            const SizedBox(height: 12),
                            _LoginForm(
                              formKey: _formKey,
                              usernameController: _usernameController,
                              passwordController: _passwordController,
                              rememberMe: _rememberMe,
                              onRememberChanged:
                                  (val) => setState(() => _rememberMe = val),
                              onSubmit: _submit,
                            ),
                          ],
                        ),
                      )
                      : Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Flexible(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: _LoginForm(
                                formKey: _formKey,
                                usernameController: _usernameController,
                                passwordController: _passwordController,
                                rememberMe: _rememberMe,
                                onRememberChanged:
                                    (val) => setState(() => _rememberMe = val),
                                onSubmit: _submit,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 7,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              child: _WelcomePanel(fullWidth: false),
                            ),
                          ),
                        ],
                      ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomePanel extends StatelessWidget {
  final bool fullWidth;
  const _WelcomePanel({this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : 320,
      constraints:
          fullWidth ? null : const BoxConstraints(minWidth: 240, maxWidth: 380),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff00bcff), Color(0xff0099ff)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: fullWidth ? 36 : 28,
        vertical: fullWidth ? 32 : 28,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.quiz_outlined,
            color: Colors.white,
            size: fullWidth ? 48 : 40,
          ),
          const SizedBox(height: 16),
          Text(
            'Chào mừng bạn đến với App thi trắc nghiệm',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: fullWidth ? 20 : 17,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Đăng nhập để kiểm tra kiến thức!',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.white70,
              fontSize: fullWidth ? 14 : 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final ValueChanged<bool> onRememberChanged;
  final VoidCallback onSubmit;

  const _LoginForm({
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
    required this.rememberMe,
    required this.onRememberChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Đăng Nhập',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xfffa626a),
              ),
            ),
            const SizedBox(height: 12),
            _AppTextInput(
              controller: usernameController,
              label: 'Tên đăng nhập',
              prefixIcon: const Icon(Icons.person_outline_rounded, size: 18),
              validator:
                  (value) => value!.isEmpty ? 'Vui lòng nhập tài khoản' : null,
            ),
            const SizedBox(height: 8),
            _AppTextInput(
              controller: passwordController,
              label: 'Mật khẩu',
              obscureText: true,
              prefixIcon: const Icon(Icons.lock_outline_rounded, size: 18),
              validator:
                  (value) => value!.isEmpty ? 'Vui lòng nhập mật khẩu' : null,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (value) => onRememberChanged(value ?? false),
                  activeColor: const Color(0xfffa626a),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                Text(
                  "Nhớ tài khoản",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 32,
              child: ElevatedButton(
                onPressed: onSubmit,
                child: Text(
                  'Đăng Nhập',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xfffa626a),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 1,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Chưa có tài khoản?',
                  style: GoogleFonts.montserrat(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: () => GoRouter.of(context).go('/register'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xfffa626a),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    'Đăng ký',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AppTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;

  const _AppTextInput({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: GoogleFonts.montserrat(fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xfffa626a), width: 1.2),
        ),
        prefixIcon: prefixIcon,
      ),
      validator: validator,
    );
  }
}
