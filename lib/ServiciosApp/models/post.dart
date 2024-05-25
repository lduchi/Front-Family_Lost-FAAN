import 'package:familylost_faan/ServiciosApp/dto/animal.dart';
import 'package:familylost_faan/ServiciosApp/dto/geo_json.dart';
import 'package:familylost_faan/ServiciosApp/models/user.dart';
import 'package:familylost_faan/utilities/enum/post_type.dart';
import 'package:familylost_faan/utilities/enum/state_post.dart';

class Post {
  String id;
  String title;
  String additionalComment;
  DateTime createAt;
  DateTime date;
  List<String> likes;
  Animal animal;
  GeoJson location;
  StatePost state;
  PostType type;
  String imagePath;
  String imageUrl;
  User author;

  Post({
    required this.id,
    required this.title,
    required this.additionalComment,
    required this.createAt,
    required this.date,
    required this.likes,
    required this.animal,
    required this.location,
    required this.state,
    required this.type,
    this.imagePath = '',
    this.imageUrl = '',
    required this.author,
  });
}