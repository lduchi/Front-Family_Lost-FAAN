import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/models/user.dart';
import 'package:familylost_faan/ServiciosApp/services/user_service.dart';
import 'package:familylost_faan/utilities/AssetManager/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  BigInt? userId;
  @override
  void initState() {
    super.initState();
    _getStoredId().then((value) {
      userId = value;
      _getUser();
    });
  }

  Future<BigInt?> _getStoredId() async {
    userId = await Store.getUserId();
    print(userId);
    return userId;
  }

  Future<void> _getUser() async {
    user = await UserService().getUserById(userId!, context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var _deviceHeight = MediaQuery.of(context).size.height;
    var _deviceWidth = MediaQuery.of(context).size.width;

    if (user == null) {
      return Container();
    }

    return Scaffold(
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.05),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: Image.memory(
                      user!.photo!.image.data,
                      fit: BoxFit.cover,
                    ).image,
                  ),
                  SizedBox(height: 8),
                  Text(
                    user!.nombre + ' ' + user!.apellido,
                    style: AppFonts.title.copyWith(
                      fontSize: 24,
                      color: AppColors.activeBlueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user!.email,
                    style: AppFonts.caption.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  _profileTabBar(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DefaultTabController _profileTabBar(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: AppColors.secondaryMainColor,
            child: const TabBar(
              labelColor: AppColors.activeBlueColor,
              indicatorColor: AppColors.activeBlueColor,
              tabs: [
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.assignment_ind_outlined),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: const TabBarView(
              children: [
                _ProfileGridView(),
                _ProfileGridView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileGridView extends StatefulWidget {
  const _ProfileGridView({Key? key}) : super(key: key);

  @override
  __ProfileGridViewState createState() => __ProfileGridViewState();
}

class __ProfileGridViewState extends State<_ProfileGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        //final post = 1;
        return Container(
          color: AppColors.secondaryColor,
          child: Image.asset(
            AssetManager.exampleImage,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
