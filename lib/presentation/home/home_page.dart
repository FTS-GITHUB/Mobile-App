import 'package:dropandgouser/presentation/home/home_navigation_bar.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/onboarding_appbar.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          title: StandardText.headline5(
            context,
            "Home",
            color: DropAndGoColors.black,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: StandardText.headline4(
          context,
          "Welcome to Home page",
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        child: HomeNavigationBar(
          onSelectTab: (index) {
            print(index);
          },
          currentTab: 0,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: DropAndGoColors.white,
        ),
      ),
    );
  }
}
