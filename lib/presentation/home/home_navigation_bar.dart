import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:flutter/material.dart';

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({
    Key? key,
    required this.onSelectTab,
    required this.currentTab,
    this.selectedItemColor,
    this.unselectedItemColor,
  }) : super(key: key);
  final ValueChanged<int> onSelectTab;
  final int currentTab;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: theme.navigationBarTheme.backgroundColor,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      // showSelectedLabels: true,
      // showUnselectedLabels: true,
      onTap: (int index) => onSelectTab(index),
      currentIndex: currentTab,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: DropAndGoColors.primary,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Download',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded,color: DropAndGoColors.red),
          label: 'Account',
        ),
      ],
    );
  }
}
