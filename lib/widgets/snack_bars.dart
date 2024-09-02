import 'package:flutter/material.dart';

class SnackBars {
  final BuildContext context;
  final String massage;
  SnackBars({
    required this.context,
    required this.massage,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        content: Text(
          massage,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
      ),
    );
  }

  SnackBars.error({
    required this.context,
    required this.massage,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        content: Text(
          massage,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.red[800],
              ),
        ),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
      ),
    );
  }
}
