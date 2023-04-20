import 'package:dropandgouser/application/main/cubit/main_navbar_cubit.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/home/home_navigation_bar.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        child: BlocBuilder<MainNavBarCubit, int>(
          builder: (context, selectedIndex) {
            return HomeNavigationBar(
              onSelectTab: (index) => _onItemTapped(index, context),
              currentTab: selectedIndex,
            );
          }
        ),
      ),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    context.read<MainNavBarCubit>().changeBottomNavBar(index);
    getIt<NavigationService>()
        .navigateToNamed(context: context, uri: getRoute(index));
  }

  String getRoute(int index) {
    String path = NavigationService.homeRouteUri;

    switch (index) {
      case 0:
        path = NavigationService.homeRouteUri;
        break;
      case 1:
        path = NavigationService.downloadsRouteUri;
        break;
      case 2:
        path = NavigationService.analyticsRouteUri;
        break;
      case 3:
        path = NavigationService.accountRouteUri;
        break;
    }
    return path;
  }
}
