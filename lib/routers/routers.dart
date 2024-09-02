import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list_app/screens/add_item.dart';
import 'package:shopping_list_app/screens/shopping_list.dart';
import 'package:shopping_list_app/widgets/TabBar/bottom_tab.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: const BottomTabBar(),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const ShoppingListScreen();
          },
        ),
        GoRoute(
          path: '/addItem',
          builder: (context, state) {
            return const AddItemScreen();
          },
        )
      ]),
]);

