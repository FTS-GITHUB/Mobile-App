import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({
    Key? key,
    required this.onSelectTab,
    required this.currentTab,
  }) : super(key: key);
  final ValueChanged<int> onSelectTab;
  final int currentTab;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: theme.navigationBarTheme.backgroundColor,
      selectedItemColor: DropAndGoColors.white,
      unselectedItemColor: DropAndGoColors.white,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      // showSelectedLabels: true,
      // showUnselectedLabels: true,
      onTap: (int index) => onSelectTab(index),
      currentIndex: currentTab,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: currentTab == 0
              ? SvgPicture.asset(
                  DropAndGoIcons.homeFilled,
                  color: DropAndGoColors.homeIcon,
                )
              : SvgPicture.asset(
                  DropAndGoIcons.homeOutlined,
                  color: DropAndGoColors.homeIcon,
                ),
          label: 'Home',
          backgroundColor: DropAndGoColors.primary,
        ),
        BottomNavigationBarItem(
          icon: currentTab == 1
              ? SvgPicture.asset(
                  DropAndGoIcons.downloadFilled,
                  color: DropAndGoColors.downloadIcon,
                )
              : SvgPicture.asset(
                  DropAndGoIcons.downloadOutlined,
                  color: DropAndGoColors.downloadIcon,
                ),
          label: 'Download',
        ),
        BottomNavigationBarItem(
          icon: currentTab == 2
              ? SvgPicture.asset(
                  DropAndGoIcons.analyticsFilled,
                )
              : SvgPicture.asset(
                  DropAndGoIcons.analyticsOutlined,
                ),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: currentTab == 3
              ? SvgPicture.asset(
            DropAndGoIcons.accountFilled,
            color: DropAndGoColors.profileIcon,
          )
              : SvgPicture.asset(
                  DropAndGoIcons.accountOutlined,
                  color: DropAndGoColors.profileIcon,
                ),
          label: 'Account',
        ),
      ],
    );
  }
}
