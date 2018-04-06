import 'package:flutter/material.dart';

class Colors {

  const Colors();

  // --- ACCENT COLORS ---
  static const Color appBarTitle = const Color(0xffffffff);
  static const Color appBarIconColor = const Color(0xff9b8200);
  static const Color appBarDetailBackground = const Color(0x00FFFFFF);
  static const Color appBarGradientStart = const Color(0xff9b6900);
  static const Color appBarGradientEnd = const Color(0xffc68600);
  static const Color accentcolor = const Color(0xff0f4a98);
  static const Color liquorDetailGradientStart = const Color(0x00736AB7);
  static const Color liquorDetailGradientEnd = const Color(0xff9b8200);

  //  --- TEXT COLORS ---
  //static const Color planetCard = const Color(0xFF434273);
  static const Color liquorCard = const Color(0xffffd600);
  //static const Color planetListBackground = const Color(0xFF3E3963);
  static const Color liquorPageBackground = const Color(0xff9b8200);
  static const Color liquorTitle = const Color(0xff212121);
  static const Color liquorType = const Color(0xff212121);
  static const Color liquorPrice = const Color(0xff212121);
  static const Color liquorDetail = const Color(0xFFFFFFFF);


}

class Dimens {
  const Dimens();

  static const liquorWidth = 100.0;
  static const liquorHeight = 100.0;
}

class TextStyles {

  const TextStyles();

  static const TextStyle appBarTitle = const TextStyle(
      color: Colors.appBarTitle,
      fontFamily: 'Typewriter',
      fontWeight: FontWeight.w600,
      fontSize: 36.0
  );

  static const TextStyle liquorTitle = const TextStyle(
      color: Colors.liquorTitle,
      fontFamily: 'Typewriter',
      fontWeight: FontWeight.w600,
      fontSize: 24.0
  );

  static const TextStyle liquorType = const TextStyle(
      color: Colors.liquorType,
      fontFamily: 'Typewriter',
      fontWeight: FontWeight.w300,
      fontSize: 14.0
  );

  static const TextStyle liquorPrice = const TextStyle(
      color: Colors.liquorPrice,
      fontFamily: 'Typewriter',
      fontWeight: FontWeight.w300,
      fontSize: 16.0
  );

  static const TextStyle liquorDetailHeading = const TextStyle(
      color: Colors.liquorDetail,
      fontFamily: 'Typewriter',
      fontWeight: FontWeight.w300,
      fontSize: 24.0
  );
  static const TextStyle liquorDetail = const TextStyle(
      color: Colors.liquorDetail,
      fontFamily: 'Typewriter',
      fontWeight: FontWeight.w300,
      fontSize: 14.0
  );




}