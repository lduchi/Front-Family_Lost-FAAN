enum AnimalType {
  Dog,
  Cat,
  Bird,
  Rabbit,
  Hamster,
  GuineaPig,
  Turtle,
  Ferret,
  Chinchilla,
  Other,
}

class AnimalList {
  final String name;
  final List<String> breeds;

  AnimalList({required this.name, required this.breeds});
}

List<AnimalList> animalLists = [
  AnimalList(
    name: 'Dog',
    breeds: [
      'Labrador Retriever',
      'Pastor Alemán',
      'Golden Retriever',
      'Bulldog Francés',
      'Beagle',
      'Poodle',
      'Rottweiler',
      'Boxer',
      'Chihuahua',
      'Dálmata',
    ],
  ),
  AnimalList(
    name: 'Cat',
    breeds: [
      'Siamés',
      'Persa',
      'Maine Coon',
      'Bengalí',
      'Esfinge',
      'Ragdoll',
      'Británico de Pelo Corto',
      'Exotic Shorthair',
      'Siberiano',
      'Birmano',
    ],
  ),
/*  AnimalList(
    name: 'Bird',
    breeds: [
      'Canario',
      'Periquito',
      'Agaporni',
      'Loro Gris Africano',
      'Cacatúa',
      'Guacamayo',
      'Cotorra',
      'Diamante Mandarín',
      'Ninfas',
      'Pinzones',
    ],
  ),
  AnimalList(
    name: 'Rabbit',
    breeds: [
      'Holandés Enano',
      'Mini Rex',
      'Himalayo',
      'Gigante de Flandes',
      'Lionhead',
      'Angora',
      'Chinchilla',
      'Hotot',
      'Mini Lop',
      'Belier',
    ],
  ),
  AnimalList(
    name: 'Hamster',
    breeds: [
      'Dorado',
      'Sirio',
      'Ruso',
      'Chino',
      'Roborovski',
      'Campestre',
      'Enano de Pomerania',
      'Anillado',
      'Chino de Vientre Dorado',
      'Chino de Campbell',
    ],
  ),
  AnimalList(
    name: 'Guinea Pig',
    breeds: [
      'Peruano',
      'Americano',
      'Teddy',
      'Abisinio',
      'Coronet',
      'Silkie',
      'Merino',
      'Texel',
      'Alpaca',
      'Shelty',
    ],
  ),
  AnimalList(
    name: 'Turtle',
    breeds: [
      'Tortuga de Orejas Rojas',
      'Tortuga de Caja',
      'Tortuga Pintada',
      'Tortuga Mapa',
      'Tortuga Acuática',
      'Tortuga Terrestre',
      'Tortuga Griega',
      'Tortuga Rusa',
      'Tortuga Espolón',
      'Tortuga Diamante',
    ],
  ),
  AnimalList(
    name: 'Ferret',
    breeds: [
      'Hurón Americano',
      'Hurón Europeo',
      'Hurón Sable',
      'Hurón Albino',
      'Hurón de Patas de Marta',
      'Hurón de Patas de Oso',
      'Hurón Angora',
      'Hurón Tostado',
      'Hurón Negro',
      'Hurón de Vientre Blanco',
    ],
  ),
  AnimalList(
    name: 'Chinchilla',
    breeds: [
      'Chinchilla Gris',
      'Chinchilla Beige',
      'Chinchilla Blanca',
      'Chinchilla Lince',
      'Chinchilla Mosqueada',
      'Chinchilla Hetero Beige',
      'Chinchilla Hetero Ebony',
      'Chinchilla Heterocigota',
      'Chinchilla Wilson White',
      'Chinchilla Royal Persian',
    ],
  ),*/
  AnimalList(
    name: 'Other',
    breeds: [
      'Other',
    ],
  ),
];
