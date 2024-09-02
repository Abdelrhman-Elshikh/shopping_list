import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/providers/grocery_provider.dart';

class GroceryDetailsScreen extends ConsumerWidget {
  const GroceryDetailsScreen({
    super.key,
    required this.groceryItem,
  });

  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GroceryItem? item;
    try {
      item = ref
          .watch(groceryItemsProvider)
          .firstWhere((i) => i.id == groceryItem.id);
    } catch (e) {
      Navigator.of(context).pop();
    }

    return Scaffold(
      
      appBar: AppBar(
        title: Text(item!.name),
      ),
      body: Hero(
        tag: ValueKey(item.id),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                item.category.color.withOpacity(.5),
                item.category.color.withOpacity(0.4),
                item.category.color.withOpacity(0.3),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Category: ",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    item.category.title.toString(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    "quantity: ",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    item.quantity.toString(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.icon(
                    label: const Text(
                      "decrement",
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                    onPressed: () {
                      ref
                          .read(groceryItemsProvider.notifier)
                          .decrementQuentity(item!);
                    },
                    icon: const Icon(
                      Icons.exposure_neg_1_outlined,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FilledButton.icon(
                    label: const Text("increment"),
                    onPressed: () {
                      ref
                          .read(groceryItemsProvider.notifier)
                          .incrementQuentity(item!);
                    },
                    icon: const Icon(
                      Icons.plus_one_sharp,
                      color: Colors.green,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
