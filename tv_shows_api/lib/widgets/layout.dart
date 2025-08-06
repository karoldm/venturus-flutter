import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/providers/tv_shows.dart';
import 'package:tv_shows/widgets/custom_drawer.dart';

class Layout extends StatefulWidget {
  final Widget child;
  const Layout({super.key, required this.child});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;
    final viewModel = context.watch<TvShowsProvider>();

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Eu amo séries 🎬',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
      body: widget.child,
      floatingActionButton: currentPath == '/'
          ? SpeedDial(
              elevation: 5,
              icon: Icons.sort,
              activeIcon: Icons.close,
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              foregroundColor: Theme.of(context).colorScheme.primary,
              overlayColor: Theme.of(context).colorScheme.primary,
              overlayOpacity: 0.5,
              children: [
                SpeedDialChild(
                  child: Icon(
                    Icons.sort_by_alpha,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  label: 'Ordernar por Nome',
                  labelBackgroundColor: Theme.of(context).colorScheme.surface,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  onTap: () {
                    viewModel.sortByName(_isAscending);
                    setState(() {
                      _isAscending = !_isAscending;
                    });
                  },
                ),
                SpeedDialChild(
                  child: Icon(
                    Icons.star_rate,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  label: 'Ordernar por Nota',
                  labelBackgroundColor: Theme.of(context).colorScheme.surface,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  onTap: () {
                    viewModel.sortByRating(_isAscending);
                    setState(() {
                      _isAscending = !_isAscending;
                    });
                  },
                ),
              ],
            )
          : null,
    );
  }
}
