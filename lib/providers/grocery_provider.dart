import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'dart:convert';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:http/http.dart' as http;

class GroceryItemsNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryItemsNotifier() : super([]);

  final baseUrl = Uri.https(
      'shopping-list-ec1d8-default-rtdb.firebaseio.com', 'shopping-list.json');

  Future loadData() async {
    // http.
    var respons;
    try {
      respons = await http.get(baseUrl);
    } catch (e) {
      return false;
    }
    if (respons.body == 'null') {
      return false;
    } else if (respons.statusCode < 400) {
      final Map<String, dynamic> listData = json.decode(respons.body);
      final List<GroceryItem> loadedItem = [];
      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere(
                (element) => element.value.title == item.value['category'])
            .value;
        loadedItem.add(
          GroceryItem(
              id: item.key,
              name: item.value['name'],
              quantity: item.value['quantity'],
              category: category),
        );
      }
      state = loadedItem;
      return true;
    }
  }

  void incrementQuentity(GroceryItem groceryItem) {
    final baseUrl = Uri.https('shopping-list-ec1d8-default-rtdb.firebaseio.com',
        'shopping-list/${groceryItem.id}.json');

    final item = state.firstWhere((i) => i.id == groceryItem.id);
    var index = state.indexOf(item);
    GroceryItem newItem = GroceryItem(
        id: item.id,
        name: item.name,
        quantity: item.quantity + 1,
        category: item.category);
    List<GroceryItem> newState = [...state];
    newState.remove(groceryItem);
    newState.insert(index, newItem);
    http.patch(
      baseUrl,
      body: json.encode(
        {
          'quantity': newItem.quantity,
        },
      ),
    );
    state = newState;
  }

  void decrementQuentity(GroceryItem groceryItem) {
    final baseUrl = Uri.https('shopping-list-ec1d8-default-rtdb.firebaseio.com',
        'shopping-list/${groceryItem.id}.json');
    final item = state.firstWhere((i) => i.id == groceryItem.id);
    var index = state.indexOf(item);
    if (item.quantity == 0) {
      return;
    } else {
      GroceryItem newItem = GroceryItem(
          id: item.id,
          name: item.name,
          quantity: item.quantity - 1,
          category: item.category);
      List<GroceryItem> newState = [...state];
      newState.remove(groceryItem);
      newState.insert(index, newItem);
      http.patch(
        baseUrl,
        body: json.encode(
          {
            'quantity': newItem.quantity,
          },
        ),
      );
      state = newState;
    }
  }

  void addItem(GroceryItem grocery) {
    state = [...state, grocery];
  }

  void removeItem(GroceryItem groceryItem) {
    final deleteUrl = Uri.https(
        'shopping-list-ec1d8-default-rtdb.firebaseio.com',
        'shopping-list/${groceryItem.id}.json');

    http.delete(deleteUrl);
    List<GroceryItem> newState = [...state];
    newState.remove(groceryItem);
    state = newState;
  }
}

final groceryItemsProvider =
    StateNotifierProvider<GroceryItemsNotifier, List<GroceryItem>>((ref) {
  return GroceryItemsNotifier();
});
