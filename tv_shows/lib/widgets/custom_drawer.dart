import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tv_shows/enums/pages_enum.dart';

class CustomDrawer extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeSwitch;
  final Function(PagesEnum page) onPageSelected;

  const CustomDrawer({
    super.key,
    required this.isDarkMode,
    required this.onThemeSwitch,
    required this.onPageSelected,
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
                    icon: !isDarkMode
                        ? const Icon(
                            Icons.nightlight_round_sharp,
                            size: 24,
                          )
                        : const Icon(
                            Icons.wb_sunny_outlined,
                            size: 24,
                          ),
                    onPressed: onThemeSwitch,
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              onPageSelected(PagesEnum.home);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text("Adicionar Série"),
            onTap: () {
              onPageSelected(PagesEnum.newShow);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
