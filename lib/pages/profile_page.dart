import 'package:cached_network_image/cached_network_image.dart';
import 'package:familylost_faan/Screen/post/edit_post_form.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:familylost_faan/ServiciosApp/dto/user_dto.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/services/post_service.dart';
import 'package:familylost_faan/ServiciosApp/services/user_service.dart';
import 'package:familylost_faan/utilities/AssetManager/asset_manager.dart';
import 'package:familylost_faan/utilities/paginator/paginator.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:familylost_faan/widgets/custom_paginator.dart';
import 'package:flutter/material.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:provider/provider.dart';

import '../ServiciosApp/services/profile_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserDTO? user;
  String? userId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().getUserById(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, provider, child) {
      if (provider.user == null) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
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
                      backgroundImage: CachedNetworkImageProvider(
                        provider.user!.imageUrl.isNotEmpty
                            ? provider.user!.imageUrl
                            : AssetManager.largeLogo,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    provider.user!.name + ' ' + provider.user!.lastname,
                    style: AppFonts.title.copyWith(
                      fontSize: 24,
                      color: AppColors.activeBlueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    provider.user!.email,
                    style: AppFonts.caption.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  _profileTabBar(context, provider),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  DefaultTabController _profileTabBar(
      BuildContext context, ProfileProvider provider) {
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
                _ProfileGridView(provider: provider, likedPosts: false),
                _ProfileGridView(provider: provider, likedPosts: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileGridView extends StatefulWidget {
  final bool likedPosts;
  final ProfileProvider provider;

  const _ProfileGridView(
      {Key? key, required this.provider, required this.likedPosts})
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
          newPosts = await widget.provider
              .getLikedPostsByUser(context, pageNumber: page);
        } else {
          newPosts =
              await widget.provider.getPostsByUser(context, pageNumber: page);
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
            _showPostBottomSheet(
              context,
              post,
            );
          },
          child: Container(
            color: AppColors.mainColor,
            child: Container(
              child: post.imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: post.imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      AssetManager.largeLogo,
                      fit: BoxFit.cover,
                    ),
            ),
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
        return bottomSheetDetail(context, _deviceSize, post);
      },
    );
  }

  Padding bottomSheetDetail(
      BuildContext context, Size _deviceSize, SavePost post) {
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
                Center(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(_deviceSize.width * 0.02),
                    child: Container(
                      color: AppColors.mainColor,
                      child: Container(
                        child: post.imageUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: post.imageUrl,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                AssetManager.largeLogo,
                                fit: BoxFit.cover,
                              ),
                        height: _deviceSize.height * 0.4,
                        width: _deviceSize.width,
                      ),
                    ),
                  ),
                ),
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
                  '${AppStrings.postType}: ${post.typePost}',
                  style: AppFonts.TextField.copyWith(
                    color: AppColors.activeBlueColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '${AppStrings.authorComment}: ${post.additionalComment ?? AppStrings.noComment}',
                  style: AppFonts.TextField.copyWith(
                    color: AppColors.activeBlueColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!widget.likedPosts)
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _footer(context, _deviceSize, post),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
