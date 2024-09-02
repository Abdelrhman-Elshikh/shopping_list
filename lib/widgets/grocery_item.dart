import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

import 'package:shopping_list_app/widgets/Expandable/expandable.dart';
import 'package:shopping_list_app/widgets/Expandable/expandable_header.dart';
import 'package:shopping_list_app/widgets/Expandable/expandable_child.dart';

class GroceryItemWidget extends ExpandableWidget {
  final GroceryItem groceryItem;
  GroceryItemWidget({super.key, required this.groceryItem})
      : super(
            child: ExpandableChild(groceryItem: groceryItem),
            header: ExpandableHeader(groceryItem: groceryItem));
}
