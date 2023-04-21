import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/typography/text_styles.dart';
import 'package:flutter/material.dart';

const double _smallTextScaleFactor = 0.80;

class DropAndGoTheme {
  static ThemeData get standard {
    return ThemeData(
      primaryColor: DropAndGoColors.primary,
      scaffoldBackgroundColor: DropAndGoColors.white,
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: DropAndGoColors.primary,
        height: 150
      ),
      // colorScheme:
      //     ColorScheme.fromSwatch(accentColor: LocalWalkersColors.accent),
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textTheme: _textTheme,
      // dialogBackgroundColor: LocalWalkersColors.inputFieldFill,
      dialogTheme: _dialogTheme,
      tooltipTheme: _tooltipTheme,
      bottomSheetTheme: _bottomSheetTheme,
      // tabBarTheme: _tabBarTheme,
      dividerTheme: _dividerTheme,
      scrollbarTheme: _scrollbarTheme,
    );
  }
  
 // static const Color _primaryColor = LocalWalkersColors.primary;

  static ThemeData get small {
    return standard.copyWith(textTheme: _smallTextTheme);
  }

  static ThemeData get medium {
    return standard.copyWith(textTheme: _smallTextTheme);
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: DropAndGoTextStyle.headline1,
      displayMedium: DropAndGoTextStyle.headline2,
      displaySmall: DropAndGoTextStyle.headline3,
      headlineMedium: DropAndGoTextStyle.headline4,
      headlineSmall: DropAndGoTextStyle.headline5,
      titleLarge: DropAndGoTextStyle.headline6,
      titleMedium: DropAndGoTextStyle.subtitle1,
      titleSmall: DropAndGoTextStyle.subtitle2,
      bodyLarge: DropAndGoTextStyle.bodyText1,
      bodyMedium: DropAndGoTextStyle.bodyText2,
      bodySmall: DropAndGoTextStyle.caption,
      labelSmall: DropAndGoTextStyle.overline,
      labelLarge: DropAndGoTextStyle.button,
    );
  }

  static TextTheme get _smallTextTheme {
    return TextTheme(
      displayLarge: DropAndGoTextStyle.headline1.copyWith(
        fontSize: _textTheme.displayLarge!.fontSize! * _smallTextScaleFactor,
      ),
      displayMedium: DropAndGoTextStyle.headline2.copyWith(
        fontSize: _textTheme.displayMedium!.fontSize! * _smallTextScaleFactor,
      ),
      displaySmall: DropAndGoTextStyle.headline3.copyWith(
        fontSize: _textTheme.displaySmall!.fontSize! * _smallTextScaleFactor,
      ),
      headlineMedium: DropAndGoTextStyle.headline4.copyWith(
        fontSize: _textTheme.headlineMedium!.fontSize! * _smallTextScaleFactor,
      ),
      headlineSmall: DropAndGoTextStyle.headline5.copyWith(
        fontSize: _textTheme.headlineSmall!.fontSize! * _smallTextScaleFactor,
      ),
      titleLarge: DropAndGoTextStyle.headline6.copyWith(
        fontSize: _textTheme.titleLarge!.fontSize! * _smallTextScaleFactor,
      ),
      titleMedium: DropAndGoTextStyle.subtitle1.copyWith(
        fontSize: _textTheme.titleMedium!.fontSize! * _smallTextScaleFactor,
      ),
      titleSmall: DropAndGoTextStyle.subtitle2.copyWith(
        fontSize: _textTheme.titleSmall!.fontSize! * _smallTextScaleFactor,
      ),
      bodyLarge: DropAndGoTextStyle.bodyText1.copyWith(
        fontSize: _textTheme.bodyLarge!.fontSize! * _smallTextScaleFactor,
      ),
      bodyMedium: DropAndGoTextStyle.bodyText2.copyWith(
        fontSize: _textTheme.bodyMedium!.fontSize! * _smallTextScaleFactor,
      ),
      bodySmall: DropAndGoTextStyle.caption.copyWith(
        fontSize: _textTheme.bodySmall!.fontSize! * _smallTextScaleFactor,
      ),
      labelSmall: DropAndGoTextStyle.overline.copyWith(
        fontSize: _textTheme.labelSmall!.fontSize! * _smallTextScaleFactor,
      ),
      labelLarge: DropAndGoTextStyle.button.copyWith(
        fontSize: _textTheme.labelLarge!.fontSize! * _smallTextScaleFactor,
      ),
    );
  }

  static AppBarTheme get _appBarTheme {
    return const AppBarTheme(
      color: DropAndGoColors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: DropAndGoColors.black,
      ),
      centerTitle: true
    );
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        // backgroundColor: LocalWalkersColors.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size(208, 54),
      ),
    );
  }

  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        // foregroundColor: LocalWalkersColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        // side: const BorderSide(color: LocalWalkersColors.white, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size(208, 54),
      ),
    );
  }

  static TooltipThemeData get _tooltipTheme {
    return const TooltipThemeData(
      decoration: BoxDecoration(
        // color: LocalWalkersColors.charcoal,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.all(10),
      // textStyle: TextStyle(color: LocalWalkersColors.white),
    );
  }

  static DialogTheme get _dialogTheme {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static BottomSheetThemeData get _bottomSheetTheme {
    return const BottomSheetThemeData(
      // backgroundColor: LocalWalkersColors.whiteBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
    );
  }

  // static TabBarTheme get _tabBarTheme {
  //   return const TabBarTheme(
  //     indicator: UnderlineTabIndicator(
  //       borderSide: BorderSide(
  //         width: 2.0,
  //         color: LocalWalkersColors.white,
  //       ),
  //     ),
  //     labelColor: LocalWalkersColors.white,
  //     unselectedLabelColor: LocalWalkersColors.black25,
  //     indicatorSize: TabBarIndicatorSize.tab,
  //   );
  // }

  static DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      space: 0,
      thickness: 1,
      // color: LocalWalkersColors.black25,
    );
  }

  static ScrollbarThemeData get _scrollbarTheme {
    return const ScrollbarThemeData().copyWith(
      // thumbColor: MaterialStateProperty.all(LocalWalkersColors.textBlue),
    );
  }
}
