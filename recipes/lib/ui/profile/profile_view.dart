import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/di/service_locator.dart';
import 'package:recipes/l10n/app_localizations.dart';
import 'package:recipes/ui/profile/profile_viewmodel.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final viewModel = getIt<ProfileViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await viewModel.getCurrentUser();
    });
  }

  Future<void> signOut() async {
    await viewModel.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Obx(() {
      if (viewModel.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (viewModel.errorMessage != '') {
        return Center(
          child: Column(
            children: [
              Text(viewModel.errorMessage ?? ''),
              ElevatedButton(onPressed: signOut, child: Text("Sair")),
            ],
          ),
        );
      }

      final user = viewModel.profile.value;

      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                user?.avatarUrl ?? '',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                    ? child
                    : Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                errorBuilder: (context, child, stackTrace) => Container(
                  height: 200,
                  width: 200,
                  color: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              user?.username ?? '',
              style: GoogleFonts.rubik(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(user?.email ?? ''),
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: signOut,
                label: Text(
                  l10n.logout,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                icon: const Icon(Icons.logout),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
