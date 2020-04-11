import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/parts/view/content-view.dart';
import 'package:flutter_app_starter_template/parts/view/sample-content.dart';
import 'package:flutter_app_starter_template/parts/view/side-scroll-view-item-config.dart';
import 'package:flutter_app_starter_template/parts/view/side-scroll-view.dart';
import 'package:flutter_app_starter_template/parts/view/title-view.dart';
import 'package:flutter_app_starter_template/util/ui-util.dart';
import '../base-tab.dart';

class Tab1 extends BaseTab
{
  final AnimationController animationController;
  final Function(Widget widget) changeTabBody;

  const Tab1({
    Key key,
    this.animationController,
    this.changeTabBody,
  }) : super(
    key: key,
    animationController: animationController,
    changeTabBody: changeTabBody,
  );

  @override
  String getTitle()
  {
    return 'ダッシュボード';
  }

  @override
  Image resolveIconImage()
  {
    return Image.asset('images/icon-l.png');
  }

  @override
  List<Widget> createListViews()
  {
    final listViews = <Widget>[];

    listViews.add(
      TitleView(
        title: 'タイトル0',
        subTitle: 'Side scroll view',
        animation: UiUtil.createAnimation(animationController, 0),
        animationController: animationController,
      ),
    );

    listViews.add(
      SideScrollView(
        mainScreenAnimation: UiUtil.createAnimation(animationController, 1),
        mainScreenAnimationController: animationController,
        configs: <SideScrollViewItemConfig>[
          SideScrollViewItemConfig(
            title: 'コンテンツ1',
            body: 'テキストテキストテキストテキストテキストテキストテキスト',
            emblemImage: Image.asset('images/icon-l.png'),
            counterNum: 1000,
          ),
          SideScrollViewItemConfig(
            title: 'コンテンツ2',
            body: 'テキストテキストテキストテキストテキストテキストテキスト',
            emblemImage: Image.asset('images/icon-o.png'),
            counterNum: 2000,
            counterUnit: '個'
          ),
          SideScrollViewItemConfig(
            title: 'コンテンツ3',
            body: 'テキストテキストテキストテキストテキストテキストテキスト',
            emblemImage: Image.asset('images/icon-g.png'),
            counterNum: 3000,
            counterUnit: 'GB'
          ),
          SideScrollViewItemConfig(
            title: 'タイトル',
            body: 'テキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキスト',
            bodyMaxLines: 6,
            counterNum: 4000,
            counterUnit: 'mm'
          ),
          SideScrollViewItemConfig(
            title: 'タイトル',
            body: 'テキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキスト',
            bodyMaxLines: 6,
            counterNum: 5000,
            counterUnit: 'px'
          ),
          SideScrollViewItemConfig(
            title: 'タイトル',
            body: 'テキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキスト',
            bodyMaxLines: 8,
            showCounter: false,
          ),
          SideScrollViewItemConfig(
            title: 'タイトル',
            body: 'テキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキスト',
            bodyMaxLines: 7,
            fullHeight: true,
            counterNum: 6000,
            counterUnit: 'pt'
          ),
          SideScrollViewItemConfig(
            title: 'タイトル',
            body: 'テキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキスト',
            bodyMaxLines: 9,
            fullHeight: true,
            showCounter: false,
          ),
        ],
      )
    );

    listViews.add(
      TitleView(
        title: 'タイトル1',
        subTitle: 'Alphabet Subtitle',
        animation: UiUtil.createAnimation(animationController, 2),
        animationController: animationController,
      ),
    );

    listViews.add(
      ContentView(
        animationController: animationController,
        animation: UiUtil.createAnimation(animationController, 3),
        content: SampleContent(
          animationController: animationController,
          animation: UiUtil.createAnimation(animationController, 3),
        ),
      ),
    );

    listViews.add(
      TitleView(
        title: 'タイトル2',
        subTitle: 'マルチバイトサブタイトル',
        iconPositionTop: 2,
        animation: UiUtil.createAnimation(animationController, 4),
        animationController: animationController,
      ),
    );

    listViews.add(
      ContentView(
        animationController: animationController,
        animation: UiUtil.createAnimation(animationController, 5),
        content: Container(
          child: Text('コンテンツ2'),
        ),
      ),
    );

    listViews.add(
      TitleView(
        title: 'タイトル3',
        subTitle: 'Mixed サブタイトル',
        iconPositionTop: 2,
        animation: UiUtil.createAnimation(animationController, 6),
        animationController: animationController,
      ),
    );

    listViews.add(
      ContentView(
        animationController: animationController,
        animation: UiUtil.createAnimation(animationController, 7),
        content: Container(
          child: Text('コンテンツ3'),
        ),
      ),
    );

    listViews.add(
      TitleView(
        title: 'タイトル4',
        subTitle: 'アイコン無しサブタイトル',
        subTitleIcon: false,
        animation: UiUtil.createAnimation(animationController, 8),
        animationController: animationController,
      ),
    );

    listViews.add(
      ContentView(
        animationController: animationController,
        animation: UiUtil.createAnimation(animationController, 9),
        content: Container(
          child: Text('コンテンツ4'),
        ),
      ),
    );

    listViews.add(
      TitleView(
        title: 'タイトル5',
        subTitle: 'アイコン変更サブタイトル',
        subTitleIconData: Icons.add_box,
        iconPositionTop: 3,
        animation: UiUtil.createAnimation(animationController, 10),
        animationController: animationController,
      ),
    );

    listViews.add(
      ContentView(
        animationController: animationController,
        animation: UiUtil.createAnimation(animationController, 11),
        content: Container(
          child: Text('コンテンツ5'),
        ),
      ),
    );

    listViews.add(
      TitleView(
        title: 'タイトル6',
        subTitle: 'No icon with alphabet subtitle',
        subTitlePositionTop: 3,
        subTitleIcon: false,
        animation: UiUtil.createAnimation(animationController, 12),
        animationController: animationController,
      ),
    );

    listViews.add(
      ContentView(
        animationController: animationController,
        animation: UiUtil.createAnimation(animationController, 13),
        content: Container(
          child: Text('コンテンツ6'),
        ),
      ),
    );

    return listViews;
  }
}
