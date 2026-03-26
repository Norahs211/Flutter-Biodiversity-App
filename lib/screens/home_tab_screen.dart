import 'package:flutter/material.dart';

import '../data/species_data.dart';
import '../widgets/category_chip_list.dart';
import '../widgets/recent_sightings_carousel.dart';
import '../widgets/species_card.dart';
import 'species_detail_screen.dart';
import 'species_explore_screen.dart';

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final featuredSpecies = speciesList.take(3).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeroWelcomeCard(),
          const SizedBox(height: 20),
          TextField(
            readOnly: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SpeciesExploreScreen(),
                ),
              );
            },
            decoration: InputDecoration(
              hintText: 'Buscar especies, categorías o hábitats',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.tune),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Categorías',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const CategoryChipList(),
          const SizedBox(height: 22),
          const Text(
            'Avistamientos recientes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const RecentSightingsCarousel(),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Especies destacadas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SpeciesExploreScreen(),
                    ),
                  );
                },
                child: const Text('Ver todo'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...featuredSpecies.map(
            (species) => SpeciesCard(
              species: species,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SpeciesDetailScreen(species: species),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroWelcomeCard extends StatelessWidget {
  const _HeroWelcomeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1B5E20),
            Color(0xFF43A047),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.forest,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(height: 14),
          Text(
            'Explora la biodiversidad de Guanajuato',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.bold,
              height: 1.15,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Descubre especies, consulta información útil y registra avistamientos de manera sencilla.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}