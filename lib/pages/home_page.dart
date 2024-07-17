import 'package:familylost_faan/Screen/Sign_In_Up/sign_in.dart';
import 'package:familylost_faan/ServiciosApp/dto/animal.dart';
import 'package:familylost_faan/ServiciosApp/dto/author.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/services/home_service.dart';
import 'package:familylost_faan/Utils/colors.dart';
import 'package:familylost_faan/pages/animal_item_page.dart';
import 'package:familylost_faan/pages/detalles_animal.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final bool isLogin;

  const HomePage({Key? key, required this.isLogin}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _deviceHeight;

  ButtonStyle enabledFilledButtonStyle(bool selected, ColorScheme colors) {
    return IconButton.styleFrom(
      foregroundColor: selected ? colors.onPrimary : colors.primary,
      backgroundColor: selected ? colors.primary : colors.surfaceVariant,
      disabledForegroundColor: colors.onSurface.withOpacity(0.38),
      disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
      hoverColor: selected
          ? colors.onPrimary.withOpacity(0.08)
          : colors.primary.withOpacity(0.08),
      focusColor: selected
          ? colors.onPrimary.withOpacity(0.12)
          : colors.primary.withOpacity(0.12),
      highlightColor: selected
          ? colors.onPrimary.withOpacity(0.12)
          : colors.primary.withOpacity(0.12),
    );
  }

  @override
  void initState() {
    super.initState();
    Store.getAccessToken;
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    return Consumer<HomePageProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.result.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == 0) {
              final String image = provider.result[index].imageUrl;
              final String title =
                  'Hola, soy ${provider.result[index].animal.name}!';
              final String description =
                  'Me perdi el día ${provider.result[index].date?.day}/${provider.result[index].date?.month}/${provider.result[index].date?.year} ¡Ayúdame a volver a casa!';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _cardList(
                      image,
                      description,
                      title,
                      widget.isLogin,
                      provider.result[index].animal,
                      provider.result[index].author,
                      provider.result[index],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      '!El regreso a casa comienza aqui!',
                      style: AppFonts.primary.copyWith(fontSize: 19.0),
                    ),
                  ),
                ],
              );
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(),
                  child: AnimalItemPage(
                    image: provider.result[index].imageUrl,
                    animalData: provider.result[index].animal,
                    author: provider.result[index].author,
                    isLogin: widget.isLogin,
                    post: provider.result[index],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _cardList(String image, String description, String title, bool isLogin,
      Animal animalData, Author author, SavePost post) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.isLogin
                ? DetallesAnimal(
                    image: image,
                    animalData: animalData,
                    author: author,
                    post: post,
                  )
                : SignIn(),
          ),
        );
      },
      child: Card(
        elevation: 10,
        child: Column(
          children: [
            Container(
              height: _deviceHeight * 0.20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            title,
                            style: AppFonts.title.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: textColor1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            description,
                            style: AppFonts.caption.copyWith(
                              fontSize: 15.5,
                              color: textColor1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle button press
                    },
                    icon: Icon(
                      Icons.add_circle,
                      color: AppColors.mainColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
