import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_list_app/screens/grocery_details.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

class GroceryItemWidget extends StatelessWidget {
  const GroceryItemWidget({
    super.key,
    required this.groceryItem,
    required this.id,
    required this.color,
    required this.quantity,
    required this.title,
  });

  final GroceryItem groceryItem;
  final String id;
  final Color color;
  final String title;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => GroceryDetailsScreen(
              groceryItem: groceryItem,
            ),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: Row(
            children: [
              Hero(
                tag: ValueKey(id),
                child: SizedBox(
                  width: 30,
                  child: Container(
                    color: color,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(title),
              const Spacer(),
              Text(
                quantity.toString(),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
