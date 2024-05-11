import 'dart:convert';
import 'dart:typed_data';

class Photo {
  final String id;
  final String fileName;
  final Uint8List image;
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
      image: base64Decode(json['image'] as String),
      fileType: json['fileType'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      imageHash: json['imageHash'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
      'image': base64Encode(image),
      'fileType': fileType,
      'createdAt': createdAt.toIso8601String(),
      'imageHash': imageHash,
    };
  }
}