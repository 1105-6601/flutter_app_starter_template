import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/pages/tab1/tab1.dart';
import 'package:flutter_app_starter_template/pages/tab2/tab2.dart';
import 'package:flutter_app_starter_template/pages/tab3/tab3.dart';
import 'package:flutter_app_starter_template/parts/navigation/curved-navigation-bar.dart';
import 'package:flutter_app_starter_template/util/ui-util.dart';
import 'dart:async';
import '../app-theme.dart';

class Authorized extends StatefulWidget
{
  @override
  _AuthorizedState createState() => _AuthorizedState();
}

class _AuthorizedState extends State<Authorized> with TickerProviderStateMixin
{
  GlobalKey _navigationKey = GlobalKey();
  AnimationController _animationController;
  int _currentTabIndex = 0;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState()
  {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this
    );

    tabBody = Tab1(
      animationController: _animationController,
      changeTabBody: _changeTabBody,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 200), () {
        NavigationBarState().setCurrentState(_navigationKey.currentState);
      });
    });

    super.initState();
  }

  @override
  void dispose()
  {
    _animationController.dispose();

    super.dispose();
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
            tabBody,
            bottomBar(),
          ],
        ),
      ),
    );
  }

  List<Widget> getBottomBarIcons()
  {
    final list = [
      Icon(Icons.dashboard, size: 30),
      Icon(Icons.search, size: 30),
      Icon(Icons.settings, size: 30),
    ];

    return list;
  }

  Widget bottomBar()
  {
    return Positioned(
      left: 0,
      bottom: 0,
      width: MediaQuery.of(context).size.width,
      child: CurvedNavigationBar(
        key: _navigationKey,
        height: 50 + UiUtil.displayBottomMargin(context),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeOutExpo,
        items: getBottomBarIcons(),
        onTap: (index) {

          if (_currentTabIndex == index) {
            return;
          }

          _currentTabIndex = index;

          switch (index) {
            case 0:
              _changeTabBody(Tab1(
                animationController: _animationController,
                changeTabBody: _changeTabBody,
              ));
              break;

            case 1:
              _changeTabBody(Tab2(
                animationController: _animationController,
                changeTabBody: _changeTabBody,
              ));
              break;

            case 2:
              _changeTabBody(Tab3(
                animationController: _animationController,
                changeTabBody: _changeTabBody,
              ));
              break;
          }
        },
      ),
    );
  }

  void _changeTabBody(Widget widget)
  {
    _animationController.reverse().then<dynamic>((data) {
      if (!mounted) {
        return;
      }

      setState(() {
        tabBody = widget;
      });
    });
  }
}

class NavigationBarState
{
  static NavigationBarState _instance;

  factory NavigationBarState() {
    if (_instance == null) {
      _instance = new NavigationBarState._internal();
    }

    return _instance;
  }

  NavigationBarState._internal();

  CurvedNavigationBarState currentState;

  void setCurrentState(CurvedNavigationBarState state)
  {
    currentState = state;
  }

  CurvedNavigationBarState getCurrentState()
  {
    return currentState;
  }
}