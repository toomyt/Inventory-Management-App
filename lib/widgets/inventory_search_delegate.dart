import 'package:flutter/material.dart';
import 'package:inventory_management_app/models/item.dart';
import 'package:inventory_management_app/screens/item_form_screen.dart';
import 'package:inventory_management_app/services/inventory_service.dart';

class InventorySearchDelegate extends SearchDelegate<ItemModel?> {
  final InventoryService _service = InventoryService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults(context);

  Widget _buildSearchResults(BuildContext context) {
    return StreamBuilder<List<ItemModel>>(
      stream: _service.streamItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final allItems = snapshot.data ?? [];
        final filtered = allItems
            .where((item) =>
                item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

        if (query.isEmpty) {
          return const Center(child: Text('Type to search inventory...'));
        }

        if (filtered.isEmpty) {
          return Center(child: Text('No items found for "$query"'));
        }

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final item = filtered[index];
            return ListTile(
              leading: const Icon(Icons.inventory_2_outlined),
              title: Text(item.name),
              subtitle: Text(
                  'Price: \$${item.price.toStringAsFixed(2)} · Qty: ${item.quantity}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {
                  close(context, null);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ItemFormScreen(item: item)),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}