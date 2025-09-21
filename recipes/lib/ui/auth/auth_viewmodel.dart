import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes/data/repositories/auth_repository.dart';
import 'package:recipes/di/service_locator.dart';
import 'package:recipes/l10n/app_localizations.dart';

class AuthViewModel extends GetxController {
  final _repository = getIt<AuthRepository>();

  // Form
  final formKey = GlobalKey<FormState>();

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();
  final avatarUrlController = TextEditingController();

  // Estados
  final _obscurePassword = true.obs;
  final _isSubmitting = false.obs;
  final _isLoginMode = true.obs;
  final _errorMessage = ''.obs;

  // Getters
  bool get obscurePassword => _obscurePassword.value;
  bool get isSubmitting => _isSubmitting.value;
  bool get isLoginMode => _isLoginMode.value;
  String get errorMessage => _errorMessage.value;

  String? validateEmail(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.errorEmailRequired;
    if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    ).hasMatch(value)) {
      return l10n.errorEmailInvalid;
    }
    return null;
  }

  String? validatePassword(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.errorPasswordRequired;
    if (value.length < 8) return l10n.errorPasswordTooShort;
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return l10n.errorPasswordNeedsLowercase;
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return l10n.errorPasswordNeedsUppercase;
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) return l10n.errorPasswordNeedsNumber;
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-+=\[\]\\/;]').hasMatch(value)) {
      return l10n.errorPasswordNeedsSpecialChar;
    }
    return null;
  }

  String? validateConfirmPassword(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.errorConfirmPasswordRequired;
    }
    if (value != passwordController.text) return l10n.errorPasswordsDoNotMatch;
    return null;
  }

  String? validateUsername(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.errorUsernameRequired;
    if (value.length < 3) return l10n.errorUsernameTooShort;
    return null;
  }

  String? validateAvatarUrl(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.errorAvatarUrlRequired;
    if (!RegExp(
      r'^(https?:\/\/)?([\w-]+\.)+[\w-]+(\/[\w- ./?%&=]*)?$',
    ).hasMatch(value)) {
      return l10n.errorAvatarUrlInvalid;
    }
    return null;
  }

  void toggleObscurePassword() =>
      _obscurePassword.value = !_obscurePassword.value;

  Future<void> submit(AppLocalizations l10n) async {
    final valid = formKey.currentState?.validate() ?? false;
    if (!valid) return;

    _isSubmitting.value = true;
    if (isLoginMode) {
      await login();
    } else {
      await register(l10n);
    }
    _isSubmitting.value = false;
  }

  Future<void> register(AppLocalizations l10n) async {
    final response = await _repository.signUp(
      email: emailController.text,
      password: passwordController.text,
      username: usernameController.text,
      avatarUrl: avatarUrlController.text,
    );

    response.fold(
      ifLeft: (left) {
        _errorMessage.value = left.message;
      },
      ifRight: (right) {
        debugPrint('Usuário registrado com sucesso: $right');
        _clearFields();
        _errorMessage.value = l10n.messageEmailConfirmationSent;
        _isLoginMode.value = true;
      },
    );
  }

  Future<void> login() async {
    final response = await _repository.signInWithPassword(
      emailController.text,
      passwordController.text,
    );

    response.fold(
      ifLeft: (left) {
        _errorMessage.value = left.message;
      },
      ifRight: (right) {
        debugPrint(right.toString());
        return;
      },
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
    avatarUrlController.dispose();
    super.onClose();
  }

  void toggleMode() {
    _isLoginMode.value = !_isLoginMode.value;
    _isSubmitting.value = false;
    _clearFields();
    _obscurePassword.value = true;

    // * update
    // Necessário para atualizar a UI
    update();
  }

  void _clearFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    usernameController.clear();
    avatarUrlController.clear();
  }
}
