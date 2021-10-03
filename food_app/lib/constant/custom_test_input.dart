import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTestInput extends StatelessWidget {
  final String _hintText;
  final IconData? _icons;
  final TextInputType? _textInputType;
  final TextInputAction? _textInputAction;
  final bool _obscureText;
  const CustomTestInput({
    required String hintText,
    IconData? icons,
    TextInputType? textInputType,
    TextInputAction? textInputAction,
    bool obscureText=false,
    Key? key,
  }) : _hintText=hintText,
        _textInputType=textInputType,
        _textInputAction=textInputAction,
        _icons=icons,
        _obscureText=obscureText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: ShapeDecoration(
          color: AppColor.placeholder_bg,
          shape:StadiumBorder()
      ),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  _icons,
                  size:25,
                ),
              ),
              hintText: _hintText,
              hintStyle: TextStyle(
                color: AppColor.placeholder,
              ),
              contentPadding: const EdgeInsets.only(left: 40)
          ),
          keyboardType: _textInputType,
          textInputAction: _textInputAction,
          obscureText: _obscureText,
        ),
      ),
    );
  }
}