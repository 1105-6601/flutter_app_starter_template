import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_starter_template/util/ui-util.dart';
import '../app-theme.dart';

abstract class BaseTab extends StatefulWidget
{
  const BaseTab({
    Key key,
    this.animationController,
    this.changeTabBody,
  }) : super(key: key);

  final AnimationController animationController;
  final Function(Widget widget) changeTabBody;

  @override
  _BaseTabState createState() => _BaseTabState();

  @protected
  List<Widget> createListViews();

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

  List<Widget> _listViews = <Widget>[];

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

    _listViews = widget.createListViews();

    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI()
  {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: _listViews.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        widget.animationController.forward();

        return _listViews[index];
      },
    );
  }

  Widget getAppBarUI()
  {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: _topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(0.0, 30 * (1.0 - _topBarAnimation.value), 0.0),
                child: Container(
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
                ),
              ),
            );
          },
        )
      ],
    );
  }
}