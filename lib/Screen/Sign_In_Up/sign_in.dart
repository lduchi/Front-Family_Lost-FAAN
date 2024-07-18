import 'package:familylost_faan/Screen/Sign_In_Up/RegisterPage.dart';
import 'package:familylost_faan/Screen/ResetPassword/RequestNP.dart';
import 'package:familylost_faan/ServiciosApp/dto/login_request.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/services/auth_service.dart';
import 'package:familylost_faan/ServiciosApp/services/home_service.dart';
import 'package:familylost_faan/ServiciosApp/services/search_service.dart';
import 'package:familylost_faan/pages/cubit/bottom_nav_cubit.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/icons/app_icons.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Utils/colors.dart';
import '../../widgets/main_wrapper.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationRequest? loginRequest;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppStrings.homeTitle,
              style: GoogleFonts.poppins(
                color: AppColors.secondaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: AppColors.mainColor,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: AppColors.secondaryMainColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: AppIcons.closeIconBlack,
            onPressed: () {
              // Navegar a la página principal o a la pantalla deseada
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MultiProvider(
                    providers: [
                      BlocProvider(create: (context) => BottomNavCubit()),
                      ChangeNotifierProvider(
                          create: (_) => HomePageProvider('LOST')),
                      ChangeNotifierProvider(create: (_) => SearchService()),
                    ],
                    child: MainWrapper(isLoggedIn: false),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(
            child: ListView(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: size.height * 0.30,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  color: Colors.transparent,
                  image: const DecorationImage(
                    image: AssetImage(
                      "images/Logo.png",
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.04),
                  myTextField(
                    AppStrings.hintUsername,
                    Colors.black26,
                    Icons.alternate_email,
                    null,
                    _usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.errorEmptyUsername;
                      }
                    },
                  ),
                  myTextField(
                    AppStrings.hintPassword,
                    Colors.black26,
                    Icons.password,
                    Icons.visibility_off_outlined,
                    _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.errorEmptyPassword;
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  // for sign in button
                  GestureDetector(
                    onTap: () {
                      _login(loginRequest, context);
                    },
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: general,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          "Iniciar Sesion",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.07),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequestNP(),
                        ),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "¿Has olvidado la contraseña? ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                          text: "¿No tienes una cuenta? ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          children: const [
                            TextSpan(
                              text: "Registrate",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  Container socialIcon(image) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Image.asset(
        image,
        height: 35,
      ),
    );
  }

  Container myTextField(
    String hint,
    Color color,
    IconData icono1,
    IconData? icono2,
    TextEditingController? controller, {
    String? Function(String?)? validator,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 15,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 19,
          ),
          fillColor: Colors.white,
          filled: false,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey, // Borde gris
            ),
            borderRadius:
                BorderRadius.circular(40), // Ajuste del radio del borde
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 17,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              icono1,
              color: color,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              icono2,
              color: color,
            ),
          ),
        ),
        controller: controller,
        validator: validator,
      ),
    );
  }

  //codigo que controla el mensaje de notificaciones de contrasena o error en campos incompletos
  Future<void> _login(loginRequest, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      loginRequest = AuthenticationRequest(
        username: _usernameController.text,
        password: _passwordController.text,
      );

      final response = await AuthService().login(loginRequest, context);

      if (response != null) {
        final accessToken = response['accessJwt'];
        final refreshToken = response['refreshJwt'];

        Store.setTokens(accessToken, refreshToken);
        Store.setLogged(true);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MultiProvider(
              providers: [
                BlocProvider(create: (context) => BottomNavCubit()),
                ChangeNotifierProvider(create: (_) => HomePageProvider('LOST')),
                ChangeNotifierProvider(create: (_) => SearchService()),
              ],
              child: MainWrapper(isLoggedIn: true),
            ),
          ),
        );
      } else {
        // Mostrar mensaje de error si la autenticación falla
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuario o contraseña incorrectos'),
          ),
        );
      }
    } else {
      // Mostrar mensaje de error si la validación del formulario falla
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor complete todos los campos'),
        ),
      );
    }
  }
}
