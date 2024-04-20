import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/fonts/app_fonts.dart';
import 'package:familylost_faan/utilities/icons/app_icons.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';

class AnimalItemPage extends StatefulWidget {
  const AnimalItemPage({super.key, required this.image});

  final String image;

  @override
  _AnimalItemPageState createState() => _AnimalItemPageState();
}

class _AnimalItemPageState extends State<AnimalItemPage> {
  bool _isContactButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Hero(
        tag: widget.image,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
                image: DecorationImage(
                  image: AssetImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
              width: 120, // Ajusta el ancho según tus necesidades
              height: 150, // Ajusta la altura según tus necesidades
            ),
            const SizedBox(width: 16), // Espacio entre la imagen y el texto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre Animal',
                    style: AppFonts.title,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Raza Animal',
                    style: AppFonts.secondary,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcons.locationIcon,
                      const SizedBox(width: 2),
                      Text(
                        AppStrings.labelLocation,
                        style: AppFonts.secondary,
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
                          AppColors.transparentBackgroundColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          AppIcons.whatsAppIcon.icon,
                          color: AppColors
                              .whatsAppGreen, // Aplicando el color deseado al icono
                        ),
                        const SizedBox(width: 4),
                        Text(
                          AppStrings.labelContact,
                          style: AppFonts.contact.copyWith(
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
