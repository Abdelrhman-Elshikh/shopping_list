import 'package:shopping_list_app/models/category.dart';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);


class GroceryItem {
  const GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
    required this.date,
  });

  final String id;
  final String name;
  final int quantity;
  final Category category;
  final String date;
}
