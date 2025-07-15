import 'package:flutter/material.dart';
import 'package:tv_shows/widgets/custom_drawer.dart';
import 'package:tv_shows/core/theme.dart';
import 'package:tv_shows/enums/pages_enum.dart';
import 'package:tv_shows/mocks/tv_shows_data.dart';
import 'package:tv_shows/models/tv_show.dart';
import 'package:tv_shows/pages/add_tv_show_page.dart';
import 'package:tv_shows/pages/tv_show_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<TvShow> showsList = favTvShowList;

  void addNewShow(TvShow newShow) {
    setState(() {
      showsList.add(newShow);
    });
  }

  PagesEnum currentPage = PagesEnum.newShow;
  Map<PagesEnum, Widget> get pages => {
        PagesEnum.home: TvShowPage(showsList: showsList),
        PagesEnum.newShow: AddTvShowPage(
          onShowAdded: addNewShow,
        ),
      };
  void switchPage(PagesEnum page) {
    setState(() {
      currentPage = page;
    });
  }

  bool isDarkMode = false;
  void switchTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TV Shows',
      theme: customTheme,
      darkTheme: customThemeDark,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        drawer: CustomDrawer(
          isDarkMode: isDarkMode,
          onThemeSwitch: switchTheme,
          onPageSelected: (page) => switchPage(page),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Eu amo séries 🎬',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        body: pages[currentPage],
      ),
    );
  }
}
