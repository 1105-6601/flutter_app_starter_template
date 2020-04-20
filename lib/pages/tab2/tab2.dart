import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/parts/view/animated-view.dart';
import 'package:flutter_app_starter_template/parts/view/round-icon-bar-button.dart';
import 'package:flutter_app_starter_template/parts/view/round-icon-bar.dart';
import 'package:flutter_app_starter_template/parts/view/stacked-card-set.dart';
import 'package:flutter_app_starter_template/parts/view/stacked-card-view.dart';
import 'package:flutter_app_starter_template/parts/view/stacked-card.dart';
import 'package:flutter_app_starter_template/util/ui-util.dart';
import '../base-tab.dart';

class Tab2 extends BaseTab
{
  final AnimationController animationController;
  final Function(Widget widget) changeTabBody;

  const Tab2({
    Key key,
    this.animationController,
    this.changeTabBody,
  }) : super.column(
    key: key,
    animationController: animationController,
    changeTabBody: changeTabBody,
  );

  @override
  String getTitle()
  {
    return 'Tinder UI';
  }

  @override
  Image resolveIconImage()
  {
    return Image.asset('images/icon-o.png');
  }

  @override
  Future<List<Widget>> initWidgets(BuildContext context) async
  {
    final columns = <Widget>[];

    final cardSet = StackedCardSet(
      cards: [
        StackedCard(
          photos: [
            'images/profile/profile1.jpg',
            'images/profile/profile2.jpg',
            'images/profile/profile3.jpg',
          ],
          title: 'Your Name',
          subTitle: 'And Biography',
        ),
        StackedCard(
          photos: [
            'images/profile/profile4.jpg',
            'images/profile/profile5.jpg',
            'images/profile/profile6.jpg',
          ],
          title: '名前',
          subTitle: '自己紹介',
        ),
        StackedCard(
          photos: [
            'images/profile/profile7.jpg',
            'images/profile/profile8.jpg',
            'images/profile/profile9.jpg',
          ],
          title: 'Text here',
          subTitle: 'Text here',
        ),
        StackedCard(
          photos: [
            'images/profile/profile10.jpg',
            'images/profile/profile11.jpg',
            'images/profile/profile12.jpg',
          ],
          title: 'ここにテキストが入ります',
          subTitle: 'ここにテキストが入ります',
        ),
        StackedCard(
          photos: [
            'images/profile/profile13.jpg',
            'images/profile/profile14.jpg',
          ],
          title: 'MB 複合 Text',
          subTitle: 'MB 複合 Text',
        ),
      ],
    );

    columns.add(
      StackedCardView(
        animation: UiUtil.createAnimation(animationController, 1),
        animationController: animationController,
        cardSet: cardSet,
      )
    );

    final buttons = <RoundIconBarButton>[
      new RoundIconBarButton.large(
        icon: Icons.clear,
        iconColor: Colors.red,
        onPressed: () {
          cardSet.getFirstCard().slideLeft();
        },
      ),
      new RoundIconBarButton.small(
        icon: Icons.star,
        iconColor: Colors.blue,
        onPressed: () {
          cardSet.getFirstCard().slideUp();
        },
      ),
      new RoundIconBarButton.large(
        icon: Icons.favorite,
        iconColor: Colors.green,
        onPressed: () {
          cardSet.getFirstCard().slideRight();
        },
      )
    ];

    columns.add(
      AnimatedView(
        animation: UiUtil.createAnimation(animationController, 2),
        animationController: animationController,
        child: RoundIconBar(
          buttons: buttons,
        )
      ),
    );

    return columns;
  }
}
