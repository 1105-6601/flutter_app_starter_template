import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/parts/view/animated-view.dart';
import 'package:flutter_app_starter_template/util/ui-util.dart';
import '../../app-theme.dart';

enum ChangeBodyDirection {
  Left,
  Right,
}

class TabView extends StatefulWidget
{
  final AnimationController parentAnimationController;
  final Animation parentAnimation;
  final List<Widget> tabs;
  final List<Widget> children;
  final EdgeInsets bodyPadding;

  TabView({
    Key key,
    this.parentAnimationController,
    this.parentAnimation,
    @required this.tabs,
    @required this.children,
    this.bodyPadding: const EdgeInsets.all(0)
  }): super(key: key);

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with TickerProviderStateMixin
{
  int _currentTabIndex = 0;
  double _indicatorOffset = 0;
  double _indicatorStartPosition = 0;
  double _indicatorEndPosition = 0;
  double _indicatorWidth = 0;
  AnimationController _indicatorAnimationController;
  Animation<double> _indicatorAnimation;
  AnimationController _tabBodyAnimationController;
  Animation<double> _tabBodyAnimation;
  Offset _tabBodyOffsetStart;
  Offset _tabBodyOffsetEnd;
  Offset _tabBodyOffset = const Offset(0, 0);

  Widget _tabBody;

  @override
  void initState()
  {
    _indicatorAnimationController = AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this
    )
      ..addListener(() => setState(() {
        final distance = _indicatorEndPosition - _indicatorStartPosition;
        _indicatorOffset = _indicatorStartPosition + distance * _indicatorAnimation.value;
      }));

    _indicatorAnimation = UiUtil.createAnimation(_indicatorAnimationController, 0);

    _tabBodyAnimationController = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this
    )
      ..addListener(() => setState(() {
        _tabBodyOffset = Offset.lerp(
            _tabBodyOffsetStart,
            _tabBodyOffsetEnd,
            _tabBodyAnimation.value
        );
      }));

    _tabBodyAnimation = UiUtil.createAnimation(_tabBodyAnimationController, 0);

    _changeTabIndex(0);

    super.initState();
  }

  void _calculateIndicatorMeta()
  {
    final size = MediaQuery.of(context).size;

    _indicatorWidth = size.width / widget.tabs.length;
  }

  void _changeTabIndex(int index)
  {
    final ChangeBodyDirection direction = _currentTabIndex <= index ? ChangeBodyDirection.Right : ChangeBodyDirection.Left;

    // Move indicator
    _indicatorStartPosition = _currentTabIndex * _indicatorWidth;
    _currentTabIndex = index;
    _indicatorEndPosition = _currentTabIndex * _indicatorWidth;
    _indicatorAnimationController.forward(from: 0.0);

    // Change tab body
    _changeBody(direction);
  }

  void _changeBody(ChangeBodyDirection direction)
  {
    _tabBodyOffsetEnd = Offset(0, 0);

    switch (direction) {
      case ChangeBodyDirection.Right:
        _tabBodyOffsetStart = Offset(-100, 0);
        break;
      case ChangeBodyDirection.Left:
        _tabBodyOffsetStart = Offset(100, 0);
        break;
    }

    _tabBodyAnimationController.reverse(from: 1.0).then((_) {

      switch (direction) {
        case ChangeBodyDirection.Right:
          _tabBodyOffsetStart = Offset(100, 0);
          break;
        case ChangeBodyDirection.Left:
          _tabBodyOffsetStart = Offset(-100, 0);
          break;
      }

      _tabBodyAnimationController.forward(from: 0.0);

      setState(() {
        _tabBody = widget.children[_currentTabIndex];
      });
    });
  }

  @override
  void dispose()
  {
    _indicatorAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    _calculateIndicatorMeta();

    return _buildChild();
  }

  Widget _buildChild()
  {
    return Expanded(
      child: AnimatedView(
        animationController: widget.parentAnimationController,
        animation: widget.parentAnimation,
        child: Stack(
          children: <Widget>[
            // Menus
            _buildMenus(),
            // Menu indicators
            _buildInactiveIndicator(),
            _buildActiveIndicator(),
            // Body
            _buildBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenus()
  {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 50,
        width: double.infinity,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildTabs(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabs()
  {
    final tabs = <Widget>[];

    widget.tabs.asMap().forEach((index, tab) {
      tabs.add(
        Expanded(
          child: GestureDetector(
            child: Container(
              color: Colors.transparent,
              child: tab,
            ),
            onTap: () {
              _changeTabIndex(index);
            },
          ),
        )
      );
    });

    return tabs;
  }

  Widget _buildInactiveIndicator()
  {
    final List<Widget> indicators = [];

    widget.tabs.forEach((_) {
      indicators.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              height: 3,
              decoration: BoxDecoration(
                color: AppTheme.shadow3,
                borderRadius: BorderRadius.circular(2.5),
              ),
            )
          ),
        ),
      );
    });

    return Positioned(
      top: 46,
      left: 0,
      right: 0,
      child: Row(
        children: indicators,
      ),
    );
  }

  Widget _buildActiveIndicator()
  {
    final double horizontalPadding = 2;

    return Positioned(
      top: 46,
      left: _indicatorOffset,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Container(
          height: 3,
          width: _indicatorWidth - (horizontalPadding * 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.5),
            boxShadow: [
              BoxShadow(
                color: AppTheme.shadow2,
                blurRadius: 2,
                spreadRadius: 0,
                offset: const Offset(0, 1)
              ),
            ]
          ),
        ),
      ),
    );
  }

  Widget _buildBody()
  {
    return Positioned(
      top: 50,
      left: 0,
      right: 0,
      bottom: 0,
      child: FadeTransition(
        opacity: _tabBodyAnimation,
        child: Transform(
          transform: Matrix4.translationValues(_tabBodyOffset.dx, _tabBodyOffset.dy, 0.0),
          child: Padding(
            padding: widget.bodyPadding,
            child: Container(
              color: Colors.transparent,
              child: _tabBody,
            ),
          ),
        ),
      ),
    );
  }
}