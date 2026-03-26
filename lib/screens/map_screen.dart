import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<String> _timeFilters = ['Hoy', 'Semana', 'Histórico'];
  String _selectedFilter = 'Semana';

  final List<_SightingPoint> _allSightings = [
    _SightingPoint(
      title: 'Águila Real',
      subtitle: 'Dolores Hidalgo · Hace 2 horas',
      category: 'Ave',
      location: const LatLng(21.1561, -100.9325),
    ),
    _SightingPoint(
      title: 'Lobo Mexicano',
      subtitle: 'Sierra Gorda · Ayer',
      category: 'Mamífero',
      location: const LatLng(21.3500, -100.3000),
    ),
    _SightingPoint(
      title: 'Nopal',
      subtitle: 'León · Esta semana',
      category: 'Planta',
      location: const LatLng(21.1250, -101.6850),
    ),
    _SightingPoint(
      title: 'Ajolote',
      subtitle: 'Zona lacustre · Histórico',
      category: 'Anfibio',
      location: const LatLng(20.9100, -100.7430),
    ),
  ];

  List<_SightingPoint> get _filteredSightings {
    switch (_selectedFilter) {
      case 'Hoy':
        return _allSightings.take(1).toList();
      case 'Semana':
        return _allSightings.take(3).toList();
      case 'Histórico':
      default:
        return _allSightings;
    }
  }

  Color _categoryColor(String category) {
    switch (category) {
      case 'Ave':
        return const Color(0xFF1565C0);
      case 'Mamífero':
        return const Color(0xFF6D4C41);
      case 'Anfibio':
        return const Color(0xFF00897B);
      case 'Planta':
        return const Color(0xFF2E7D32);
      default:
        return const Color(0xFF2E7D32);
    }
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'Ave':
        return Icons.air;
      case 'Mamífero':
        return Icons.pets;
      case 'Anfibio':
        return Icons.water;
      case 'Planta':
        return Icons.local_florist;
      default:
        return Icons.place;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sightings = _filteredSightings;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF1B5E20),
                  Color(0xFF43A047),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.map_outlined,
                  color: Colors.white,
                  size: 34,
                ),
                SizedBox(height: 12),
                Text(
                  'Mapa de avistamientos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Visualiza reportes simulados en distintas zonas de Guanajuato. Más adelante se conectarán con Firestore.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _timeFilters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final filter = _timeFilters[index];
                final isSelected = filter == _selectedFilter;

                return FilterChip(
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                  showCheckmark: false,
                  label: Text(filter),
                  selectedColor: const Color(0xFF2E7D32).withOpacity(0.18),
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(21.0190, -101.2574),
                    initialZoom: 8.0,
                    interactionOptions: InteractionOptions(
                      flags: InteractiveFlag.all,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.especies_guanajuato',
                    ),
                    MarkerLayer(
                      markers: sightings.map((item) {
                        return Marker(
                          point: item.location,
                          width: 90,
                          height: 90,
                          child: _MapMarker(
                            color: _categoryColor(item.category),
                            icon: _categoryIcon(item.category),
                            onTap: () => _showSightingSheet(context, item),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Resumen visual',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _LegendItem(
                      color: const Color(0xFF1565C0),
                      label: 'Aves',
                    ),
                    _LegendItem(
                      color: const Color(0xFF6D4C41),
                      label: 'Mamíferos',
                    ),
                    _LegendItem(
                      color: const Color(0xFF00897B),
                      label: 'Anfibios',
                    ),
                    _LegendItem(
                      color: const Color(0xFF2E7D32),
                      label: 'Plantas',
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'Mostrando ${sightings.length} avistamientos simulados para el filtro "$_selectedFilter".',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSightingSheet(BuildContext context, _SightingPoint item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: _categoryColor(item.category)
                        .withOpacity(0.14),
                    child: Icon(
                      _categoryIcon(item.category),
                      color: _categoryColor(item.category),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                item.subtitle,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  item.category,
                  style: const TextStyle(
                    color: Color(0xFF1B5E20),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        );
      },
    );
  }
}

class _MapMarker extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _MapMarker({
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.30),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

class _SightingPoint {
  final String title;
  final String subtitle;
  final String category;
  final LatLng location;

  const _SightingPoint({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.location,
  });
}