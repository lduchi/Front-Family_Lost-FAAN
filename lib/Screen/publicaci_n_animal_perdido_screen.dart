import 'package:familylost_faan/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../core/utils/image_constant.dart';
import '../theme/app_decoration.dart';
import '../theme/custom_text_style.dart';
import '../theme/theme_helper.dart';
import '../widgets/custom_image_view.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class PublicaciNAnimalPerdidoScreen extends StatelessWidget {
  PublicaciNAnimalPerdidoScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController scottvalueoneController = TextEditingController();

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList1 = ["Item One", "Item Two", "Item Three"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildAppBar(context),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 37.h,
                  vertical: 20.v,
                ),
                child: Column(
                  children: [
                    _buildColumnhomeone(context),
                    SizedBox(height: 23.v),
                    _buildAnimalDetails(context),
                    SizedBox(height: 58.v),
                    _buildSaveButton(context),
                    SizedBox(height: 20.v),
                    _buildAnimalInfo(context),
                    SizedBox(height: 21.v),
                    _buildImageStack(context),
                    SizedBox(height: 17.v),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      margin: EdgeInsets.all(0),
                      color: appTheme.whiteA700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusStyle.roundedBorder5,
                      ),
                      child: Container(
                        height: 123.v,
                        width: 343.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.h,
                          vertical: 6.v,
                        ),
                        decoration: AppDecoration.fillWhiteA.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder5,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: EdgeInsets.only(right: 2.h),
                                padding: EdgeInsets.all(5.h),
                                decoration: AppDecoration.outlineBlack.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder5,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 4.v),
                                    Text(
                                      "Ubicacion",
                                      style: theme.textTheme.titleSmall,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgImage1,
                              height: 78.v,
                              width: 312.h,
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.only(bottom: 8.v),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.v),
                    _buildSaveButton1(context),
                    SizedBox(height: 5.v)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppBar(BuildContext context) {
    return SizedBox(
      height: 217.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomAppBar(
            leadingWidth: 65.h,
            leading: AppbarLeadingImage(
              imagePath: ImageConstant.imgArrowLeftPrimary,
              margin: EdgeInsets.only(
                left: 37.h,
                top: 27.v,
                bottom: 33.v,
              ),
            ),
            centerTitle: true,
            title: AppbarTitle(
              text: "Publicar Animal Perdido",
            ),
            styleType: Style.bgFill,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              margin: EdgeInsets.all(0),
              color: appTheme.whiteA700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusStyle.roundedBorder5,
              ),
              child: Container(
                height: 143.v,
                width: 361.h,
                padding: EdgeInsets.all(7.h),
                decoration: AppDecoration.fillWhiteA.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder5,
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.all(8.h),
                        decoration: AppDecoration.outlineBlack.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder5,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 18.v),
                            Text(
                              "Añade fotos:",
                              style: theme.textTheme.titleSmall,
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 93.v,
                        width: 95.h,
                        margin: EdgeInsets.only(bottom: 4.v),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.h,
                          vertical: 20.v,
                        ),
                        decoration: AppDecoration.fillBlueGray,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgPlusIconIcons,
                          height: 47.v,
                          width: 63.h,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 93.v,
                        width: 95.h,
                        margin: EdgeInsets.only(
                          right: 5.h,
                          bottom: 4.v,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.h,
                          vertical: 23.v,
                        ),
                        decoration: AppDecoration.fillBlueGray,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgPlusIconIcons,
                          height: 47.v,
                          width: 63.h,
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgImagen3,
                      height: 91.v,
                      width: 100.h,
                      radius: BorderRadius.circular(
                        15.h,
                      ),
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(
                        left: 14.h,
                        bottom: 6.v,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildScottvalueone(BuildContext context) {
    return CustomTextFormField(
      controller: scottvalueoneController,
      hintText: "Scott...",
      textInputAction: TextInputAction.done,
      borderDecoration: TextFormFieldStyleHelper.fillPrimary,
      fillColor: theme.colorScheme.primary,
    );
  }

  /// Section Widget
  Widget _buildColumnhomeone(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7.h),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.v),
          Padding(
            padding: EdgeInsets.only(left: 5.h),
            child: Text(
              "Nombre Animal:",
              style: theme.textTheme.titleSmall,
            ),
          ),
          SizedBox(height: 3.v),
          _buildScottvalueone(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAnimalDetails(BuildContext context) {
    return Container(
      width: 347.h,
      margin: EdgeInsets.only(right: 7.h),
      padding: EdgeInsets.symmetric(horizontal: 6.h),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 8.v),
          Text(
            "Fecha cuando se perdio:",
            style: theme.textTheme.titleSmall,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSaveButton(BuildContext context) {
    return CustomElevatedButton(
      height: 46.v,
      text: "20/02/2024",
      margin: EdgeInsets.only(right: 7.h),
      buttonTextStyle: theme.textTheme.bodyMedium!,
    );
  }

  /// Section Widget
  Widget _buildAnimalInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 7.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 1.v),
            decoration: AppDecoration.outlineBlack.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder5,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6.v),
                Padding(
                  padding: EdgeInsets.only(left: 9.h),
                  child: Text(
                    "Raza",
                    style: CustomTextStyles.titleSmallGray50,
                  ),
                ),
                SizedBox(height: 1.v),
                CustomDropDown(
                  width: 176.h,
                  icon: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgArrowdown,
                      height: 9.v,
                      width: 16.h,
                    ),
                  ),
                  hintText: "Raza",
                  items: dropdownItemList,
                )
              ],
            ),
          ),
          Container(
            decoration: AppDecoration.outlineBlack.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder5,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 4.v),
                Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: Text(
                    "Sexo",
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                SizedBox(height: 3.v),
                CustomDropDown(
                  width: 159.h,
                  icon: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgArrowdown,
                      height: 9.v,
                      width: 14.h,
                    ),
                  ),
                  hintText: "Macho",
                  items: dropdownItemList1,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSubmitButton(BuildContext context) {
    return CustomElevatedButton(
      height: 67.v,
      text: "...",
      buttonTextStyle: theme.textTheme.bodyMedium!,
    );
  }

  /// Section Widget
  Widget _buildImageStack(BuildContext context) {
    return SizedBox(
      height: 97.v,
      width: 347.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 56.v,
              width: 346.h,
              decoration: BoxDecoration(
                color: appTheme.cyan70001,
                borderRadius: BorderRadius.circular(
                  5.h,
                ),
                boxShadow: [
                  BoxShadow(
                    color: appTheme.black900.withOpacity(0.25),
                    spreadRadius: 2.h,
                    blurRadius: 2.h,
                    offset: Offset(
                      0,
                      9,
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.h),
                  child: Text(
                    "Descripcion:",
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                _buildSubmitButton(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSaveButton1(BuildContext context) {
    return CustomElevatedButton(
      text: "Guardar",
      margin: EdgeInsets.symmetric(horizontal: 7.h),
      buttonStyle: CustomButtonStyles.fillErrorContainer,
    );
  }
}
