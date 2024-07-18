import 'package:familylost_faan/ServiciosApp/dto/animal.dart';
import 'package:familylost_faan/ServiciosApp/dto/author.dart';
import 'package:familylost_faan/ServiciosApp/dto/geo_json.dart';

class SavePost {
  String? id;
  String title;
  String? additionalComment;
  String typePost;
  Author author;
  Animal animal;
  GeoJson location;
  String state;
  String imagePath;
  String imageUrl;
  DateTime? date;
  List<String>? likes;

  SavePost({
    this.id,
    required this.title,
    this.additionalComment,
    required this.typePost,
    required this.author,
    required this.animal,
    required this.location,
    required this.state,
    this.date,
    this.imagePath = '',
    this.imageUrl = '',
    this.likes,
  });

  factory SavePost.fromJson(Map<String, dynamic> json) {
    return SavePost(
      id: json['id'],
      title: json['title'],
      additionalComment: json['additionalComment'],
      typePost: json['typePost'],
      author: Author.fromJson(json['author']),
      animal: Animal.fromJson(json['animal']),
      location: GeoJson.fromJson(json['location']),
      state: json.containsKey('state') ? json['state'] : '',
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      imagePath: json['imagePath'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      likes: json['likes'] != null
          ? List<String>.from(json['likes'].map((x) => x))
          : List.empty(growable: true),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'additionalComment': additionalComment,
      'typePost': typePost,
      'author': author.toJson(),
      'animal': animal.toJson(),
      'location': location.toJson(),
      'state': state,
      'date': date?.toIso8601String(),
      'imagePath': imagePath,
      'imageUrl': imageUrl,
      'likes': likes,
    };
  }
}
