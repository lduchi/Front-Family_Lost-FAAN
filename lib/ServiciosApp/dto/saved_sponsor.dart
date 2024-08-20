class SavedSponsor {
  String? id;
  String name;
  String imageUrl;
  String? website;

  SavedSponsor({
    this.id,
    required this.name,
    required this.imageUrl,
    this.website,
  });

  factory SavedSponsor.fromJson(Map<String, dynamic> json) {
    return SavedSponsor(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'website': website,
    };
  }
}