import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_starter_template/pages/login/login.dart';

import 'app-theme.dart';

void main() async
{
  // ネイティブプラグインを利用している場合、`runApp()`をコールする前に呼び出しておく必要有り
  WidgetsFlutterBinding.ensureInitialized();

  // ステータスバー、ナビゲーションバーのカラーを設定
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.grey,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  // デバイスの方向を縦方向（Up, Downのみ）に固定
  // 先に`WidgetsFlutterBinding.ensureInitialized()`のコールが必要
  await SystemChrome
      .setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(AppRoot()));
}

class AppRoot extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BotToastInit(
      child: getMaterialApp(),
    );
  }

  Widget getMaterialApp()
  {
    return MaterialApp(
      title: 'Flutter App Starter Template',
      navigatorObservers: [
        BotToastNavigatorObserver()
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: Login(),
    );
  }

}
