import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/providers/grocery_provider.dart';

class ExpandableChild extends ConsumerWidget {
  const ExpandableChild({
    super.key,
    required this.groceryItem,
  });

  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Container(
        // height: 160,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Row(
          children: [
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Hero(
                  tag: ValueKey(groceryItem.id),
                  child: Container(
                    width: 50,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: groceryItem.category.color,
                    ),
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              color: Theme.of(context).colorScheme.secondary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    groceryItem.name,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: ThemeData().colorScheme.onPrimary,
                        ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text(
                        "Category: ",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: 28,
                              color: ThemeData().colorScheme.onPrimary,
                            ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        groceryItem.category.title.toString(),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: 28,
                              color: ThemeData().colorScheme.onPrimary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Quantity: ",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: 28,
                              color: ThemeData().colorScheme.onPrimary,
                            ),
                      ),
                      Text(
                        groceryItem.quantity.toString(),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: 28,
                              color: ThemeData().colorScheme.onPrimary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Date: ",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: 28,
                              color: ThemeData().colorScheme.onPrimary,
                            ),
                      ),
                      Text(
                        groceryItem.date,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: 28,
                              color: ThemeData().colorScheme.onPrimary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton.icon(
                        label: Text(
                          "decrement",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 20,
                                    color: Colors.red,
                                  ),
                        ),
                        onPressed: () {
                          ref
                              .read(groceryItemsProvider.notifier)
                              .decrementQuentity(groceryItem);
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      FilledButton.icon(
                        label: Text(
                          "increment",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 20,
                                    color: Colors.green[400],
                                  ),
                        ),
                        onPressed: () {
                          ref
                              .read(groceryItemsProvider.notifier)
                              .incrementQuentity(groceryItem);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
