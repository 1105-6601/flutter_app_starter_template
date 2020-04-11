import 'package:flutter/material.dart';

class Button extends StatelessWidget
{
  final String text;
  final VoidCallback onPressed;

  Button({
    this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context)
  {
    return Row(
      children: <Widget>[
        SizedBox(width: 45),
        Expanded(
          child: ButtonTheme(
            child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: onPressed,
              child: Text(text),
            ),
          ),
        ),
        SizedBox(width: 45),
      ],
    );
  }
}
