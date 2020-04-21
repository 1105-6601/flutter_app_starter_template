import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/parts/view/content-view.dart';
import 'package:flutter_app_starter_template/parts/view/tab-view.dart';
import 'package:flutter_app_starter_template/parts/view/title-view.dart';
import 'package:flutter_app_starter_template/util/ui-util.dart';
import '../base-tab.dart';

class Tab4 extends BaseTab
{
  final AnimationController animationController;
  final Function(Widget widget) changeTabBody;

  const Tab4({
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
    return 'Nested tabs UI';
  }

  @override
  Image resolveIconImage()
  {
    return Image.asset('images/icon-o.png');
  }

  @override
  Future<List<Widget>> initWidgets(BuildContext context) async
  {
    final listViews = <Widget>[];

    listViews.add(
      TabView(
        parentAnimationController: animationController,
        parentAnimation: UiUtil.createAnimation(animationController, 0),
        bodyPadding: const EdgeInsets.only(top: 16),
        tabs: [
          Icon(Icons.filter_1, size: 20),
          Icon(Icons.filter_2, size: 20),
          Icon(Icons.filter_3, size: 20),
          Icon(Icons.filter_4, size: 20),
        ],
        children: <Widget>[
          _buildTab(1),
          _buildTab(2),
          _buildTab(3),
          _buildTab(4),
        ]
      ),
    );

    return listViews;
  }

  Widget _buildTab(int index)
  {
    int i = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

        TitleView(
          title: 'タイトル$index',
          subTitle: 'Sub title',
          animation: UiUtil.createAnimation(animationController, i++),
          animationController: animationController,
        ),

        ContentView(
          animationController: animationController,
          animation: UiUtil.createAnimation(animationController, i++),
          content: Container(
            child: Text('コンテンツ$index'),
          ),
        ),

        TabView(
            key: GlobalKey(),
            parentAnimationController: animationController,
            parentAnimation: UiUtil.createAnimation(animationController, i++),
            bodyPadding: const EdgeInsets.only(top: 16),
            tabs: [
              Icon(Icons.filter_1, size: 20),
              Icon(Icons.filter_2, size: 20),
              Icon(Icons.filter_3, size: 20),
              Icon(Icons.filter_4, size: 20),
            ],
            children: <Widget>[
              _buildNestedTab('$index - 1'),
              _buildNestedTab('$index - 2'),
              _buildNestedTab('$index - 3'),
              _buildNestedTab('$index - 4'),
            ]
        ),

      ],
    );
  }

  Widget _buildNestedTab(String label)
  {
    int i = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

        TitleView(
          title: 'タイトル$label',
          subTitle: 'Sub title',
          animation: UiUtil.createAnimation(animationController, i++),
          animationController: animationController,
        ),

        ContentView(
          animationController: animationController,
          animation: UiUtil.createAnimation(animationController, i++),
          content: Container(
            child: Text('コンテンツ$label'),
          ),
        ),

      ],
    );
  }

}
