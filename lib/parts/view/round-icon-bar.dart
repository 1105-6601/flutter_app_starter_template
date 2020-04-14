import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/parts/view/round-icon-bar-button.dart';

class RoundIconBar extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Container(
      height: 75,
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new RoundIconBarButton.large(
                icon: Icons.clear,
                iconColor: Colors.red,
                onPressed: () {
                },
              ),
              new RoundIconBarButton.small(
                icon: Icons.star,
                iconColor: Colors.blue,
                onPressed: () {
                },
              ),
              new RoundIconBarButton.large(
                icon: Icons.favorite,
                iconColor: Colors.green,
                onPressed: () {
                },
              ),
            ],
          ),
        )
    );
  }
}