import 'package:flutter/material.dart';

class CategoryChipList extends StatelessWidget {
  const CategoryChipList({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Mamíferos',
      'Aves',
      'Reptiles',
      'Anfibios',
      'Plantas',
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = index == 0;

          return FilterChip(
            selected: isSelected,
            onSelected: (_) {},
            label: Text(categories[index]),
            showCheckmark: false,
            selectedColor: const Color(0xFF2E7D32).withOpacity(0.18),
            side: BorderSide(
              color: isSelected
                  ? const Color(0xFF2E7D32)
                  : Colors.grey.shade300,
            ),
            labelStyle: TextStyle(
              color: isSelected ? const Color(0xFF1B5E20) : Colors.black87,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          );
        },
      ),
    );
  }
}