import 'package:flutter/material.dart';
import '../../app-theme.dart';
import 'animated-view.dart';

class TitleView extends StatelessWidget
{
  final AnimationController animationController;
  final Animation animation;
  final String title;
  final String subTitle;
  final double subTitlePositionTop;
  final bool subTitleIcon;
  final IconData subTitleIconData;
  final double iconPositionTop;

  const TitleView({
    Key key,
    this.animationController,
    this.animation,
    this.title,
    this.subTitle,
    this.subTitlePositionTop: 0,
    this.subTitleIcon: true,
    this.subTitleIconData: Icons.arrow_forward,
    this.iconPositionTop: 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    final List<Widget> rowChildren = [
      Expanded(
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: AppTheme.fontName,
            fontWeight: FontWeight.w500,
            fontSize: 18,
            letterSpacing: 0.5,
            color: AppTheme.lightText,
          ),
        ),
      ),
    ];

    if (subTitle != null) {

      Widget icon = SizedBox();
      if (subTitleIcon) {
        icon = SizedBox(
          height: 18,
          width: 26,
          child: Icon(
            subTitleIconData,
            color: AppTheme.darkText,
            size: 18,
          ),
        );
      }

      rowChildren.add(InkWell(
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(left: 8, top: subTitlePositionTop),
          child: Row(
            children: <Widget>[
              Text(
                subTitle,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  letterSpacing: 0.5,
                  color: AppTheme.darkBlue,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: iconPositionTop),
                child: icon,
              )
            ],
          ),
        ),
      ));
    }

    return AnimatedView(
      animationController: animationController,
      animation: animation,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Row(
            children: rowChildren,
          ),
        ),
      ),
    );
  }
}
