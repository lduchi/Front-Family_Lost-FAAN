import 'package:familylost_faan/ServiciosApp/dto/saved_sponsor.dart';
import 'package:familylost_faan/ServiciosApp/services/sponsor_service.dart';
import 'package:familylost_faan/Utils/colors.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ThirdIntroScreen extends StatefulWidget {
  const ThirdIntroScreen({Key? key}) : super(key: key);

  @override
  _ThirdIntroScreenState createState() => _ThirdIntroScreenState();
}

class _ThirdIntroScreenState extends State<ThirdIntroScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<SponsorPageProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: deviceHeight * 0.1),
          Container(
            height: deviceHeight * 0.42,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.6),
              itemCount: provider.result.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == provider.result.length) {
                  return CircularProgressIndicator();
                }
                return _buildItemSponsor(
                  provider.result[index],
                  context,
                  index,
                  deviceHeight,
                  deviceWidth,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: deviceWidth * 0.1,
            ),
            child: Column(
              children: [
                Text(
                  'Gracias a nuestros\npatrocinadores!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: deviceHeight * 0.02),
                Text(
                  "Con la ayuda de nuestros patrocinadores, seguimos haciendo la diferencia en la vida de muchas mascotas y familias.\n¡Gracias por su apoyo!",
                  textAlign: TextAlign.center,
                  style: AppFonts.caption.copyWith(
                    fontSize: deviceWidth * 0.04,
                    color: textColor2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemSponsor(
    SavedSponsor sponsor,
    BuildContext context,
    int index,
    double deviceHeight,
    double deviceWidth,
  ) {
    return GestureDetector(
      onTap: () {
        if (sponsor.website != null) {
          launchUrl(Uri.parse(sponsor.website!));
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Container(
          width: deviceWidth * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                height: deviceHeight * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(sponsor.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  sponsor.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
