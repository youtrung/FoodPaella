import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/helper.dart';

import 'colors.dart';

class CustomTestInput extends StatelessWidget {
  final String _hintText;
  final IconData? _icons;
  final TextInputType? _textInputType;
  final TextInputAction? _textInputAction;
  final String? Function(String?)? _validator;
  final Function(String)? _onChanged;
  final bool _obscureText;
  final TextEditingController? _textEditingController;
  FocusNode? _focusNode;
   CustomTestInput({
    required String hintText,
    IconData? icons,
    TextInputType? textInputType,
    TextInputAction? textInputAction,
    TextEditingController? textEditingController,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    bool obscureText=false,
     FocusNode? focusNode,
    Key? key,
  }) : _hintText=hintText,
        _textInputType=textInputType,
        _textInputAction=textInputAction,
        _icons=icons,
        _obscureText=obscureText,
        _onChanged=onChanged,
        _validator=validator,
        _textEditingController=textEditingController ,
        _focusNode=focusNode,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Helper.getScreenWidth(context)*0.9,
      height: 60,
      decoration: ShapeDecoration(
          color: AppColor.placeholder_bg,
          shape:StadiumBorder()
      ),
      child: Center(
        child: TextFormField(
          focusNode: _focusNode,
          controller: _textEditingController,
          validator: _validator,
          textAlign: TextAlign.start,
          onChanged: _onChanged,
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
              contentPadding: const EdgeInsets.only(left: 40,top: 15)
          ),
          keyboardType: _textInputType,
          textInputAction: _textInputAction,
          obscureText: _obscureText,
        ),
      ),
    );
  }
}