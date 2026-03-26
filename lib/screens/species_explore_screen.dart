import 'package:flutter/material.dart';

import '../data/species_data.dart';
import '../models/species.dart';
import '../widgets/species_grid_card.dart';
import 'species_detail_screen.dart';

class SpeciesExploreScreen extends StatefulWidget {
  const SpeciesExploreScreen({super.key});

  @override
  State<SpeciesExploreScreen> createState() => _SpeciesExploreScreenState();
}

class _SpeciesExploreScreenState extends State<SpeciesExploreScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'Todas',
    'Mamífero',
    'Ave',
    'Reptil',
    'Anfibio',
    'Planta',
  ];

  String _selectedCategory = 'Todas';

  List<Species> get _filteredSpecies {
    final query = _searchController.text.trim().toLowerCase();

    return speciesList.where((species) {
      final matchesCategory = _selectedCategory == 'Todas'
          ? true
          : species.category == _selectedCategory;

      final matchesSearch =
          species.name.toLowerCase().contains(query) ||
          species.scientificName.toLowerCase().contains(query) ||
          species.category.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredSpecies;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorar especies'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Buscar por nombre o categoría',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.tune),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = category == _selectedCategory;

                  return FilterChip(
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    showCheckmark: false,
                    label: Text(category),
                    selectedColor:
                        const Color(0xFF2E7D32).withOpacity(0.18),
                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xFF2E7D32)
                          : Colors.grey.shade300,
                    ),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? const Color(0xFF1B5E20)
                          : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filtered.isEmpty
                  ? const Center(
                      child: Text(
                        'No se encontraron especies con esos filtros.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : GridView.builder(
                      itemCount: filtered.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 0.78,
                      ),
                      itemBuilder: (context, index) {
                        final species = filtered[index];

                        return SpeciesGridCard(
                          species: species,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    SpeciesDetailScreen(species: species),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}