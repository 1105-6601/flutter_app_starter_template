import 'package:flutter/material.dart';

class TextAreaInput extends StatelessWidget
{
  final String defaultValue;
  final String placeholder;
  final Widget icon;
  final bool required;
  final ValueChanged onChanged;

  TextAreaInput({
      this.defaultValue,
      this.placeholder,
      this.icon,
      this.required,
      this.onChanged,
  });

  @override
  Widget build(BuildContext context)
  {
    return Row(
      children: <Widget>[
        icon == null ? SizedBox(width: 45) : icon,
        Expanded(
          child: TextFormField(
            initialValue: defaultValue,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              hintText: placeholder,
              hintMaxLines: 3,
            ),
            validator: (value) {
              if (required && value.isEmpty) {
                return 'この項目は必須です。';
              }

              return null;
            },
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: 45),
      ],
    );
  }
}
