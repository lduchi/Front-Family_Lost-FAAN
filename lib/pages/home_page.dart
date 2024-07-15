import 'package:familylost_faan/ServiciosApp/dto/animal.dart';
import 'package:familylost_faan/Utils/colors.dart';
import 'package:familylost_faan/pages/animal_item_page.dart';
import 'package:familylost_faan/utilities/AssetManager/asset_manager.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Animal animalData;
  final bool isLogin;

  const HomePage({Key? key, required this.animalData,required this.isLogin}) : super(key: key);

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
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    return ListView.builder(
      itemCount: 7,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final String image = AssetManager.exampleImage;
        if (index == 0) {
          final String image = AssetManager.exampleImage2;
          final String title = 'Hola, soy Pepito!';
          final String description =
              'Me perdi el dia 24/12/2021 cerca del Batan Shopping ¡Ayudame volver a casa! ';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _cardList(image, description, title,widget.isLogin),
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(),
              child: InkWell(
                onTap: () {},
                child: AnimalItemPage(
                  image: image,
                  animalData: widget.animalData,
                  isLogin:widget.isLogin,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Card _cardList(String image, String description, String title, bool isLogin) {
    return Card(
      elevation: 10,
      child: Column(
        children: [
          Container(
            height: _deviceHeight * 0.20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: AssetImage(image),
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
    );
  }
}
