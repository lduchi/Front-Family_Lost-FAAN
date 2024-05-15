import 'package:familylost_faan/ServiciosApp/models/image.dart';

class Photo {
  final String id;
  final String fileName;
  final Image? image;
  final String fileType;
  final DateTime createdAt;
  final String imageHash;

  Photo({
    required this.id,
    required this.fileName,
    required this.image,
    required this.fileType,
    required this.createdAt,
    required this.imageHash,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      fileName: json['fileName'] as String,
      image: Image.fromJson(json['image']),
      fileType: json['fileType'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      imageHash: json['imageHash'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
      'image': image!.toJson(),
      'fileType': fileType,
      'createdAt': createdAt.toIso8601String(),
      'imageHash': imageHash,
    };
  }
}