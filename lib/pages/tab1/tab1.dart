import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/app-theme.dart';
import 'package:flutter_app_starter_template/parts/view/content-view-inner-sample.dart';
import 'package:flutter_app_starter_template/parts/view/content-view.dart';
import 'package:flutter_app_starter_template/parts/view/line-chart-sample.dart';
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
  }) : super.list(
    key: key,
    animationController: animationController,
    changeTabBody: changeTabBody,
  );

  @override
  String getTitle()
  {
    return 'Dashboard UI';
  }

  @override
  Image resolveIconImage()
  {
    return Image.asset('images/icon-l.png');
  }

  @override
  Future<List<Widget>> initWidgets() async
  {
    final listViews = <Widget>[];

    int i = 0;

    listViews.add(
      TitleView(
        title: 'タイトル',
        subTitle: 'Side scroll view',
        animation: UiUtil.createAnimation(animationController, i++),
        animationController: animationController,
      ),
    );

    listViews.add(
        SideScrollView(
          mainScreenAnimation: UiUtil.createAnimation(animationController, i++),
          mainScreenAnimationController: animationController,
          configs: <SideScrollViewItemConfig>[
            SideScrollViewItemConfig(
              title: 'コンテンツ1',
              body: 'テキスト' * 7,
              emblemImage: Image.asset('images/icon-l.png'),
              counterNum: 1000,
            ),
            SideScrollViewItemConfig(
                title: 'コンテンツ2',
                body: 'テキスト' * 7,
                emblemImage: Image.asset('images/icon-o.png'),
                counterNum: 2000,
                counterUnit: '個'
            ),
            SideScrollViewItemConfig(
                title: 'コンテンツ3',
                body: 'テキスト' * 7,
                emblemImage: Image.asset('images/icon-g.png'),
                counterNum: 3000,
                counterUnit: 'GB'
            ),
            SideScrollViewItemConfig(
                title: 'タイトル',
                body: 'テキスト' * 15,
                bodyMaxLines: 6,
                counterNum: 4000,
                counterUnit: 'mm'
            ),
            SideScrollViewItemConfig(
                title: 'タイトル',
                body: 'テキスト' * 15,
                bodyMaxLines: 6,
                counterNum: 5000,
                counterUnit: 'px'
            ),
            SideScrollViewItemConfig(
              title: 'タイトル',
              body: 'テキスト' * 19,
              bodyMaxLines: 8,
              showCounter: false,
            ),
            SideScrollViewItemConfig(
                title: 'タイトル',
                body: 'テキスト' * 16,
                bodyMaxLines: 7,
                fullHeight: true,
                counterNum: 6000,
                counterUnit: 'pt'
            ),
            SideScrollViewItemConfig(
              title: 'タイトル',
              body: 'テキスト' * 21,
              bodyMaxLines: 9,
              fullHeight: true,
              showCounter: false,
            ),
            SideScrollViewItemConfig(
              title: 'ワイドコンテンツ1',
              body: 'テキスト' * 16,
              emblemImage: Image.asset('images/icon-l.png'),
              counterNum: 1000,
              width: 250,
            ),
            SideScrollViewItemConfig(
              title: 'ワイドコンテンツ2',
              body: 'テキスト' * 32,
              bodyMaxLines: 6,
              counterNum: 4000,
              counterUnit: 'mm',
              width: 250,
            ),
            SideScrollViewItemConfig(
              title: 'ワイドコンテンツ3（フル）',
              body: 'テキスト' * 48,
              bodyMaxLines: 9,
              fullHeight: true,
              showCounter: false,
              width: 250,
            ),
          ],
        )
    );

    listViews.add(
      TitleView(
        title: 'タイトル',
        subTitle: 'Line chart sample',
        animation: UiUtil.createAnimation(animationController, i++),
        animationController: animationController,
      ),
    );

    listViews.add(
      ContentView(
        animationController: animationController,
        animation: UiUtil.createAnimation(animationController, i++),
        containerColor: AppTheme.chartBg,
        paddingInner: const EdgeInsets.only(right: 30, left: 6, top: 30, bottom: 6),
        content: LineChartSample(),
      ),
    );

    listViews.add(
      TitleView(
        title: 'タイトル',
        subTitle: 'Sample content',
        animation: UiUtil.createAnimation(animationController, i++),
        animationController: animationController,
      ),
    );

    listViews.add(
      ContentView(
        animationController: animationController,
        animation: UiUtil.createAnimation(animationController, i++),
        content: ContentViewInnerSample(
          animationController: animationController,
          animation: UiUtil.createAnimation(animationController, i),
        ),
      ),
    );

    listViews.add(
      TitleView(
        title: 'タイトル',
        subTitle: 'マルチバイト',
        iconPositionTop: 2,
        animation: UiUtil.createAnimation(animationController, i++),
        animationController: animationController,
      ),
    );

    listViews.add(
      ContentView(
        animationController: animationController,
        animation: UiUtil.createAnimation(animationController, i++),
        content: Container(
          child: Text('コンテンツ2'),
        ),
      ),
    );

    listViews.add(
      TitleView(
        title: 'タイトル',
        subTitle: 'Mixed サブタイトル',
        iconPositionTop: 2,
        animation: UiUtil.createAnimation(animationController, i++),
        animationController: animationController,
      ),
    );

    listViews.add(
      ContentView(
        animationController: animationController,
        animation: UiUtil.createAnimation(animationController, i++),
        content: Container(
          child: Text('コンテンツ3'),
        ),
      ),
    );

    listViews.add(
      TitleView(
        title: 'タイトル',
        subTitle: 'アイコン無し',
        subTitleIcon: false,
        animation: UiUtil.createAnimation(animationController, i++),
        animationController: animationController,
      ),
    );

    listViews.add(
      ContentView(
        animationController: animationController,
        animation: UiUtil.createAnimation(animationController, i++),
        content: Container(
          child: Text('コンテンツ4'),
        ),
      ),
    );

    listViews.add(
      TitleView(
        title: 'タイトル',
        subTitle: 'アイコン変更',
        subTitleIconData: Icons.add_box,
        iconPositionTop: 3,
        animation: UiUtil.createAnimation(animationController, i++),
        animationController: animationController,
      ),
    );

    listViews.add(
      ContentView(
        animationController: animationController,
        animation: UiUtil.createAnimation(animationController, i++),
        content: Container(
          child: Text('コンテンツ5'),
        ),
      ),
    );

    listViews.add(
      TitleView(
        title: 'タイトル',
        subTitle: 'No icon subtitle',
        subTitlePositionTop: 3,
        subTitleIcon: false,
        animation: UiUtil.createAnimation(animationController, i++),
        animationController: animationController,
      ),
    );

    listViews.add(
      ContentView(
        animationController: animationController,
        animation: UiUtil.createAnimation(animationController, i++),
        content: Container(
          child: Text('コンテンツ6'),
        ),
      ),
    );

    return listViews;
  }
}
