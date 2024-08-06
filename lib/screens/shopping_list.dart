import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/providers/grocery_provider.dart';
import 'package:shopping_list_app/screens/add_item.dart';
import 'package:shopping_list_app/widgets/grocery_item.dart';

class ShoppingListScreen extends ConsumerStatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  ConsumerState<ShoppingListScreen> createState() {
    return _ShoppingListScreenState();
  }
}

class _ShoppingListScreenState extends ConsumerState<ShoppingListScreen> {
  var isLoading = true;
  var getResponseData = null;
  Widget? body;
  final baseUrl = Uri.https(
      'shopping-list-ec1d8-default-rtdb.firebaseio.com', 'shopping-list.json');

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<dynamic> fetchData() async {
    getResponseData = await ref.read(groceryItemsProvider.notifier).loadData();
    setState(() {
      isLoading = false;
    });
  }

  void _addItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddItemScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groceryItems = ref.watch(groceryItemsProvider);

    if (isLoading) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (getResponseData == null) {
      body = SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const Center(
            child: Text(
              'Server Error Please Try Again Later',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    } else if (groceryItems.isEmpty) {
      body = const Center(
        child: Text(
          'No Groceries yet',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      body = ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Dismissible(
            background: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete_forever),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            direction: DismissDirection.endToStart,
            key: ValueKey(groceryItems[index].id),
            onDismissed: (ismissDirection) {
              ref
                  .read(groceryItemsProvider.notifier)
                  .removeItem(groceryItems[index]);
            },
            child: GroceryItemWidget(
              groceryItem: groceryItems[index],
              id: groceryItems[index].id,
              color: groceryItems[index].category.color,
              quantity: groceryItems[index].quantity,
              title: groceryItems[index].name,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(onRefresh: fetchData, child: body!),
    );
  }
}
