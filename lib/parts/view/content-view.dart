import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'animated-view.dart';
import '../../app-theme.dart';

class ContentView extends StatefulWidget
{
  final AnimationController animationController;
  final Animation animation;
  final Widget content;
  final EdgeInsets padding;
  final EdgeInsets paddingInner;
  final BorderRadius borderRadius;
  final Color containerColor;
  final Color containerColorFocus;
  final VoidCallback onTap;

  ContentView({
    Key key,
    this.animationController,
    this.animation,
    this.content,
    this.padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
    this.paddingInner: const EdgeInsets.all(16),
    this.borderRadius: const BorderRadius.only(
        topLeft:     const Radius.circular(8.0),
        bottomLeft:  const Radius.circular(8.0),
        bottomRight: const Radius.circular(8.0),
        topRight:    const Radius.circular(68.0)
    ),
    this.containerColor: Colors.white,
    this.containerColorFocus: AppTheme.darkWhite,
    this.onTap,
  }) : super(key: key);

  @override
  _ContentViewState createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView>
{
  Color containerColor;

  @override
  void initState()
  {
    containerColor = widget.containerColor;

    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return AnimatedView(
      animationController: widget.animationController,
      animation: widget.animation,
      child: getChild(),
    );
  }

  Widget getChild()
  {
    return Padding(
      padding: widget.padding,
      child: GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            setState(() {
              containerColor = widget.containerColorFocus;
            });

            widget.onTap();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: widget.borderRadius,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppTheme.grey.withOpacity(0.2),
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0
              ),
            ],
          ),
          child: Padding(
            padding: widget.paddingInner,
            child: widget.content,
          ),
        ),
      ),
    );
  }
}
