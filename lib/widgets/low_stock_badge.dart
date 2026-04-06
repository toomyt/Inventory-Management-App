import 'package:flutter/material.dart';

class LowStockBadge extends StatelessWidget {
  final int quantity;
  static const int lowStockThreshold = 5;

  const LowStockBadge({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    if (quantity > lowStockThreshold) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: quantity == 0 ? Colors.red.shade100 : Colors.orange.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: quantity == 0 ? Colors.red : Colors.orange,
          width: 1,
        ),
      ),
      child: Text(
        quantity == 0 ? 'Out of Stock' : 'Low Stock',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: quantity == 0 ? Colors.red.shade800 : Colors.orange.shade800,
        ),
      ),
    );
  }
}