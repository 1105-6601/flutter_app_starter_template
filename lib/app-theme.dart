import 'package:flutter/material.dart';

class AppTheme
{
  static const Color background      = Color(0xFFF2F3F8);
  static const Color nearlyBlack     = Color(0xFF213333);
  static const Color darkGrey        = Color(0xFF313A44);
  static const Color grey            = Color(0xFF3A5160);
  static const Color lightGrey       = Color(0xFFb9c2c7);
  static const Color darkWhite       = Color(0xFFF2F2F2);
  static const Color nearlyWhite     = Color(0xFFFAFAFA);
  static const Color white           = Color(0xFFFFFFFF);
  static const Color darkBlue        = Color(0xFF2633C5);
  static const Color darkRed         = Color(0xFFc52633);
  static const Color lightText       = Color(0xFF4A6572);
  static const Color darkText        = Color(0xFF253840);
  static const Color darkerText      = Color(0xFF17262A);
  static const Color deactivatedText = Color(0xFF767676);

  static const Color chatPrimary   = Color(0xff203152);
  static const Color chatGrey      = Color(0xffaeaeae);
  static const Color chatLightGrey = Color(0xffE1E1E1);

  static const Color chartBg = Color(0xff232d37);

  static const Color shadow1  = Color(0x11000000);
  static const Color shadow16 = Color(0x16000000);
  static const Color shadow2  = Color(0x22000000);
  static const Color shadow3  = Color(0x33000000);
  static const Color shadow4  = Color(0x44000000);
  static const Color shadow5  = Color(0x55000000);
  static const Color shadow6  = Color(0x66000000);
  static const Color shadow7  = Color(0x77000000);
  static const Color shadow8  = Color(0x88000000);
  static const Color shadow9  = Color(0x99000000);
  static const Color shadowA  = Color(0xAA000000);
  static const Color shadowB  = Color(0xBB000000);
  static const Color shadowC  = Color(0xCC000000);
  static const Color shadowD  = Color(0xDD000000);
  static const Color shadowE  = Color(0xEE000000);
  static const Color shadowF  = Color(0xFF000000);

  static const Color gradation1  = Color(0xFF405DE6);
  static const Color gradation2  = Color(0xFF5851DB);
  static const Color gradation3  = Color(0xFF833AB4);
  static const Color gradation4  = Color(0xFFC13584);
  static const Color gradation5  = Color(0xFFE1306C);
  static const Color gradation6  = Color(0xFFFD1D1D);
  static const Color gradation7  = Color(0xFFF56040);
  static const Color gradation8  = Color(0xFFF77737);
  static const Color gradation9  = Color(0xFFFCAF45);
  static const Color gradation10 = Color(0xFFFFDC80);

  static const String fontName = 'Roboto';

  static const TextTheme textTheme = TextTheme(
    display1: display1,
    headline: headline,
    title:    title,
    subtitle: subtitle,
    body2:    body2,
    body1:    body1,
    caption:  caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily:    fontName,
    fontWeight:    FontWeight.bold,
    fontSize:      36,
    letterSpacing: 0.4,
    height:        0.9,
    color:         darkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily:    fontName,
    fontWeight:    FontWeight.bold,
    fontSize:      24,
    letterSpacing: 0.27,
    color:         darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily:    fontName,
    fontWeight:    FontWeight.bold,
    fontSize:      16,
    letterSpacing: 0.18,
    color:         darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily:    fontName,
    fontWeight:    FontWeight.w400,
    fontSize:      14,
    letterSpacing: -0.04,
    color:         darkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily:    fontName,
    fontWeight:    FontWeight.w400,
    fontSize:      14,
    letterSpacing: 0.2,
    color:         darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily:    fontName,
    fontWeight:    FontWeight.w400,
    fontSize:      16,
    letterSpacing: -0.05,
    color:         darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily:    fontName,
    fontWeight:    FontWeight.w400,
    fontSize:      12,
    letterSpacing: 0.2,
    color:         lightText,
  );
}
