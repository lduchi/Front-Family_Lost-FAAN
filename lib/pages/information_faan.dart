import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import '../../Utils/colors.dart';

class InformationFaan extends StatefulWidget {
  const InformationFaan({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<InformationFaan>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255) ,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color(0xFF009AB0) ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Acerca de Faan',
          style: TextStyle(
            color: Color(0xFF009AB0) ,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        color: backgroundColor5,
        child: ListView(
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
              height: size.height * 0.3,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                color: backgroundColor5,
                image: const DecorationImage(
                  image: AssetImage(
                    "images/Logo.png",
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            FadeTransition(
              opacity: _animation,
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        "Fundación Familia Amor Animal (FAAN) organización dedicada a la protección, concienciación y defensa de los derecho de los animales.",
                        textAlign: TextAlign.center,
                        style: AppFonts.caption.copyWith(
                          fontSize: 15.5,
                          color: textColor2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 18,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          SizedBox(
                              width:
                                  5), // Add some space between the icon and the text
                          Text(
                            "Dirección: Tarqui, Cuenca",
                            textAlign: TextAlign.justify,
                            style: AppFonts.caption.copyWith(
                              fontSize: 15.5,
                              color: textColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.phone_android,
                            size: 18,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          SizedBox(
                              width:
                                  5), // Add some space between the icon and the text
                          Text(
                            "Telefono: 099 868 1859",
                            textAlign: TextAlign.justify,
                            style: AppFonts.caption.copyWith(
                              fontSize: 15.5,
                              color: textColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.email,
                            size: 18,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          SizedBox(
                              width:
                                  5), // Add some space between the icon and the text
                          Text(
                            "correo: info@faanecuador.org",
                            textAlign: TextAlign.justify,
                            style: AppFonts.caption.copyWith(
                              fontSize: 15.5,
                              color: textColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.web,
                            size: 18,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          SizedBox(
                              width:
                                  5), // Add some space between the icon and the text
                          Text(
                            "web: faanecuador.org",
                            textAlign: TextAlign.justify,
                            style: AppFonts.caption.copyWith(
                              fontSize: 15.5,
                              color: textColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        "¡Ayuda a Traer a Casa a Nuestros Animales Perdidos!",
                        textAlign: TextAlign.center,
                        style: AppFonts.caption.copyWith(
                          fontSize: 15.5,
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        "Cada año, miles de mascotas queridas se extravían y terminan separadas de sus familias desesperadas. Pero tú puedes ser el héroe que los reúna nuevamente.",
                        textAlign: TextAlign.justify,
                        style: AppFonts.caption.copyWith(
                          fontSize: 15.5,
                          color: textColor2,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Image.asset(
                        "images/petP.png",
                        height: 130,
                        width: 130,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        "Únete a nuestra misión de ayudar a estos animales perdidos a encontrar su camino de vuelta a casa. ",
                        textAlign: TextAlign.justify,
                        style: AppFonts.caption
                            .copyWith(fontSize: 15.5, color: textColor2),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Image.asset(
                        "images/per.png",
                        height: 150,
                        width: 150,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        " Tu apoyo puede hacer la diferencia para devolver a estos compañeros peludos con sus seres amados, donde pertenecen. ¿Estás listo para unirte a esta cruzada del reencuentro?",
                        textAlign: TextAlign.justify,
                        style: AppFonts.caption
                            .copyWith(fontSize: 15.5, color: textColor2),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Image.asset(
                        "images/heart.png",
                        height: 130,
                        width: 130,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        "¡Inicia sesión o regístrate ahora mismo y ayúdanos a reunir a más mascotas con sus familias!",
                        textAlign: TextAlign.justify,
                        style: AppFonts.caption
                            .copyWith(fontSize: 15.5, color: textColor2),
                      ),
                    ),
                    SizedBox(height: size.height * 0.07),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
