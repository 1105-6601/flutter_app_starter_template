import 'package:flutter/material.dart';

import '../../app-theme.dart';

class SideScrollViewItemConfig
{
  final Image emblemImage;
  final String title;
  final String body;
  final int bodyMaxLines;
  final bool showCounter;
  final int counterNum;
  final String counterUnit;
  final bool fullHeight;
  final List<Color> bgGradientColors;

  SideScrollViewItemConfig({
    this.emblemImage,
    this.title,
    this.body,
    this.bodyMaxLines: 3,
    this.showCounter: true,
    this.counterNum: 0,
    this.counterUnit: '件',
    this.fullHeight: false,
    this.bgGradientColors: const <Color>[
      AppTheme.darkGrey,
      AppTheme.darkGrey,
    ]
  });
}