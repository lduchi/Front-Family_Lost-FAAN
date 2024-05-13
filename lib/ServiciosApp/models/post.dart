import 'package:familylost_faan/ServiciosApp/dto/animal.dart';
import 'package:familylost_faan/ServiciosApp/models/photo.dart';
import 'package:familylost_faan/ServiciosApp/models/user.dart';
import 'package:familylost_faan/utilities/enum/post_type.dart';
import 'package:familylost_faan/utilities/enum/state_post.dart';

class Post {
  String id;
  String title;
  String authorComment;
  DateTime createAt;
  List<int> likes;
  Animal animal;
  String location;
  StatePost state;
  PostType type;
  Photo photo;
  User author;

  Post({
    required this.id,
    required this.title,
    required this.authorComment,
    required this.createAt,
    required this.likes,
    required this.animal,
    required this.location,
    required this.state,
    required this.type,
    required this.photo,
    required this.author,
  });
}