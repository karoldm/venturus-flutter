import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes/controllers/custom_theme_controller.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final theme = Get.find<CustomThemeController>();
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        setState(() => _currentIndex = 0);
        GoRouter.of(context).go('/');
        break;
      case 1:
        setState(() => _currentIndex = 1);
        GoRouter.of(context).go('/favorites');
        break;
      case 2:
        setState(() => _currentIndex = 2);
        GoRouter.of(context).go('/profile');
        break;
      case 3:
        theme.toogleTheme();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.restaurant_menu,
            color: Theme.of(context).colorScheme.primary,
          ),
          label: 'Receitas',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            color: Theme.of(context).colorScheme.primary,
          ),
          label: 'Favoritos',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.primary,
          ),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Obx(
            () => !theme.isDark.value
                ? Icon(
                    Icons.nightlight_round_sharp,
                    size: 24,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Icon(
                    Icons.wb_sunny_outlined,
                    size: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
          ),
          label: 'Tema',
        ),
      ],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _currentIndex,
      selectedItemColor: Theme.of(context).colorScheme.error,
      onTap: _onItemTapped,
    );
  }
}
