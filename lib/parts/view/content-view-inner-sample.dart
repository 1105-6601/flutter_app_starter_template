import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_starter_template/pages/login/login.dart';
import '../../app-theme.dart';
import 'animated-view.dart';

class ContentViewInnerSample extends StatelessWidget
{
  final AnimationController animationController;
  final Animation animation;

  ContentViewInnerSample({
    Key key,
    this.animationController,
    this.animation,
  }) : super(key: key);

  void _moveToLoginRoute(BuildContext context)
  {
    Route route = MaterialPageRoute(builder: (context) => Login());
    Navigator.pushReplacement(context, route);
  }

  @override
  Widget build(BuildContext context)
  {
    return AnimatedView(
      animationController: animationController,
      animation: animation,
      childBuilder: getChild
    );
  }

  Widget getChild(BuildContext context, Animation animation)
  {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: getDefaultUI(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Container(
                  width: 108,
                  height: 108,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/no-image-w.png'),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.7),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'テキスト',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.2,
                        color: AppTheme.darkText,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Container(
                        height: 4,
                        width: 70 * animation.value,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                AppTheme.gradation3,
                                AppTheme.gradation5,
                                AppTheme.gradation8,
                              ], begin: Alignment.topLeft, end: Alignment.bottomRight
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        'Text',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AppTheme.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'テキスト',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.2,
                        color: AppTheme.darkText,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Container(
                        height: 4,
                        width: 70 * animation.value,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                AppTheme.gradation7,
                                AppTheme.gradation9,
                                AppTheme.gradation10,
                              ], begin: Alignment.topLeft, end: Alignment.bottomRight
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        'Text',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AppTheme.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      child: Text(
                        'ログアウト',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.normal,
                          fontSize: 11,
                          letterSpacing: 0.5,
                          color: AppTheme.darkBlue,
                        ),
                      ),
                      onTap: () {
                        _moveToLoginRoute(context);
                      },
                    ),
                    SizedBox(
                      height: 38,
                      width: 26,
                      child: Icon(
                        Icons.exit_to_app,
                        color: AppTheme.darkText,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> getDefaultUI()
  {
    return [
      Row(
        children: <Widget>[
          Container(
            height: 48 * animation.value,
            width: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    AppTheme.gradation1,
                    AppTheme.gradation3,
                    AppTheme.gradation4,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
          Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 2),
                      child: Text(
                        'テキスト',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: -0.1,
                          color: AppTheme.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 3),
                      child: Text(
                        'テキスト',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          color: AppTheme.darkerText,
                        ),
                      ),
                    ),
                  ],
                ),
              )
          )
        ],
      ),
      SizedBox(
        height: 8,
      ),
      Row(
        children: <Widget>[
          Container(
            height: 48 * animation.value,
            width: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    AppTheme.gradation4,
                    AppTheme.gradation5,
                    AppTheme.gradation6,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
          Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 2),
                      child: Text(
                        'テキスト',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily:
                          AppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: -0.1,
                          color: AppTheme.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 4, bottom: 3),
                      child: Text(
                        'テキスト',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily:
                          AppTheme.fontName,
                          fontWeight:
                          FontWeight.w600,
                          fontSize: 12,
                          color: AppTheme.darkerText,
                        ),
                      ),
                    ),
                  ],
                ),
              )
          )
        ],
      )
    ];
  }
}
