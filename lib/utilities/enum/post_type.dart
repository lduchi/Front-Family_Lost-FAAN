import 'package:familylost_faan/utilities/texts/app_strings.dart';

enum PostType { lost, found, adoption }

extension PostTypeExtension on PostType {
  String get value {
    switch (this) {
      case PostType.lost:
        return AppStrings.navigationLost;
      case PostType.found:
        return AppStrings.navigationFound;
      case PostType.adoption:
        return AppStrings.navigationAdoption;
    }
  }
}
