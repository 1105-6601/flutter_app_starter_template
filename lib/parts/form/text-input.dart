import 'package:flutter/material.dart';

typedef Validator = String Function(String value);

class TextInput extends StatelessWidget
{
  final TextEditingController controller;
  final String defaultValue;
  final String placeholder;
  final String errorMessage;
  final Widget icon;
  final bool required;
  final bool password;
  final TextInputType keyboardType;
  final ValueChanged onChanged;
  final VoidCallback onEnter;
  final Validator validator;
  final List<IconData> rightFloatIcons;
  final List<VoidCallback> rightFloatIconActions;
  final Color rightFloatIconColor;
  final double rightFloatIconSize;
  final double rightFloatIconMargin;
  final double rightFloatIconTop;

  TextInput({
    this.controller,
    this.defaultValue,
    this.placeholder,
    this.errorMessage: 'この項目は必須です。',
    this.icon,
    this.required,
    this.keyboardType,
    this.password,
    this.onChanged,
    this.onEnter,
    this.validator,
    this.rightFloatIcons: const [],
    this.rightFloatIconActions: const [],
    this.rightFloatIconColor: const Color(0x55000000),
    this.rightFloatIconSize: 22.0,
    this.rightFloatIconMargin: 8.0,
    this.rightFloatIconTop: 13.0,
  });

  @override
  Widget build(BuildContext context)
  {
    return Row(
      children: <Widget>[
        icon == null ? SizedBox(width: 45) : icon,
        Expanded(
          child: Stack(
            children: <Widget>[
              Positioned(
                child: TextFormField(
                  controller: controller,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  initialValue: defaultValue,
                  keyboardType: keyboardType,
                  obscureText: password,
                  decoration: InputDecoration(
                    hintText: placeholder,
                    hintMaxLines: 3,
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    if (onEnter != null) {
                      onEnter();
                    }
                  },
                  validator: (value) {
                    if (required && value.isEmpty) {
                      return errorMessage;
                    }

                    if (validator != null) {
                      final result = validator(value);
                      if (result != null) {
                        return result;
                      }
                    }

                    return null;
                  },
                  onChanged: onChanged,
                ),
              ),
              Positioned(
                top: 1,
                right: 1,
                bottom: 1,
                child: Container(
                    width: (rightFloatIcons.length * (rightFloatIconSize + rightFloatIconMargin)) * 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white,
                            Colors.white.withOpacity(0.1),
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                ),
              ),
              ...rightFloatIcons.map((icon) {
                final index = rightFloatIcons.indexOf(icon);
                return Positioned(
                  top: rightFloatIconTop,
                  right: (index * rightFloatIconSize) + ((index + 1) * rightFloatIconMargin),
                  child: GestureDetector(
                    onTap: () {
                      if (rightFloatIconActions.asMap().containsKey(index)) {
                        rightFloatIconActions[index]();
                      }
                    },
                    child: Icon(icon, size: rightFloatIconSize, color: rightFloatIconColor),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        SizedBox(width: 45),
      ],
    );
  }
}
