import 'package:familylost_faan/ServiciosApp/models/animal.dart';
import 'package:familylost_faan/Utils/colors.dart';
import 'package:familylost_faan/pages/animal_item_page.dart';
import 'package:familylost_faan/utilities/AssetManager/asset_manager.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  //cambiar pa' json
  final Animal animalData;

  const HomePage({Key? key, required this.animalData}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _deviceHeight;
  var _deviceWidth;

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
    print(widget.animalData.ubicacion);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.animalData.ubicacion);

    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      child: CustomScrollView(
        slivers: [
          _horizontalCardsList(),
          _titleHandler(),
          _verticalCardList(),
        ],
      ),
    );
  }

  Widget _titleHandler() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          '!El regreso a casa comienza aqui!',
          style: AppFonts.primary,
        ),
      ),
    );
  }

  //List of vertical cards with the animals information
  Widget _verticalCardList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final String image = AssetManager.exampleImage;
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
                ),
              ),
            ),
          );
        },
        childCount: 6,
      ),
    );
  }

  //List of horizontal cards with the animals information
  SliverToBoxAdapter _horizontalCardsList() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: _deviceHeight * 0.3,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            final String image = AssetManager.exampleImage2;
            final String text =
                'Hola, soy Pepito! \nMe perdi el dia 24/12/2021 cerca del Batan Shopping ¡Ayudame volver a casa! ';

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: _cardList(image, text),
              ),
            );
          },
        ),
      ),
    );
  }

  Card _cardList(String image, String text) {
    return Card(
      child: Container(
        width: _deviceWidth * 0.95,
        height: _deviceHeight * 0.2,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: _deviceHeight * 0.16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.start,
                    style: AppFonts.caption.copyWith(
                      fontSize: 15.5,
                      color: textColor1,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 167,
              right: 1,
              child: IconButton(
                onPressed: () {
                  // Handle button press
                },
                icon: Icon(Icons.add_circle,
                    color: AppColors.mainColor, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

//Scroll position widget - Not implemented yet because needs API data
  Widget _scrollPositionWidget() {
    return SizedBox(
      height: _deviceHeight * 0.1,
      width: _deviceWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO: Implement this widget
        ],
      ),
    );
  }
}
