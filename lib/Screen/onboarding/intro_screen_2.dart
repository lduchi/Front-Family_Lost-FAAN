import 'package:familylost_faan/Utils/colors.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:flutter/material.dart';

class SecondIntroScreen extends StatefulWidget {
  const SecondIntroScreen({Key? key}) : super(key: key);

  @override
  _SecondIntroScreenState createState() => _SecondIntroScreenState();
}

class _SecondIntroScreenState extends State<SecondIntroScreen> {
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
              '¡Family Lost!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: _deviceHeight * 0.02),
            Image.asset(
              'images/second_intro.png',
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
              "Family Lost FANN es una aplicación que te permite registrar a tu mascota y ayudar a encontrar a las mascotas perdidas de tu comunidad.",
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
