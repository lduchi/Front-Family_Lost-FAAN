import 'dart:convert';
import 'dart:typed_data';

import 'package:familylost_faan/ServiciosApp/dto/animal.dart';
import 'package:familylost_faan/ServiciosApp/dto/author.dart';
import 'package:familylost_faan/ServiciosApp/dto/geo_json.dart';

class SavePost {
  String id;
  String title;
  String authorComment;
  String typePost;
  Author author;
  Animal animal;
  GeoJson location;
  String state;
  Uint8List? data;

  SavePost({
    required this.id,
    required this.title,
    required this.authorComment,
    required this.typePost,
    required this.author,
    required this.animal,
    required this.location,
    required this.state,
    this.data,
  });

  factory SavePost.fromJson(Map<String, dynamic> json) {
    return SavePost(
      id: json['id'],
      title: json['title'],
      authorComment: json['authorComment'],
      typePost: json['typePost'],
      author: Author.fromJson(json['author']),
      animal: Animal.fromJson(json['animal']),
      location: GeoJson.fromJson(json['location']),
      state: json['state'],
      data: json['data'] != null ? base64Decode(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authorComment': authorComment,
      'typePost': typePost,
      'author': author.toJson(),
      'animal': animal.toJson(),
      'location': location.toJson(),
      'state': state,
      'data': data,
    };
  }
}