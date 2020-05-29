import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_starter_template/parts/view/content-view.dart';

class RawContentView extends StatelessWidget
{
  final AnimationController animationController;
  final Animation animation;
  final Widget content;
  final VoidCallback onTap;

  RawContentView({
    Key key,
    this.animationController,
    this.animation,
    this.content,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return ContentView(
      animationController: animationController,
      animation: animation,
      content: content,
      paddingInner: const EdgeInsets.all(0),
      borderRadius: const BorderRadius.only(
          topLeft:     const Radius.circular(0),
          bottomLeft:  const Radius.circular(0),
          bottomRight: const Radius.circular(0),
          topRight:    const Radius.circular(0)
      ),
      boxShadow: const <BoxShadow>[],
      containerColor: Colors.transparent,
      containerColorFocus: Colors.transparent,
      onTap: onTap,
    );
  }
}
