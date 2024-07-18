import 'package:familylost_faan/ServiciosApp/services/search_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchService>(context);

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,

            decoration: InputDecoration(
              hintText: 'Buscar...',
              contentPadding: EdgeInsets.all(5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey),
              ),
         //     prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            FocusScope.of(context).unfocus();
            searchProvider.setSearchTerm(_searchController.text);
            await searchProvider.performSearch();
          },

        ),
      ],
    );
  }
}
