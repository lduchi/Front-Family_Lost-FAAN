import 'package:familylost_faan/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_radio_button.dart';
import '../core/utils/image_constant.dart';
import '../theme/app_decoration.dart';
import '../theme/custom_text_style.dart';
import '../theme/theme_helper.dart';
import '../widgets/custom_image_view.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class SeleccionarTipoDePublicaciNScreen extends StatelessWidget {
  SeleccionarTipoDePublicaciNScreen({Key? key})
      : super(
          key: key,
        );

  String radioGroup = "";

  List<String> radioList = ["lbl_encontrado", "lbl_adopci_n"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 45.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SizedBox(height: 5.v), _buildSeleccionarTipo(context)],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSeleccionarTipo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 18.v,
      ),
      decoration: AppDecoration.outlineBlack9001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 29.v),
          Text(
            "¡Seleccione un tipo!",
            style: theme.textTheme.headlineLarge,
          ),
          SizedBox(height: 6.v),
          SizedBox(
            width: 128.h,
            child: Text(
              "Seleccione el tipo de publicación a crear:",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.bodyMediumRobotoGray60001.copyWith(
                height: 1.54,
              ),
            ),
          ),
          SizedBox(height: 26.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 92.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgInformationCir,
                    height: 14.adaptSize,
                    width: 14.adaptSize,
                    margin: EdgeInsets.only(
                      top: 3.v,
                      bottom: 4.v,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 17.h),
                    child: Text(
                      "Perdido",
                      style: theme.textTheme.titleMedium,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 13.v),
          Padding(
            padding: EdgeInsets.only(
              left: 92.h,
              right: 108.h,
            ),
            child: Column(
              children: [
                CustomRadioButton(
                  text: "Encontrado",
                  value: radioList[0],
                  groupValue: radioGroup,
                  onChange: (value) {
                    radioGroup = value;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.v,
                    right: 16.h,
                  ),
                  child: CustomRadioButton(
                    text: "Adopción",
                    value: radioList[1],
                    groupValue: radioGroup,
                    onChange: (value) {
                      radioGroup = value;
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 68.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomElevatedButton(
                  height: 48.v,
                  text: "Continuar",
                  margin: EdgeInsets.only(right: 4.h),
                  buttonStyle: CustomButtonStyles.fillErrorContainer,
                  buttonTextStyle: CustomTextStyles.titleMediumPrimary,
                ),
              ),
              Expanded(
                child: CustomElevatedButton(
                  height: 48.v,
                  text: "Cancelar",
                  margin: EdgeInsets.only(left: 4.h),
                  buttonStyle: CustomButtonStyles.fillPrimaryContainerTL15,
                  buttonTextStyle: CustomTextStyles.titleMediumPrimary,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
