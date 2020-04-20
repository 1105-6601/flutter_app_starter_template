import 'dart:ui';

import 'package:flutter/material.dart';

enum AnimatedDirection
{
  Vertical,
  Horizontal
}

/// `AnimatedView.child` is `StatelessWidget` or `State` only.
class AnimatedView extends StatelessWidget
{
  final AnimationController animationController;
  final Animation animation;
  final Widget child;
  final Function(BuildContext, Animation) childBuilder;
  final AnimatedDirection direction;
  final double movingDistance;
  final double endPosition;

  AnimatedView({
    Key key,
    this.animationController,
    this.animation,
    this.child,
    this.childBuilder,
    this.movingDistance: 30.0,
    this.endPosition: 0.0
  }) :
    direction = AnimatedDirection.Vertical,
    super(key: key);

  AnimatedView.horizontal({
     Key key,
     this.animationController,
     this.animation,
     this.child,
     this.childBuilder,
     this.movingDistance: 100.0,
     this.endPosition: 0.0
  }) :
      direction = AnimatedDirection.Horizontal,
      super(key: key);

  @override
  Widget build(BuildContext context)
  {
    final hasChildBuilder = childBuilder != null;

    return AnimatedBuilder(
      child: hasChildBuilder ? childBuilder(context, animation) : child,
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: _generateMatrix(animation),
            child: hasChildBuilder ? childBuilder(context, animation) : child,
          ),
        );
      },
    );
  }

  Matrix4 _generateMatrix(Animation animation)
  {
    final value = lerpDouble(movingDistance, endPosition, animation.value);

    final vertical   = Matrix4.translationValues(0.0, value, 0.0);
    final horizontal = Matrix4.translationValues(value, 0.0, 0.0);

    switch (direction) {
      case AnimatedDirection.Vertical:
        return vertical;
        break;
      case AnimatedDirection.Horizontal:
        return horizontal;
        break;
      default:
        return vertical;
    }
  }
}