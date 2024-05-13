enum StatePost { LOST, FOUND }

extension StatePostExtension on StatePost {
  String get value {
    switch (this) {
      case StatePost.LOST:
        return 'LOST';
      case StatePost.FOUND:
        return 'FOUND';
    }
  }
}