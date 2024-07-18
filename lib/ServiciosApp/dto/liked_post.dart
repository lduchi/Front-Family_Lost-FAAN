import 'package:familylost_faan/ServiciosApp/dto/author.dart';

class LikedPost {
  String postId;
  Author? author;

  LikedPost({required this.postId, this.author});

  factory LikedPost.fromJson(Map<String, dynamic> json) {
    return LikedPost(
      postId: json['postId'],
      author: Author.fromJson(json['author']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'author': author!.toJson(),
    };
  }

  @override
  String toString() {
    return 'postId: $postId, author: $author';
  }
}