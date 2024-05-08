import 'package:familylost_faan/pages/animal_item_page.dart';
import 'package:familylost_faan/utilities/AssetManager/asset_manager.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
  }

  @override
  Widget build(BuildContext context) {
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
          'Animales',
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {},
                child: AnimalItemPage(
                  image: image,
                ),
              ),
            ),
          );
        },
        childCount: 5, //TODO: Change this to the number of items
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
          itemCount: 10, //TODO: Change this to the number of items
          itemBuilder: (context, index) {
            final String image = AssetManager.exampleImage2;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: _cardList(image),
              ),
            );
          },
        ),
      ),
    );
  }

  Card _cardList(String image) {
    return Card(
      child: Container(
        width: _deviceWidth * 0.95,
        height: _deviceHeight * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Nombre Animal',
                      style: AppFonts.primary.copyWith(
                        color: AppColors.secondaryMainColor,
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
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
