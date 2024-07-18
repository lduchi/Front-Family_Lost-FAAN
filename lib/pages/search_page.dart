import 'package:familylost_faan/ServiciosApp/services/search_service.dart';
import 'package:familylost_faan/pages/animal_item_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchService>(
      builder: (context, searchProvider, child) {
        final searchTerm = searchProvider.searchTerm;
        final searchResults = searchProvider.searchResults;
        final isLoading = searchProvider.isLoading;

        if (isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (searchTerm.isEmpty && searchResults.isEmpty) {
          return Center(child: Text('Buscanos aquí'));
        }

        if (searchResults.isNotEmpty) {
          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final item = searchResults[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(),
                  child: AnimalItemPage(
                    image: item.imageUrl,
                    animalData: item.animal,
                    author: item.author,
                    isLogin: true,
                    post: item,
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
                textAlign: TextAlign.center,
                'No hemos encontrado ninguna mascota con ese parámetro de busqueda'),
          ));
        }
      },
    );
  }
}
