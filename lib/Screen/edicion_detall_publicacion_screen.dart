import 'package:familylost_faan/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../core/utils/image_constant.dart';
import '../theme/app_decoration.dart';
import '../theme/custom_text_style.dart';
import '../theme/theme_helper.dart';
import '../widgets/custom_image_view.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class EdicionDetallPublicacionScreen extends StatelessWidget {
  EdicionDetallPublicacionScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController smilingCatController = TextEditingController();

  TextEditingController cuencaAzuayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 9.h,
            vertical: 22.v,
          ),
          child: Column(
            children: [
              _buildRowArrowLeft(context),
              SizedBox(height: 55.v),
              _buildRowNombre(context),
              SizedBox(height: 65.v),
              Padding(
                padding: EdgeInsets.only(
                  left: 35.h,
                  right: 44.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 130.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.h,
                        vertical: 1.v,
                      ),
                      decoration: AppDecoration.outlineBlack.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder5,
                      ),
                      child: Text(
                        "Fecha",
                        style: CustomTextStyles.titleSmallInter,
                      ),
                    ),
                    _buildTipoDePublicacion(context)
                  ],
                ),
              ),
              SizedBox(height: 15.v),
              _buildStackView(context),
              SizedBox(height: 37.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 130.h,
                  margin: EdgeInsets.only(left: 40.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 7.h,
                    vertical: 2.v,
                  ),
                  decoration: AppDecoration.outlineBlack.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder5,
                  ),
                  child: Text(
                    "Descripción",
                    style: CustomTextStyles.titleSmallInter,
                  ),
                ),
              ),
              SizedBox(height: 15.v),
              Container(
                margin: EdgeInsets.only(
                  left: 40.h,
                  right: 32.h,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 9.h,
                  vertical: 1.v,
                ),
                decoration: AppDecoration.outlineBlack900.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder5,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 7.v),
                    SizedBox(
                      width: 319.h,
                      child: Text(
                        "Recientemente, encontré a este dulce gatito negro perdido. Es un pequeño felino de pelaje oscuro, con ojos brillantes y una....",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style:
                            CustomTextStyles.bodyMediumRobotoGray700.copyWith(
                          height: 1.72,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 28.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 130.h,
                  margin: EdgeInsets.only(left: 40.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 7.h,
                    vertical: 2.v,
                  ),
                  decoration: AppDecoration.outlineBlack.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder5,
                  ),
                  child: Text(
                    "Imagen",
                    style: CustomTextStyles.titleSmallInter,
                  ),
                ),
              ),
              SizedBox(height: 13.v),
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                margin: EdgeInsets.all(0),
                color: appTheme.blueGray100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusStyle.roundedBorder5,
                ),
                child: Container(
                  height: 188.v,
                  width: 261.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 38.h,
                    vertical: 15.v,
                  ),
                  decoration: AppDecoration.fillBlueGray.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder5,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 12.v,
                          width: 141.h,
                          margin: EdgeInsets.only(bottom: 31.v),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onErrorContainer,
                            borderRadius: BorderRadius.circular(
                              70.h,
                            ),
                          ),
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgImage9,
                        height: 158.v,
                        width: 185.h,
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.v),
              Padding(
                padding: EdgeInsets.only(
                  left: 48.h,
                  right: 30.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_buildCancelar(context), _buildGuardar(context)],
                ),
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowArrowLeft(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgArrowLeft,
            height: 28.adaptSize,
            width: 28.adaptSize,
            margin: EdgeInsets.only(
              top: 10.v,
              bottom: 6.v,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 17.h,
              top: 5.v,
              bottom: 5.v,
            ),
            child: Text(
              "Editar Detalle Publicación",
              style: theme.textTheme.headlineSmall,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgIconMenu,
            height: 44.adaptSize,
            width: 44.adaptSize,
            margin: EdgeInsets.only(left: 3.h),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSmilingCat(BuildContext context) {
    return CustomTextFormField(
      width: 159.h,
      controller: smilingCatController,
      hintText: "Gato Sonriente",
      contentPadding: EdgeInsets.symmetric(
        horizontal: 9.h,
        vertical: 14.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildCuencaAzuay(BuildContext context) {
    return CustomTextFormField(
      width: 159.h,
      controller: cuencaAzuayController,
      hintText: "Cuenca, Azuay",
      hintStyle: CustomTextStyles.titleSmallRobotoGray60001,
      textInputAction: TextInputAction.done,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 14.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildRowNombre(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 35.h,
        right: 32.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 130.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 7.h,
                  vertical: 1.v,
                ),
                decoration: AppDecoration.outlineBlack.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder5,
                ),
                child: Text(
                  "Nombre",
                  style: CustomTextStyles.titleSmallInter,
                ),
              ),
              SizedBox(height: 15.v),
              _buildSmilingCat(context)
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 130.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 9.h,
                    vertical: 2.v,
                  ),
                  decoration: AppDecoration.outlineBlack.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder5,
                  ),
                  child: Text(
                    "Ubicación ",
                    style: CustomTextStyles.titleSmallInter,
                  ),
                ),
                SizedBox(height: 15.v),
                _buildCuencaAzuay(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTipoDePublicacion(BuildContext context) {
    return CustomElevatedButton(
      height: 25.v,
      width: 148.h,
      text: "Tipo de publicación",
      buttonStyle: CustomButtonStyles.outlineBlack,
      buttonTextStyle: CustomTextStyles.titleSmallInter,
    );
  }

  /// Section Widget
  Widget _buildStackView(BuildContext context) {
    return SizedBox(
      height: 46.v,
      width: 344.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 46.v,
              width: 159.h,
              decoration: BoxDecoration(
                color: appTheme.gray5001,
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
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
                  width: 161.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 9.h,
                    vertical: 13.v,
                  ),
                  decoration: AppDecoration.outlineBlack900.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder5,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "20/04/2024",
                        style: CustomTextStyles.titleSmallRobotoGray600,
                      )
                    ],
                  ),
                ),
                Container(
                  width: 112.h,
                  margin: EdgeInsets.only(
                    left: 32.h,
                    top: 6.v,
                  ),
                  child: Text(
                    "Encontrado en la calle",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.titleSmallRobotoGray600.copyWith(
                      height: 1.35,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCancelar(BuildContext context) {
    return CustomElevatedButton(
      width: 135.h,
      text: "Cancelar",
      buttonStyle: CustomButtonStyles.fillPrimaryContainer,
    );
  }

  /// Section Widget
  Widget _buildGuardar(BuildContext context) {
    return CustomElevatedButton(
      width: 135.h,
      text: "Guardar",
      buttonStyle: CustomButtonStyles.fillErrorContainer,
    );
  }
}
