
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/colors.dart';

class FillterButton extends StatelessWidget {
  final String title;
  bool? isSelected;
  FillterButton({
    Key? key, required this.title,bool ,this.isSelected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      child: OutlinedButton(
        onPressed: () {
          isSelected=true;
        },
        child: Text(title,style: TextStyle(color: isSelected ?? false  ?  Colors.white:Colors.black,fontSize: 16),),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isSelected?? false ?  AppColor.yellow:Colors.white
          ),
          side:MaterialStateProperty.all(BorderSide(color: AppColor.yellow,width: 1.5),),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
              )
          ),
        ),
      ),
    );
  }
}