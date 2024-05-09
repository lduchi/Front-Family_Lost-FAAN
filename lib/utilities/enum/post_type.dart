import 'package:familylost_faan/utilities/texts/app_strings.dart';

enum PostType { LOST, FOUND, ADOPTION }

extension PostTypeExtension on PostType {
  String get value {
    switch (this) {
      case PostType.LOST:
        return AppStrings.navigationLost;
      case PostType.FOUND:
        return AppStrings.navigationFound;
      case PostType.ADOPTION:
        return AppStrings.navigationAdoption;
    }
  }
}
