import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_starter_template/parts/form/button.dart';
import 'package:flutter_app_starter_template/parts/form/text-input.dart';
import 'package:flutter_app_starter_template/parts/view/animated-view.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import '../../../app-theme.dart';

class LoginView extends StatefulWidget
{
  final AnimationController animationController;
  final Animation animation;
  final Future<dynamic>Function(String, String) onSubmit;

  const LoginView({
    Key key,
    this.animationController,
    this.animation,
    this.onSubmit,
  }) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginFormData
{
  String email = '';
  String password = '';
}

class _LoginViewState extends State<LoginView>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _LoginFormData _data = _LoginFormData();

  @override
  Widget build(BuildContext context)
  {
    precacheImage(AssetImage('images/logo.png'), context);

    widget.animationController.forward();

    return AnimatedView(
      animationController: widget.animationController,
      animation: widget.animation,
      child: getChild(),
    );
  }

  Widget getChild()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          height: 100,
          width: 220,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              fit: BoxFit.fitWidth,
              alignment: FractionalOffset.center,
              image: AssetImage('images/logo.png'),
            )
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextInput(
                      placeholder: 'Email',
                      required: false,
                      password: false,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        _data.email = value;
                      },
                    ),
                    TextInput(
                      placeholder: 'Password',
                      required: false,
                      password: true,
                      onChanged: (value) {
                        _data.password = value;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Button(
                        text: 'サインイン',
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }

                          widget.onSubmit(_data.email, _data.password);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                child: Text(
                                  'アカウントを作成',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11,
                                    letterSpacing: 0.5,
                                    color: AppTheme.grey,
                                  ),
                                ),
                                onTap: () async {
                                },
                              ),
                              SizedBox(
                                height: 11,
                                width: 26,
                                child: Icon(
                                  LineAwesomeIcons.coffee,
                                  color: AppTheme.darkText,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
