import 'package:familylost_faan/Utils/colors.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:flutter/material.dart';

class FirstIntroScreen extends StatefulWidget {
  const FirstIntroScreen({Key? key}) : super(key: key);

  @override
  _FirstIntroScreenState createState() => _FirstIntroScreenState();
}

class _FirstIntroScreenState extends State<FirstIntroScreen> {
  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;

    double padding = _deviceWidth * 0.1;
    double imageHeight = _deviceHeight * 0.35;
    double titleFontSize = _deviceWidth * 0.06;
    double textFontSize = _deviceWidth * 0.04;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: _deviceHeight * 0.13,
            horizontal: padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '¡Bienvenido!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: _deviceHeight * 0.02),
            Image.asset(
              'images/first_intro.png',
              height: imageHeight,
            ),
            SizedBox(height: _deviceHeight * 0.02),
            Text(
              'Un objetivo en común',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: _deviceHeight * 0.02),
            Text(
              "Cada mascota merece experimentar el amor y la alegría de un hogar. Únete a nosotros en nuestra misión de hacer que eso se convierta en una realidad para cada uno de ellos.",
              textAlign: TextAlign.center,
              style: AppFonts.caption.copyWith(
                fontSize: textFontSize,
                color: textColor2,
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
