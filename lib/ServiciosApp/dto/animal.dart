class Animal {
  String name;
  String type;
  String race;
  String gender;

  Animal({
    required this.name,
    required this.type,
    required this.race,
    required this.gender,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      name: json['name'],
      type: json['type'],
      race: json['race'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'race': race,
      'gender': gender,
    };
  }
}