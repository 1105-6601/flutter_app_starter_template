import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/parts/view/round-icon-bar-button.dart';

class RoundIconBar extends StatelessWidget
{
  final List<RoundIconBarButton> buttons;

  RoundIconBar({
    @required this.buttons,
  });

  @override
  Widget build(BuildContext context)
  {
    return Container(
      height: 75,
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: buttons,
          ),
        )
    );
  }
}