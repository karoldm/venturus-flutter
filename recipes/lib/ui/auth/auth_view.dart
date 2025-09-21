import 'package:recipes/controllers/locale_controller.dart';
import 'package:recipes/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/l10n/app_localizations.dart';
import 'package:recipes/ui/auth/auth_viewmodel.dart';
import 'package:recipes/ui/widgets/language_selector.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView>
    with SingleTickerProviderStateMixin {
  final viewModel = getIt<AuthViewModel>();

  late AnimationController _animationController;
  late Animation<double> _animation;

  final localeController = Get.find<LocaleController>();

  @override
  void initState() {
    super.initState();

    // ao iniciar o estado, o _animationController fornece
    // valores em intervalos de 0 a 1
    _animationController =
        AnimationController(
          // vsync é um TikerProvider que ajuda a controlar a animação
          // o Ticker envia um sinal de "tick" a cada frame
          // e o AnimationController usa isso para atualizar a animação
          // O tikerProvider nesse caso é fornecido pelo mixin SingleTickerProviderStateMixin
          // Obs: SingleTickerProviderStateMixin porque eu tenho só um AnimationController
          // se tivesse mais de um, eu usaria TickerProviderStateMixin
          vsync: this,
          duration: const Duration(milliseconds: 1000),
        )..addStatusListener((listener) {
          // Esse listener ouve mudanças no estado da animação
          // e pode ser usado para fazer algo quando a animação
          // completa ou recomeça
          // Nesse caso, a animação fica indo e voltando
          // if (listener == AnimationStatus.completed) {
          //   _animationController.reverse();
          // } else if (listener == AnimationStatus.dismissed) {
          //   _animationController.forward();
          // }
        });

    // Tween define o intervalo de valores que a animação vai percorrer
    // nesse caso, de 50 a 200 (pode ser pixel, pode ser opacity, etc)
    // fazemos isso para mapear os valores gerados pelo AnimationController
    // de 0 a 1 para um intervalo de 100 a 120 (ou qualquer intervalo que você quiser)
    _animation =
        Tween<double>(begin: 100.0, end: 120.0).animate(_animationController)
          ..addListener(() {
            // quando a animação é atualizada, o setState é chamado
            // para atualizar a UI com o novo valor da animação
            setState(() {});
          });

    // forward inicia a animação
    _animationController.forward();
  }

  @override
  void dispose() {
    // é importante sempre liberar os recursos do AnimationController
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(
                () => Form(
                  key: viewModel.formKey,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 32),
                          _buildHeader(l10n),
                          const SizedBox(height: 32),
                          _buildEmailField(l10n),
                          const SizedBox(height: 16),
                          _buildPasswordField(l10n),
                          const SizedBox(height: 16),
                          if (!viewModel.isLoginMode) ...[
                            _buildConfirmPasswordField(l10n),
                            const SizedBox(height: 16),
                            _buildUsernameField(l10n),
                            const SizedBox(height: 16),
                            _buildAvatarUrlField(l10n),
                          ],
                          const SizedBox(height: 32),
                          _buildSubmitButton(context, l10n),
                          const SizedBox(height: 32),
                          _buildErrorMessage(l10n),
                          const SizedBox(height: 32),
                          _buildToggleModeButton(l10n),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 32,
              right: 8,
              child: Obx(
                () => LanguageSelector(
                  onLanguageChanged: localeController.changeLocale,
                  currentLocale: localeController.locale,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _animatedLogo({required AnimationController controller}) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final sizeTween = Tween<double>(
          begin: 50.0,
          end: 150.0,
        ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

        final colorTween = ColorTween(
          begin: Colors.transparent,
          end: Theme.of(context).colorScheme.primary,
        ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

        final angleTween = Tween<double>(
          begin: 0.0,
          end: 2 * 3.14,
        ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

        return Transform.rotate(
          angle: angleTween.value,
          child: SizedBox(
            height: 150,
            child: Icon(
              Icons.restaurant_menu,
              size: sizeTween.value,
              color: colorTween.value,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _animatedLogo(controller: _animationController),
        const SizedBox(height: 16),
        Text(
          l10n.appTitle,
          style: GoogleFonts.rubik(fontSize: 28, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          viewModel.isLoginMode ? l10n.signInSubtitle : l10n.signUpSubtitle,

          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
        ),
      ],
    );
  }

  Widget _buildEmailField(AppLocalizations l10n) {
    return TextFormField(
      controller: viewModel.emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: l10n.emailLabel,
        hintText: l10n.emailHint,
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) => viewModel.validateEmail(value, l10n),
    );
  }

  Widget _buildPasswordField(AppLocalizations l10n) {
    return Obx(
      () => TextFormField(
        controller: viewModel.passwordController,
        obscureText: viewModel.obscurePassword,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: l10n.passwordLabel,
          hintText: l10n.passwordHint,
          prefixIcon: const Icon(Icons.lock_outlined),
          suffixIcon: IconButton(
            icon: Icon(
              viewModel.obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            onPressed: viewModel.toggleObscurePassword,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) => viewModel.validatePassword(value, l10n),
      ),
    );
  }

  Widget _buildConfirmPasswordField(AppLocalizations l10n) {
    return TextFormField(
      controller: viewModel.confirmPasswordController,
      obscureText: viewModel.obscurePassword,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: l10n.confirmPasswordLabel,
        hintText: l10n.confirmPasswordHint,
        prefixIcon: const Icon(Icons.lock_outlined),
        suffixIcon: IconButton(
          icon: Icon(
            viewModel.obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: viewModel.toggleObscurePassword,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) => viewModel.validateConfirmPassword(value, l10n),
    );
  }

  Widget _buildUsernameField(AppLocalizations l10n) {
    return TextFormField(
      controller: viewModel.usernameController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: l10n.usernameLabel,
        hintText: l10n.usernameHint,
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) => viewModel.validateUsername(value, l10n),
    );
  }

  Widget _buildAvatarUrlField(AppLocalizations l10n) {
    return TextFormField(
      controller: viewModel.avatarUrlController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: l10n.avatarUrlLabel,
        hintText: l10n.avatarUrlHint,
        prefixIcon: const Icon(Icons.image_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) => viewModel.validateAvatarUrl(value, l10n),
    );
  }

  Widget _buildSubmitButton(BuildContext context, AppLocalizations l10n) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () => viewModel.submit(l10n),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        child: viewModel.isSubmitting
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                viewModel.isLoginMode
                    ? l10n.signInSubtitle
                    : l10n.signUpSubtitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildToggleModeButton(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          viewModel.isLoginMode
              ? l10n.noAccountQuestion
              : l10n.hasAccountQuestion,
        ),
        TextButton(
          onPressed: viewModel.isSubmitting ? null : viewModel.toggleMode,
          child: Text(
            viewModel.isLoginMode ? l10n.signUpLink : l10n.signInLink,

            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(AppLocalizations l10n) {
    return Obx(
      () => Visibility(
        visible: viewModel.errorMessage.isNotEmpty,
        child: Text(
          viewModel.errorMessage,
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
