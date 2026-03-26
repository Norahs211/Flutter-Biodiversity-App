import '../models/species.dart';

final List<Species> speciesList = [
  Species(
    name: 'Lobo Mexicano',
    scientificName: 'Canis lupus baileyi',
    category: 'Mamífero',
    description:
        'Subespecie de lobo nativa de México. Es una de las especies más representativas de los esfuerzos de conservación.',
    image: 'assets/images/lobo_mexicano.jpg',
    habitat: 'Bosques templados y zonas montañosas',
    funFact:
        'El lobo mexicano estuvo al borde de la extinción y ha sido parte de programas de reintroducción.',
  ),
  Species(
    name: 'Águila Real',
    scientificName: 'Aquila chrysaetos',
    category: 'Ave',
    description:
        'Ave rapaz emblemática de gran tamaño, presente en distintas regiones de México.',
    image: 'assets/images/aguila_real.jpg',
    habitat: 'Montañas, pastizales y zonas abiertas',
    funFact:
        'Es uno de los símbolos nacionales más reconocibles de México.',
  ),
  Species(
    name: 'Ajolote',
    scientificName: 'Ambystoma mexicanum',
    category: 'Anfibio',
    description:
        'Anfibio famoso por su capacidad de regeneración y por su enorme valor biológico.',
    image: 'assets/images/ajolote.jpg',
    habitat: 'Lagos y canales de agua dulce',
    funFact:
        'Puede regenerar extremidades, tejidos e incluso partes de algunos órganos.',
  ),
  Species(
    name: 'Nopal',
    scientificName: 'Opuntia ficus-indica',
    category: 'Planta',
    description:
        'Planta característica de México, importante cultural y ecológicamente.',
    image: 'assets/images/nopal.jpg',
    habitat: 'Zonas áridas y semiáridas',
    funFact:
        'Además de su valor alimenticio, ofrece refugio y alimento a diversas especies.',
  ),
];