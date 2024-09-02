import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/providers/grocery_provider.dart';

import 'package:http/http.dart' as http;
import 'package:shopping_list_app/routers/routers.dart';
import 'package:shopping_list_app/widgets/TabBar/bottom_tab.dart';

final baseUrl = Uri.https(
    'shopping-list-ec1d8-default-rtdb.firebaseio.com', 'shopping-list.json');

class AddItemScreen extends ConsumerStatefulWidget {
  const AddItemScreen({super.key});

  @override
  ConsumerState<AddItemScreen> createState() {
    return _AddItemScreenState();
  }
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String _enteredName = '';
  int _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.fruit];
  bool _isSending = false;

  void _saveItem() async {
    final validate = _formKey.currentState!.validate();
    if (validate == true) {
      setState(() {
        _isSending = true;
      });
      _formKey.currentState!.save();

      final response = await http.post(
        baseUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'name': _enteredName,
            'quantity': _enteredQuantity,
            'category': _selectedCategory!.title,
            'date': (formattedDate.toString()),
          },
        ),
      );

      ref.read(groceryItemsProvider.notifier).addItem(
            GroceryItem(
                id: jsonDecode(response.body)['name'],
                name: _enteredName,
                quantity: _enteredQuantity,
                category: _selectedCategory!,
                date: formattedDate.toString()),
          );

      if (!context.mounted) {
        return;
      }
      router.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().colorScheme.onSurface,
        title: Text('Add New Item',
            style: ThemeData().textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(3),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  maxLength: 50,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    label: const Text(
                      'Name',
                    ),
                    labelStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Must be between 1 and 50 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.bodyMedium,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Must be 1 or more';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text(
                          'Quantity',
                        ),
                        labelStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      initialValue: '1',
                      onSaved: (value) {
                        _enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      value: _selectedCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: category.value.color,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(category.value.title),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending
                        ? null
                        : () {
                            _formKey.currentState!.reset();
                          },
                    child: const Text("Reset"),
                  ),
                  TextButton(
                    onPressed: _isSending ? null : _saveItem,
                    child: _isSending
                        ? const SizedBox(
                            height: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text("Save"),
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
