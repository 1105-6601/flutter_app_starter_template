import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../app-theme.dart';

class UiUtil
{
  static VoidCallback showLoadingAnimation(BuildContext context, {String text = 'Loading...'})
  {
    final contents = Center(
      child: Container(
        height: 200,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SpinKitFadingCube(size: 44.0, color: AppTheme.darkGrey),
                Padding(
                  padding: const EdgeInsets.only(left: 44.0),
                  child: new Text(text),
                ),
              ],
            ),
          ),
        ),
      )
    );

    final entry = OverlayEntry(
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: size.width,
            height: size.height,
            color: AppTheme.shadow3,
            child: contents,
          )
        );
      }
    );

    Future.delayed(Duration.zero, () {
      Overlay.of(context).insert(entry);
    });

    /// Return onFinish function.
    return () {
      entry.remove();
    };
  }

  static VoidCallback showProgressIndicator(
    BuildContext context, {
    Color color: AppTheme.white
  })
  {
    final entry = OverlayEntry(
        builder: (context) {
          final size = MediaQuery.of(context).size;
          return Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: size.width,
                height: size.height,
                color: AppTheme.shadow3,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              )
          );
        }
    );

    Future.delayed(Duration.zero, () {
      Overlay.of(context).insert(entry);
    });

    /// Return onFinish function.
    return () {
      entry.remove();
    };
  }

  static void alert(BuildContext context, {
    String title,
    String body
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(dialogContext),
            ),
          ],
        );
      },
    );
  }

  static void confirm(BuildContext context, {
    String title,
    String body,
    VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            FlatButton(
              child: Text('キャンセル'),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(dialogContext);
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

  /// @see https://kapeli.com/cheat_sheets/iOS_Design.docset/Contents/Resources/Documents/index
  static bool isIPhoneAndOverThan5Point8InchModel(MediaQueryData mediaQuery)
  {
    if (!Platform.isIOS) {
      return false;
    }

    var size = mediaQuery.size;

    if (
      size.height == 812.0 || size.width == 812.0 ||
      size.height == 896.0 || size.width == 896.0
    ) {
      return true;
    }

    return false;
  }

  static double displayBottomMargin(BuildContext context)
  {
    var mediaQueryData = MediaQuery.of(context);

    if (!isIPhoneAndOverThan5Point8InchModel(mediaQueryData)) {
      return 0;
    }

    var homeIndicatorHeight = mediaQueryData.orientation == Orientation.portrait ? 22.0 : 20.0;

    return homeIndicatorHeight;
  }

  static Color hexColor(String hexColor)
  {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');

    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }

    return Color(int.parse(hexColor, radix: 16));
  }

  static Animation createAnimation(AnimationController animationController, int position, {
    double begin: 0.0,
    double end: 1.0,
    Curve curve: Curves.fastOutSlowIn
  })
  {
    final delay = 0.1;

    double actualDelay = delay * position;
    if (actualDelay > 1) {
      actualDelay = 1;
    }

    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(actualDelay, 1.0, curve: curve)
      )
    );
  }
}
