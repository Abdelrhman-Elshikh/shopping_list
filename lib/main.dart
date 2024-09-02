import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/helper/styling.dart';
import 'package:shopping_list_app/screens/shopping_list.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list_app/routers/routers.dart';
import 'package:shopping_list_app/widgets/TabBar/bottom_tab.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Groceries',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: Colors.grey,
            surface: Colors.grey[700],
            secondary: Colors.grey[900],
            primary: Colors.grey[850],
            onPrimary: Colors.grey[300]),
        scaffoldBackgroundColor: Colors.grey[700],
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 14,
            fontWeight: FontWeight.bold,
          ),
          labelLarge:
              TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
          bodyMedium:
              TextStyle(fontSize: MediaQuery.of(context).size.width / 20),
        ),
      ),
      routerConfig: router,
    );
  }
}
