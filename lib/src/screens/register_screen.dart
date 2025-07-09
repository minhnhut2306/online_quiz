import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_quiz/src/constants/services/api_caller.dart';
import 'package:online_quiz/src/widgets/app_text_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();


void _submit() async {
  if (_formKey.currentState!.validate()) {
    final data = {
      "id": _usernameController.text.trim(),
      "passWord": _passwordController.text,
      "rePassWord": _confirmPasswordController.text,
      "fullName": _fullNameController.text,
      "email": _emailController.text.trim(),
      "address": _addressController.text.trim(),
      "phoneNumber": _phoneController.text.trim(),
    };

    try {
      final res = await APICaller().post("api/user/register", body: data);

      if (res != null && res['id'] != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đăng ký thành công! Vui lòng đăng nhập.")),
        );
       context.go('/login');
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res?['error'] ?? "Đăng ký thất bại!"),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi đăng ký: $e")),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 400;
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 370),
            padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 24, horizontal: isMobile ? 12 : 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.09),
                  blurRadius: 22,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xff00bcff), Color(0xff0099ff)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        padding: const EdgeInsets.all(7),
                        child: const Icon(Icons.person_add_alt_1, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Đăng ký tài khoản',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff003366),
                          letterSpacing: 0.1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  AppTextInput(
                    controller: _fullNameController,
                    label: 'Họ và tên*',
                    validator: (value) => value!.trim().isEmpty ? 'Vui lòng nhập họ và tên' : null,
                    prefixIcon: const Icon(Icons.account_circle_outlined, color: Color(0xff00bcff), size: 18),
                  ),
                  const SizedBox(height: 4),
                  AppTextInput(
                    controller: _usernameController,
                    label: 'Tên đăng nhập*',
                    validator: (value) => value!.trim().isEmpty ? 'Vui lòng nhập tên đăng nhập' : null,
                    prefixIcon: const Icon(Icons.person_outline, color: Color(0xff00bcff), size: 18),
                  ),
                  const SizedBox(height: 4),
                  AppTextInput(
                    controller: _passwordController,
                    label: 'Mật khẩu*',
                    obscureText: true,
                    validator: (value) => value!.isEmpty
                        ? 'Vui lòng nhập mật khẩu'
                        : (value.length < 6 ? 'Ít nhất 6 ký tự' : null),
                    prefixIcon: const Icon(Icons.lock_outline, color: Color(0xfffa626a), size: 18),
                  ),
                  const SizedBox(height: 4),
                  AppTextInput(
                    controller: _confirmPasswordController,
                    label: 'Nhập lại mật khẩu*',
                    obscureText: true,
                    validator: (value) => value != _passwordController.text
                        ? 'Mật khẩu không khớp'
                        : null,
                    prefixIcon: const Icon(Icons.lock_reset, color: Color(0xfffa626a), size: 18),
                  ),
                  const SizedBox(height: 4),
                  AppTextInput(
                    controller: _emailController,
                    label: 'Email*',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value == null ||
                            value.trim().isEmpty ||
                            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)
                        ? 'Email không hợp lệ'
                        : null,
                    prefixIcon: const Icon(Icons.email_outlined, color: Color(0xff00bcff), size: 18),
                  ),
                  const SizedBox(height: 4),
                  AppTextInput(
                    controller: _phoneController,
                    label: 'Số điện thoại*',
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        value!.isEmpty ? 'Vui lòng nhập số điện thoại' : null,
                    prefixIcon: const Icon(Icons.phone_outlined, color: Color(0xff00bcff), size: 18),
                  ),
                  const SizedBox(height: 4),
                  AppTextInput(
                    controller: _addressController,
                    label: 'Địa chỉ*',
                    validator: (value) =>
                        value!.isEmpty ? 'Vui lòng nhập địa chỉ' : null,
                    prefixIcon: const Icon(Icons.home_outlined, color: Color(0xff00bcff), size: 18),
                  ),
                  const SizedBox(height: 4),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '*Các trường bắt buộc',
                      style: TextStyle(color: Colors.red, fontSize: 11.5),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xff00bcff), Color(0xff0099ff)],
                          ),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Đăng ký',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}