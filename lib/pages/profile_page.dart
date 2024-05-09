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
  @override
  Widget build(BuildContext context) {
    var _deviceHeight = MediaQuery.of(context).size.height;
    var _deviceWidth = MediaQuery.of(context).size.width;
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
                    backgroundImage: AssetImage('images/pet1.png'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Elizabeth Peñafiel',
                    style: AppFonts.title.copyWith(
                      fontSize: 24,
                      color: AppColors.activeBlueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'elizabethpeñafiel@gmail.com',
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
