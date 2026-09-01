import 'package:material_ui/material_ui.dart';
import 'package:flutter_decks/src/presentation/feature/decks_page.dart'
    show DecksPage;
import 'package:flutter_decks/src/presentation/feature/learn_page.dart'
    show LearnPage;
import 'package:flutter_decks/src/presentation/feature/settings_page.dart'
    show SettingsPage;

class BottomNavigationBar extends StatefulWidget {
  const BottomNavigationBar({super.key});

  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: null,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: 'Learn',
          ),
          NavigationDestination(
            icon: Icon(Icons.amp_stories_outlined),
            selectedIcon: Icon(Icons.amp_stories),
            label: 'Decks',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body:
          <Widget>[
            /// Learn page
            LearnPage(),

            /// Decks page
            DecksPage(),

            /// Settings page,
            SettingsPage(),
          ][currentPageIndex],
    );
  }
}
