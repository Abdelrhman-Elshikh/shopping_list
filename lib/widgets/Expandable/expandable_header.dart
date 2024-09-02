import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

class ExpandableHeader extends StatelessWidget {
  const ExpandableHeader({
    super.key,
    required this.groceryItem,
  });

  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Row(
          children: [
            Hero(
              tag: ValueKey(groceryItem.id),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: groceryItem.category.color,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              groceryItem.name.toString(),
              style: ThemeData().textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            const Spacer(),
            Text(
              groceryItem.quantity.toString(),
              style: ThemeData().textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
