import 'package:familylost_faan/Screen/post/edit_post_form.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/models/user.dart';
import 'package:familylost_faan/ServiciosApp/services/post_service.dart';
import 'package:familylost_faan/ServiciosApp/services/user_service.dart';
import 'package:familylost_faan/utilities/AssetManager/asset_manager.dart';
import 'package:familylost_faan/utilities/paginator/paginator.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:familylost_faan/widgets/custom_paginator.dart';
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
  String? userId;
  bool likedPosts = false;

  @override
  void initState() {
    super.initState();
    _getStoredId().then((value) {
      userId = value;
      _getUser();
    });
  }

  Future<String?> _getStoredId() async {
    userId = await Store.getUserId();
    return userId;
  }

  Future<void> _getUser() async {
    user = await UserService().getUserById(userId!, context);
    setState(() {
      user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Container();
    }

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: user?.photo?.image?.data != null
                        ? Image.memory(user!.photo!.image!.data).image
                        : AssetImage(AssetManager.largeLogo),
                  ),
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
          Container(
            height: MediaQuery.of(context).size.height * 0.48,
            child: TabBarView(
              children: [
                _ProfileGridView(userId: userId!, likedPosts: false),
                _ProfileGridView(userId: userId!, likedPosts: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileGridView extends StatefulWidget {
  final String userId;
  final bool likedPosts;
  const _ProfileGridView(
      {Key? key, required this.userId, required this.likedPosts})
      : super(key: key);

  @override
  __ProfileGridViewState createState() => __ProfileGridViewState();
}

class __ProfileGridViewState extends State<_ProfileGridView> {
  late Paginator<SavePost> paginator;
  List<SavePost> myPosts = [];
  @override
  void initState() {
    super.initState();
    _initPaginator();
  }

  void _initPaginator() {
    paginator = Paginator<SavePost>(
      fetchPage: (int page) async {
        List<SavePost> newPosts;
        if (widget.likedPosts) {
          newPosts = await PostService()
              .getLikedPostsByUser(widget.userId, context, pageNumber: page);
        } else {
          newPosts = await PostService()
              .getPostsByUser(widget.userId, context, pageNumber: page);
        }
        setState(() {
          myPosts.addAll(newPosts);
        });
        return newPosts;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedGridView<SavePost>(
      paginator: paginator,
      itemBuilder: (BuildContext context, SavePost post) {
        return GestureDetector(
          onTap: () {
            _showPostBottomSheet(context, post);
          },
          child: Container(
            color: AppColors.mainColor,
            /*child: Image.memory(
              post.data!,
              fit: BoxFit.cover,
            ),*/
          ),
        );
      },
    );
  }

  Future<void> _showPostBottomSheet(BuildContext context, SavePost post) async {
    var _deviceSize = MediaQuery.of(context).size;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(_deviceSize.width * 0.05),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
            child: Container(
              padding: EdgeInsets.all(_deviceSize.width * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    /*Center(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(_deviceSize.width * 0.02),
                        child: Image.memory(
                          post.data!,
                          fit: BoxFit.cover,
                          height: _deviceSize.height * 0.4,
                          width: _deviceSize.width,
                        ),
                      ),
                    ),*/
                    const SizedBox(height: 8.0),
                    Text(
                      post.title,
                      style: AppFonts.title.copyWith(
                        color: AppColors.activeBlueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${AppStrings.author}: ${post.author.username}',
                      style: AppFonts.TextField.copyWith(
                        color: AppColors.activeBlueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${AppStrings.labelEmail}: ${post.author.email}',
                      style: AppFonts.TextField.copyWith(
                        color: AppColors.activeBlueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${AppStrings.labelPhone}: ${post.author.phone}',
                      style: AppFonts.TextField.copyWith(
                        color: AppColors.activeBlueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${AppStrings.authorComent}: ${post.additionalComment}',
                      style: AppFonts.TextField.copyWith(
                        color: AppColors.activeBlueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _footer(context, _deviceSize, post),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _footer(BuildContext context, Size _deviceSize, SavePost post) {
    return [
      Container(
        child: _footerButton(
          context,
          _deviceSize,
          AppColors.mainColor,
          AppStrings.buttonEdit,
          onPressed: () {
            _editPost(context, post);
          },
        ),
      ),
      SizedBox(width: _deviceSize.width * 0.02),
      Container(
        child: _footerButton(
          context,
          _deviceSize,
          AppColors.errorColor,
          AppStrings.buttonDelete,
          onPressed: () {
            var data = PostService().deletePost(post.id ?? '', context);
            print(data);
            Navigator.pop(context);
          },
        ),
      ),
    ];
  }

  ElevatedButton _footerButton(
      BuildContext context, Size _deviceSize, Color color, String text,
      {required void Function()? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_deviceSize.width * 0.05),
        ),
      ),
    );
  }

  void _editPost(BuildContext context, SavePost post) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditPostFormPage(post: post);
    }));
  }
}
