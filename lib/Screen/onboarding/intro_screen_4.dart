import 'package:flutter/material.dart';

class LastIntroScreen extends StatefulWidget {
  final Function(String) onLanguageSelected;

  const LastIntroScreen({Key? key, required this.onLanguageSelected}) : super(key: key);

  @override
  _LastIntroScreenState createState() => _LastIntroScreenState();
}

class _LastIntroScreenState extends State<LastIntroScreen> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;

    double padding = _deviceWidth * 0.1;
    double titleFontSize = _deviceWidth * 0.06;
    double textFontSize = _deviceWidth * 0.04;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: _deviceHeight * 0.05),
              Text(
                'Selecciona tu lenguaje preferido',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Utilizarás este lenguaje en la aplicación',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: textFontSize,
                ),
              ),
              SizedBox(height: 20),
              _buildLanguageOption('🇺🇸', 'English', 'en'),
              SizedBox(height: 10),
              _buildLanguageOption('🇪🇸', 'Español', 'es'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String flag, String language, String prefix) {
    bool isSelected = selectedLanguage == language;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = language;
        });
        widget.onLanguageSelected(prefix);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF4CAF50) : Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(flag, style: TextStyle(fontSize: 24)),
            SizedBox(width: 16),
            Text(
              language,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Spacer(),
            if (isSelected)
              Icon(Icons.check, color: Colors.white),
          ],
        ),
      ),
    );
  }
}