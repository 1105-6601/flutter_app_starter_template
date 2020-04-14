import 'package:flutter/cupertino.dart';

class StackedCard
{
  final List<String> photos;
  final String title;
  final String subTitle;

  StackedCard({
    @required this.photos,
    this.title,
    this.subTitle,
  });
}
