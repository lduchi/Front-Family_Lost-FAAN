import 'package:familylost_faan/core/app_export.dart';
import 'package:flutter/material.dart';
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppbarLeadingImage extends StatelessWidget {
  AppbarLeadingImage({Key? key, this.imagePath, this.margin, this.onTap})
      : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          imagePath: imagePath!,
          height: 28.adaptSize,
          width: 28.adaptSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
