import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/parts/view/side-scroll-view-item-config.dart';
import '../../app-theme.dart';

class SideScrollViewItem extends StatelessWidget
{
  final Animation animation;
  final AnimationController animationController;
  final SideScrollViewItemConfig config;

  const SideScrollViewItem({
    Key key,
    this.animation,
    this.animationController,
    this.config,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(100 * (1.0 - animation.value), 0.0, 0.0),
            child: getChild(),
          ),
        );
      },
    );
  }

  Widget getChild()
  {
    List<Widget> stackChildren = [];

    EdgeInsets innerPadding = const EdgeInsets.only(top: 60, left: 8, right: 8, bottom: 8);
    EdgeInsets outerPadding = const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 18);

    if (config.emblemImage == null) {
      innerPadding = const EdgeInsets.all(8);
    }

    if (config.fullHeight) {
      outerPadding = const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 18);
    }

    stackChildren.add(
      Padding(
        padding: outerPadding,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: AppTheme.darkGrey,
                  offset: const Offset(1.1, 4.0),
                  blurRadius: 8.0
              ),
            ],
            gradient: LinearGradient(
              colors: config.bgGradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(54.0),
            ),
          ),
          child: Padding(
            padding: innerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  config.title,
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 0.2,
                    color: AppTheme.white,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            config.body,
                            overflow: TextOverflow.ellipsis,
                            maxLines: config.bodyMaxLines,
                            style: TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              letterSpacing: 0.2,
                              color: AppTheme.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                config.showCounter
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      (config.counterNum * animation.value).floor().toString(),
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        letterSpacing: 0.2,
                        color: AppTheme.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 2),
                      child: Text(
                        config.counterUnit,
                        style: TextStyle(
                          fontFamily:
                          AppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          letterSpacing: 0.2,
                          color: AppTheme.white,
                        ),
                      ),
                    ),
                  ],
                )
                : const SizedBox(height: 0)
              ],
            ),
          ),
        ),
      )
    );

    if (config.emblemImage != null) {
      stackChildren.add(
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: AppTheme.nearlyWhite.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        )
      );
      stackChildren.add(
        Positioned(
          top: 12,
          left: 12,
          child: SizedBox(
            width: 60,
            height: 60,
            child: config.emblemImage,
          ),
        )
      );
    }

    return SizedBox(
      width: 130,
      child: Stack(
        children: stackChildren,
      ),
    );
  }
}
