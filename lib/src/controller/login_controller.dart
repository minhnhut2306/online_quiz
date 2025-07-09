import 'package:flutter/material.dart';

class LoginController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }

  bool validate(GlobalKey<FormState> formKey) {
    return formKey.currentState!.validate();
  }
}