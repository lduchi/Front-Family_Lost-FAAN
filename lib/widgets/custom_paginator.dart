import 'package:familylost_faan/utilities/paginator/paginator.dart';
import 'package:flutter/material.dart';

class PaginatedGridView<T> extends StatefulWidget {
  final Paginator<T> paginator;
  final Widget Function(BuildContext context, T item) itemBuilder;

  const PaginatedGridView({
    Key? key,
    required this.paginator,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  State<PaginatedGridView<T>> createState() => _PaginatedGridViewState<T>();
}

class _PaginatedGridViewState<T> extends State<PaginatedGridView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    widget.paginator.loadNextPage();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !widget.paginator.isLoading) {
      widget.paginator.loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: widget.paginator.items.length,
      itemBuilder: (BuildContext context, int index) {
        return widget.itemBuilder(context, widget.paginator.items[index]);
      },
    );
  }
}

class PaginatedListView<T> extends StatefulWidget {
  final Paginator<T> paginator;
  final Widget Function(BuildContext context, T item) itemBuilder;

  const PaginatedListView({
    Key? key,
    required this.paginator,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    widget.paginator.loadNextPage();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !widget.paginator.isLoading) {
      widget.paginator.loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.paginator.items.length,
      itemBuilder: (BuildContext context, int index) {
        return widget.itemBuilder(context, widget.paginator.items[index]);
      },
    );
  }
}
