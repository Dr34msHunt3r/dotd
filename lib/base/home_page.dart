import 'package:auto_route/auto_route.dart';
import 'package:dotd/navigation/auto_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        RecipesRouter(),
        DrawMealRouter()
      ],
      bottomNavigationBuilder: (_,tabsRouter) {
        return SalomonBottomBar(
          margin: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20
          ),
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            SalomonBottomBarItem(
                icon: const Icon(Icons.home, size: 30,),
                title: const Text('Home'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.receipt, size: 30,),
              title: const Text('Draw the meal'),
            )
          ],
        );
      },
    );
  }

}