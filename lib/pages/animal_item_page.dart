import 'package:familylost_faan/Screen/Sign_In_Up/sign_in.dart';
import 'package:familylost_faan/ServiciosApp/dto/animal.dart';
import 'package:familylost_faan/ServiciosApp/dto/author.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:familylost_faan/ServiciosApp/services/home_service.dart';
import 'package:familylost_faan/pages/detalles_animal.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimalItemPage extends StatefulWidget {
  const AnimalItemPage({
    super.key,
    required this.image,
    required this.animalData,
    required this.author,
    required this.post,
    required this.isLogin,
    required this.provider,
  });

  final String image;
  final Animal animalData;
  final Author author;
  final SavePost post;
  final bool isLogin;
  final HomePageProvider provider;

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
            builder: (context) => widget.isLogin
                ? DetallesAnimal(
                    image: widget.image,
                    animalData: widget.animalData,
                    author: widget.author,
                    post: widget.post,
                    provider: widget.provider,
                  )
                : SignIn(),
          ),
        );
      },
      child: Container(
        color: Colors.white,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
                width: _deviceWidth * 0.3,
                height: _deviceHeight * 0.2,
              ),
              /*MICHIS*/
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.post.title,
                        style: AppFonts.TitlePost,
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        widget.animalData.name,
                        style: AppFonts.InputTitlePost,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.secondaryColor,
                            size: 21.0,
                          ),
                          Text(
                            'Cuenca',
                            style: AppFonts.caption,
                          ),
                        ],
                      ),
                      TextButton.icon(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          minimumSize: MaterialStateProperty.all(Size(0, 0)),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: MaterialStateProperty.all(
                            AppColors.transparentBackgroundColor,
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            _isContactButtonPressed = !_isContactButtonPressed;
                          });
                          if (widget.isLogin) {
                            await launchUrl(
                              Uri.parse(
                                "https://wa.me/${widget.author.phone}?text=Hola yo vi a ${widget.animalData.name}",
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.phone,
                          color: AppColors.whatsAppGreen,
                          size: 16.0,
                        ),
                        label: Text(
                          AppStrings.labelContact,
                          style: AppFonts.caption.copyWith(
                            color: AppColors.whatsAppGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
