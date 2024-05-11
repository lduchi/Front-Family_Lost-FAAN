import 'dart:convert';
import 'dart:typed_data';

class Image {
  final int type;
  final Uint8List data;

  Image({
    required this.type,
    required this.data,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    final dataString = json['data'] as String;
    final bytes = base64Decode(dataString);
    return Image(
      type: json['type'] as int,
      data: Uint8List.fromList(bytes),
    );
  }

  Map<String, dynamic> toJson() {
    final dataString = base64Encode(data);
    return {
      'type': type,
      'data': dataString,
    };
  }
}