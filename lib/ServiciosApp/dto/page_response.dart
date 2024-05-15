class PageResponse {
  final int totalPages;
  final int totalElements;
  final int number;
  final int size;
  final bool first;
  final bool last;
  final List<dynamic> content;

  PageResponse({
    required this.totalPages,
    required this.totalElements,
    required this.number,
    required this.size,
    required this.first,
    required this.last,
    required this.content,
  });

  factory PageResponse.fromJson(Map<String, dynamic> json) {
    return PageResponse(
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
      number: json['number'],
      size: json['size'],
      first: json['first'],
      last: json['last'],
      content: json['content'],
    );
  }
}
