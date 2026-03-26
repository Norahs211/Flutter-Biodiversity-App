import 'package:flutter/material.dart';
import '../data/species_data.dart';
import '../widgets/species_card.dart';
import 'species_detail_screen.dart';

class SpeciesListScreen extends StatelessWidget {
  const SpeciesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Especies'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: speciesList.length,
        itemBuilder: (context, index) {
          final species = speciesList[index];

          return SpeciesCard(
            species: species,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SpeciesDetailScreen(species: species),
                ),
              );
            },
          );
        },
      ),
    );
  }
}