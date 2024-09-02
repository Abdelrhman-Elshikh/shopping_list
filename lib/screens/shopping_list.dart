import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list_app/main.dart';
import 'package:shopping_list_app/providers/grocery_provider.dart';
import 'package:shopping_list_app/screens/add_item.dart';
import 'package:shopping_list_app/widgets/grocery_item.dart';
import 'package:shopping_list_app/widgets/snack_bars.dart';

class ShoppingListScreen extends ConsumerStatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  ConsumerState<ShoppingListScreen> createState() {
    return _ShoppingListScreenState();
  }
}

class _ShoppingListScreenState extends ConsumerState<ShoppingListScreen> {
  var isLoading = true;
  var getResponseData;
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
        child: FittedBox(
          child: Text(
            'No Groceries yet',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
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
                vertical: 20,
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
              SnackBars.error(context: context, massage: 'Item removed');
            },
            child: GroceryItemWidget(
              groceryItem: groceryItems[index],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      // bottomNavigationBar: const BottomTabBar(),
      appBar: AppBar(
        backgroundColor: ThemeData().colorScheme.onSurface,
        title: Text("Shopping List",
            style: ThemeData().textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                )),
      ),
      body: RefreshIndicator(onRefresh: fetchData, child: body!),
    );
  }
}
