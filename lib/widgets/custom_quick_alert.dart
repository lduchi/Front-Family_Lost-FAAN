import 'package:familylost_faan/Screen/post/save_post_form.dart';
import 'package:familylost_faan/ServiciosApp/dto/author.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/animations/app_animations.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/utilities/enum/post_type.dart';
import 'package:familylost_faan/utilities/fonts/app_fonts.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import '../utilities/enum/state_post.dart';

class CustomMaterialDialog {
  final BuildContext context;
  final DialogType type;
  PostType? _selectedPostType = PostType.LOST;

  CustomMaterialDialog.postOptions({
    required this.context,
    required this.type,
  }) {
    _showOptionsDialog();
  }

  CustomMaterialDialog.simple({
    required this.context,
    required this.type,
  }) {
    _showSimpleLoading();
  }

  CustomMaterialDialog.catLoading({
    required this.context,
    required this.type,
  }) {
    _showCatLoading();
  }

  CustomMaterialDialog.close({
    required this.context,
    required this.type,
  }) {
    _closeDialog();
  }

  /**
   * You can invocate this method to show a dialog with the type of DialogType.success or DialogType.error
  */
  CustomMaterialDialog.successOrError({
    required this.context,
    required this.type,
    required String title,
    required String message,
    bool dismissAndPop = false,
  }) {
    _showSuccessOrErrorDialog(title, message, dismissAndPop);
  }

  /**
   * You can invocate this method to show a dialog with the type of DialogType.warning
  */
  CustomMaterialDialog.warning({
    required this.context,
    required this.type,
    required String title,
    required String message,
  }) {
    _showWarningDialog(title, message);
  }

  /**
   * You can invocate this method to show a dialog with the type of DialogType.warning with options
  */
  CustomMaterialDialog.warningWithOptions({
    required this.context,
    required this.type,
    required String title,
    required String message,
  }) {
    _showWarningDialogWithOptions(title, message);
  }

  void _showSuccessOrErrorDialog(String title, String message, bool dismissAndPop) {
    final String asset = type == DialogType.error
        ? AppLottielottie.error
        : AppLottielottie.success;

    final Color color =
        type == DialogType.error ? AppColors.errorColor : AppColors.mainColor;

    final TextStyle textStyle =
        type == DialogType.error ? AppFonts.errorTitle : AppFonts.successTitle;

    Dialogs.materialDialog(
      color: AppColors.secondaryMainColor,
      title: title,
      titleStyle: textStyle,
      msg: message,
      msgAlign: TextAlign.center,
      msgStyle: TextStyle(color: AppColors.msgDialogColor),
      lottieBuilder: Lottie.asset(asset, repeat: false),
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            dismissAndPop ? _dismissAndPop() : Navigator.of(context).pop();
          },
          text: AppStrings.buttonAccept,
          iconData: Icons.check_circle,
          color: color,
          textStyle: TextStyle(color: AppColors.secondaryMainColor),
          iconColor: AppColors.secondaryMainColor,
        ),
      ],
    );
  }

  void _showWarningDialog(String title, String message) {
    final String asset = AppLottielottie.warning;

    Dialogs.materialDialog(
      color: AppColors.secondaryMainColor,
      title: title,
      titleStyle: AppFonts.warningTitle,
      msg: message,
      msgAlign: TextAlign.center,
      msgStyle: TextStyle(color: AppColors.msgDialogColor),
      lottieBuilder: Lottie.asset(asset, width: 100, repeat: false),
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: AppStrings.buttonAccept,
          iconData: Icons.check_circle,
          color: AppColors.warningColor,
          textStyle: TextStyle(color: AppColors.secondaryMainColor),
          iconColor: AppColors.secondaryMainColor,
        ),
      ],
    );
  }

  void _showWarningDialogWithOptions(String title, String message) {
    final String asset = AppLottielottie.warning;

    Dialogs.materialDialog(
      color: AppColors.secondaryMainColor,
      title: title,
      titleStyle: AppFonts.warningTitle,
      msg: message,
      msgAlign: TextAlign.center,
      msgStyle: TextStyle(color: AppColors.msgDialogColor),
      lottieBuilder: Lottie.asset(asset, width: 100, repeat: false),
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          text: AppStrings.buttonAccept,
          iconData: Icons.check_circle,
          color: AppColors.errorColor,
          textStyle: TextStyle(color: AppColors.secondaryMainColor),
          iconColor: AppColors.secondaryMainColor,
        ),
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          text: AppStrings.buttonCancel,
          iconData: Icons.cancel,
          color: AppColors.whatsAppGreen,
          textStyle: TextStyle(color: AppColors.secondaryMainColor),
          iconColor: AppColors.secondaryMainColor,
        ),
      ],
    );
  }

  void _showSimpleLoading() {
    final String asset = AppLottielottie.loading;

    Dialogs.materialDialog(
      color: AppColors.secondaryMainColor,
      msg: AppStrings.loadingTitle,
      lottieBuilder: Lottie.asset(asset, width: 100, repeat: true),
      context: context,
      barrierDismissible: false,
    );
  }

  void _showCatLoading() {
    final String asset = AppLottielottie.loadingCat;

    Dialogs.materialDialog(
      color: AppColors.secondaryMainColor,
      msg: AppStrings.loadingTitle,
      lottieBuilder: Lottie.asset(
        asset,
        repeat: true,
      ),
      context: context,
      barrierDismissible: false,
    );
  }

  void _showOptionsDialog() {
    Dialogs.bottomMaterialDialog(
      title: AppStrings.titleOptions,
      msg: AppStrings.messageOptions,
      customView: _buildOptionsDialog(context),
      customViewPosition: CustomViewPosition.BEFORE_ACTION,
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
            _navigateToSelectedScreen();
          },
          text: AppStrings.buttonAccept,
          iconData: Icons.check_circle,
          color: AppColors.whatsAppGreen,
          textStyle: TextStyle(color: AppColors.secondaryMainColor),
          iconColor: AppColors.secondaryMainColor,
        ),
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: AppStrings.buttonCancel,
          iconData: Icons.cancel,
          color: AppColors.errorColor,
          textStyle: TextStyle(color: AppColors.secondaryMainColor),
          iconColor: AppColors.secondaryMainColor,
        ),
      ],
    );
  }


  Widget _buildOptionsDialog(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasAdminRole(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final hasAdminRole = snapshot.data;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: hasAdminRole!
                    ? PostType.values
                    .map(
                      (type) => _buildOption(
                    title:
                    '${AppStrings.textRadioOptions} ${type.value.toLowerCase()}',
                    postType: type,
                    setState: setState,
                  ) as Widget,
                )
                    .toList()
                    : PostType.values
                    .where((element) => element != PostType.ADOPTION)
                    .map(
                      (type) => _buildOption(
                    title:
                    '${AppStrings.textRadioOptions} ${type.value.toLowerCase()}',
                    postType: type,
                    setState: setState,
                  ) as Widget,
                )
                    .toList(),
              );
            },
          );
        }
      },
    );
  }

  Future<bool> _hasAdminRole() async {
    final hasAdminRole = await Store.hasAdminRole();

    return await hasAdminRole;
  }

  _buildOption({
    required String title,
    required PostType postType,
    required StateSetter setState,
  }) {
    return RadioListTile<PostType>(
      title: Text(title),
      value: postType,
      groupValue: _selectedPostType,
      onChanged: (PostType? value) {
        setState(() {
          _selectedPostType = value;
        });
      },
    );
  }

  _navigateToSelectedScreen() async {
    final author = await Store.getAuthor();

    switch (_selectedPostType) {
      case PostType.LOST:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SavePostForm(
              typePost: PostType.LOST,
              author: Author(
                id: author?.id ?? '',
                username: author?.username ?? '',
                email: author?.email ?? '',
                phone: author?.phone ?? '',
                imageUrl: author?.imageUrl ?? '',
              ),
              statePost: StatePost.LOST,
            )
          ),
        );
        break;
      case PostType.FOUND:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SavePostForm(
                typePost: PostType.FOUND,
                author: Author(
                  id: author?.id ?? '',
                  username: author?.username ?? '',
                  email: author?.email ?? '',
                  phone: author?.phone ?? '',
                  imageUrl: author?.imageUrl ?? '',
                ),
                statePost: StatePost.FOUND,
              )
          ),
        );
        break;
      case PostType.ADOPTION:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SavePostForm(
                typePost: PostType.ADOPTION,
                author: Author(
                  id: author?.id ?? '',
                  username: author?.username ?? '',
                  email: author?.email ?? '',
                  phone: author?.phone ?? '',
                  imageUrl: author?.imageUrl ?? '',
                ),
                statePost: StatePost.LOST,
              )
          ),
        );
        break;
      default:
        break;
    }
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }

  void _dismissAndPop() {
    Navigator.of(context).pop();
    Navigator.of(context).pop(); // Volver atrás en la pantalla
  }
}
