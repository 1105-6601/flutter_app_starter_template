import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/pages/login/parts/login-view.dart';
import 'package:flutter_app_starter_template/repository/user.repository.dart';
import 'package:flutter_app_starter_template/service/auth.service.dart';
import 'package:flutter_app_starter_template/storage/user-data.storage.dart';
import 'package:flutter_app_starter_template/util/ui-util.dart';
import '../../app-theme.dart';
import '../authorized.dart';

class Login extends StatefulWidget
{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin
{
  UserRepository _userRepository;

  AnimationController _animationController;

  @override
  void initState()
  {
    _userRepository = UserRepository();

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000),
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

  Future<bool> _init() async
  {
    // If already have token, check its validity.
    if (await AuthService.hasAuthToken() && await _checkTokenValidity()) {
      // If token is valid, move to authorized view automatically.
      this._moveToAuthorizedRoute();
    } else {
      // If token does not exist or token is invalid, delete stored data on device storage.
      await AuthService.logOut();
    }

    return true;
  }

  @override
  Widget build(BuildContext context)
  {
    return buildContainer();
  }

  Widget buildContainer()
  {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: _init(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {

            if (!snapshot.hasData) {
              return Container();
            }

            return LoginView(
              animationController: _animationController,
              animation: UiUtil.createAnimation(_animationController, 0),
              onSubmit: login,
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> login(String email, String password) async
  {
    final onFinish = UiUtil.showProgressIndicator(context);

    // FIXME: 適宜コメント解除して実装
//    bool ng = false;
//    try {
//      final response = await _userRepository.login(email, password);
//      AuthService.login(response['token']);
//    } catch(e) {
//      ng = true;
//    }
//
//    onFinish();
//
//    if (ng) {
//      UiUtil.alert(context,
//        title: 'ログイン出来ませんでした',
//        body: 'メールアドレス、又はパスワードが正しく入力されているかご確認下さい。'
//      );
//      return;
//    }

    /// ローディングアニメーション実装サンプル
    Future.delayed(Duration(seconds: 1), () {
      onFinish();
      this._moveToAuthorizedRoute();
    });
  }

  Future<bool> _checkTokenValidity() async
  {
    try {
      // Save user data to device storage.
      await UserDataStorage.set(await _userRepository.isValid());
    } catch(e) {
      return false;
    }

    return true;
  }

  void _moveToAuthorizedRoute()
  {
    Route route = MaterialPageRoute(builder: (context) => Authorized());
    Navigator.pushReplacement(context, route);
  }
}
