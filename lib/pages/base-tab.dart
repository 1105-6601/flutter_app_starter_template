import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_starter_template/parts/view/animated-view.dart';
import 'package:flutter_app_starter_template/util/ui-util.dart';
import '../app-theme.dart';

enum BaseTabType
{
  List,
  Column,
}

abstract class BaseTab extends StatefulWidget
{
  const BaseTab({
    Key key,
    this.animationController,
    this.changeTabBody,
    this.type,
  }) : super(key: key);

  const BaseTab.list({
    Key key,
    this.animationController,
    this.changeTabBody,
  }) : type = BaseTabType.List, super(key: key);

  const BaseTab.column({
    Key key,
    this.animationController,
    this.changeTabBody,
  }) : type = BaseTabType.Column, super(key: key);

  final AnimationController animationController;
  final Function(Widget widget) changeTabBody;
  final BaseTabType type;

  @override
  _BaseTabState createState() => _BaseTabState();

  @protected
  List<Widget> generateWidgets();

  @protected
  Image resolveIconImage();

  @protected
  String getTitle();
}

class _BaseTabState extends State<BaseTab> with TickerProviderStateMixin
{
  ScrollController _scrollController = ScrollController();

  Animation<double> _topBarAnimation;

  double _topBarOpacity = 0.0;

  List<Widget> _widgets = <Widget>[];

  @override
  void initState()
  {
    _topBarAnimation = UiUtil.createAnimation(widget.animationController, 0);

    _scrollController.addListener(() {
      if (_scrollController.offset >= 24) {
        if (_topBarOpacity != 1.0) {
          setState(() {
            _topBarOpacity = 1.0;
          });
        }
      } else if (_scrollController.offset <= 24 && _scrollController.offset >= 0) {
        if (_topBarOpacity != _scrollController.offset / 24) {
          setState(() {
            _topBarOpacity = _scrollController.offset / 24;
          });
        }
      } else if (_scrollController.offset <= 0) {
        if (_topBarOpacity != 0.0) {
          setState(() {
            _topBarOpacity = 0.0;
          });
        }
      }
    });

    _widgets = widget.generateWidgets();

    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    widget.animationController.forward();

    switch (widget.type) {
      case BaseTabType.List:
        return createListView();
        break;
      case BaseTabType.Column:
        return createColumnView();
        break;
      default:
        return Container();
    }
  }

  Widget createListView()
  {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            buildListView(),
            buildAppBar(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget buildListView()
  {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: _widgets.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return _widgets[index];
      },
    );
  }

  Widget createColumnView()
  {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            buildColumnView(),
            buildAppBar(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget buildColumnView()
  {
    return Padding(
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        children: _widgets,
      ),
    );
  }

  Widget buildAppBar()
  {
    return Column(
      children: <Widget>[
        AnimatedView(
          animationController: widget.animationController,
          animation: _topBarAnimation,
          child: getChild(),
        ),
      ],
    );
  }

  Widget getChild()
  {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white.withOpacity(_topBarOpacity),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppTheme.grey.withOpacity(0.4 * _topBarOpacity),
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16 - 8.0 * _topBarOpacity,
                bottom: 12 - 8.0 * _topBarOpacity
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2, top: 8, bottom: 8),
                  child: new Container(
                    height: 40 - (10 * _topBarOpacity),
                    width: 40 - (10 * _topBarOpacity),
                    child: widget.resolveIconImage(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 8),
                    child: Text(
                      widget.getTitle(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w700,
                        fontSize: 18 + 6 - 6 * _topBarOpacity,
                        letterSpacing: 1.2,
                        color: AppTheme.darkerText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}