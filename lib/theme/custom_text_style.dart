import 'package:familylost_faan/core/utils/size_utils.dart';
import 'package:familylost_faan/theme/theme_helper.dart';
import 'package:flutter/material.dart';

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get openSans {
    return copyWith(
      fontFamily: 'Open Sans',
    );
  }

  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Body text style
  static get bodyMediumRobotoGray60001 =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.gray60001,
      );
  static get bodyMediumRobotoGray700 =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.gray700,
      );
// Title style
  static get titleLargeOpenSans => theme.textTheme.titleLarge!.openSans;
  static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallBold => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get titleSmallGray50 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray50,
      );
  static get titleSmallInter => theme.textTheme.titleSmall!.inter;
  static get titleSmallRobotoGray600 =>
      theme.textTheme.titleSmall!.roboto.copyWith(
        color: appTheme.gray600,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallRobotoGray60001 =>
      theme.textTheme.titleSmall!.roboto.copyWith(
        color: appTheme.gray60001,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w500,
      );
}
