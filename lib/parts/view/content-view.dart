import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../app-theme.dart';
import 'animated-view.dart';

class ContentView extends StatelessWidget
{
  final AnimationController animationController;
  final Animation animation;
  final Widget content;

  ContentView({
    Key key,
    this.animationController,
    this.animation,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return AnimatedView(
      animationController: animationController,
      animation: animation,
      child: getChild(),
    );
  }

  Widget getChild()
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
          child: content,
        ),
      ),
    );
  }
}
