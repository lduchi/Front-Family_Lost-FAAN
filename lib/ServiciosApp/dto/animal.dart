class Animal {
  String name;
  String type;
  String race;
  String gender;
  DateTime? date;

  Animal({
    required this.name,
    required this.type,
    required this.race,
    required this.gender,
    this.date,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      name: json['name'],
      type: json['type'],
      race: json['race'],
      gender: json['race'],
      date: json['disappearanceDate'] != null
          ? DateTime.parse(json['disappearanceDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'race': race,
      'gender': gender,
      'disappearanceDate': date?.toIso8601String(),
    };
  }
}