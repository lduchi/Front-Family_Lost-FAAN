import 'package:familylost_faan/ServiciosApp/models/animal.dart';
import 'package:familylost_faan/pages/detalles_animal.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:familylost_faan/utilities/icons/app_icons.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';

class AnimalItemPage extends StatefulWidget {
  const AnimalItemPage({super.key, required this.image, required this.animalData, });

  final String image;
  final Animal animalData;

  @override
  _AnimalItemPageState createState() => _AnimalItemPageState();
}

class _AnimalItemPageState extends State<AnimalItemPage> {
  var _deviceHeight;
  var _deviceWidth;
  bool _isContactButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    //Se llama para mostrar pantalla

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetallesAnimal(image: widget.image)),
        );
      },
      /*onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetallesAnimal(image: widget.image),
          ),
        );
      },*/
      child: Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                image: DecorationImage(
                  image: AssetImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
              width: _deviceWidth * 0.3,
              height: _deviceHeight * 0.2,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.animalData.nombre,
                    style: AppFonts.title,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.animalData.raza,
                    style: AppFonts.primary,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcons.locationIcon,
                      const SizedBox(width: 2),
                      Text(
                        widget.animalData.ubicacion,
                        style: AppFonts.primary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isContactButtonPressed = !_isContactButtonPressed;
                      });
                      // TODO: Implement contact action
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                        AppColors.transparentBackgroundColor,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          AppIcons.whatsAppIcon.icon,
                          color: AppColors.whatsAppGreen,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          AppStrings.labelContact,
                          style: AppFonts.caption.copyWith(
                            color: AppColors.whatsAppGreen,
                          ),
                        ),
                      ],
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
