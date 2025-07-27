import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/providers/theme_app.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Eu amo séries 🎬",
                    style: GoogleFonts.lobster(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    label: const Text('Mudar Tema'),
                    icon: context.watch<AppThemeProvider>().themeMode ==
                            ThemeMode.dark
                        ? const Icon(
                            Icons.nightlight_round_sharp,
                            size: 24,
                          )
                        : const Icon(
                            Icons.wb_sunny_outlined,
                            size: 24,
                          ),
                    onPressed: context.read<AppThemeProvider>().switchMode,
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
              context.go('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text("Adicionar Série"),
            onTap: () {
              Navigator.pop(context);
              context.go('/new');
            },
          ),
        ],
      ),
    );
  }
}
