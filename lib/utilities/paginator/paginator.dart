class Paginator<T> {
  final Future<List<T>> Function(int page) fetchPage;
  final List<T> items = [];
  int currentPage = 0;
  bool isLoading = false;
  bool hasMoreItems = true;

  Paginator({required this.fetchPage});

  Future<void> loadNextPage() async {
    if (isLoading || !hasMoreItems) return;

    isLoading = true;
    final newItems = await fetchPage(currentPage);

    if (newItems.isEmpty) {
      hasMoreItems = false;
    } else {
      currentPage++;
      items.addAll(newItems);
    }

    isLoading = false;
  }

  void reset() {
    items.clear();
    currentPage = 0;
    isLoading = false;
    hasMoreItems = true;
  }
}
