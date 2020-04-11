import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/parts/view/side-scroll-view-item-config.dart';
import 'package:flutter_app_starter_template/parts/view/side-scroll-view-item.dart';
import 'package:flutter_app_starter_template/util/ui-util.dart';
import '../../app-theme.dart';

class SideScrollView extends StatefulWidget
{
  final Animation mainScreenAnimation;
  final AnimationController mainScreenAnimationController;
  final List<SideScrollViewItemConfig> configs;

  SideScrollView({
    Key key,
    this.mainScreenAnimation,
    this.mainScreenAnimationController,
    this.configs: const <SideScrollViewItemConfig>[]
  }) : super(key: key);

  @override
  _SideScrollViewState createState() => _SideScrollViewState();
}

class _SideScrollViewState extends State<SideScrollView> with TickerProviderStateMixin
{
  AnimationController _animationController;

  @override
  void initState()
  {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this
    );

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
    _animationController.forward();

    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: widget.configs.length == 0 ? getEmptyView() : getDefaultView(),
          ),
        );
      },
    );
  }

  Widget getDefaultView()
  {
    return Container(
      height: 216,
      width: double.infinity,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 0, right: 16, left: 16),
        itemCount: widget.configs.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return SideScrollViewItem(
            animation: UiUtil.createAnimation(_animationController, index),
            animationController: _animationController,
            config: widget.configs[index],
          );
        },
      ),
    );
  }

  Widget getEmptyView()
  {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(68.0)
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppTheme.grey.withOpacity(0.2),
              offset: Offset(1.1, 1.1),
              blurRadius: 10.0
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'コンテンツが有りません',
          ),
        ),
      ),
    );
  }
}
