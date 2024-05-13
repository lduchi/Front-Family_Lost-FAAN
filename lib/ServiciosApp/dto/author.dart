import 'dart:convert';
import 'dart:typed_data';

class Author {
  BigInt id;
  String name;
  String email;
  String phone;
  Uint8List? data;

  Author({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.data,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: BigInt.parse(json['id'].toString()),
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      data: json['data'] != null ? base64Decode(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['data'] = this.data;
    return data;
  }
}