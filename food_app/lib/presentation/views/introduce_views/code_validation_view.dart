import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/validation_bloc.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/utils/helper.dart';


class OtpScreen extends StatefulWidget {
  String? email;
  OtpScreen({Key? key,this.email}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<String> currentPin=["","","","","",""];
  SnackBar mySnackBar=SnackBar(content: Text("Code invalid"));
  TextEditingController pinOneController=TextEditingController();
  TextEditingController pinTwoController=TextEditingController();
  TextEditingController pinThreeController=TextEditingController();
  TextEditingController pinFourController=TextEditingController();
  TextEditingController pinFiveController=TextEditingController();
  TextEditingController pinSixController=TextEditingController();

  var  outlineInputBorder=OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.transparent),
  );
  int pinIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.yellow,
                Colors.black87
              ],
              begin: Alignment.topRight,
            )
        ),
        child: SingleChildScrollView(
          child: Container(
            height: Helper.getScreenHeight(context),
            child: BlocListener<ValidateBloc,ValidateState>(
              listener: (context,validState) {
                if (validState is ValidateSuccess) {
                    Navigator.of(context).pushReplacementNamed(RESET_PASSWORD_ROUTE,arguments:widget.email);
                }else  ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
              },
              child: Column(
                children: <Widget>[
                  buildExitButton(),
                  Expanded(
                      child: Container(
                        alignment: Alignment(0,0.5),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            buildSecurityText(),
                            SizedBox(height: 30,),
                            buidPinRow(),
                          ],
                        ),
                      )
                  ),
                  buildNumberPad(),
                ],
              ),
            ),
          ),
        )
      ),
    );

  }
  buildNumberPad() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyboardNumber(
                      n:1,
                      onPressed: () {
                        pinIndexSetup("1");
                      }
                  ),
                  KeyboardNumber(
                      n:2,
                      onPressed: () {
                        pinIndexSetup("2");
                      }
                  ),
                  KeyboardNumber(
                      n:3,
                      onPressed: () {
                        pinIndexSetup("3");
                      }
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyboardNumber(
                      n:4,
                      onPressed: () {
                        pinIndexSetup("4");
                      }
                  ),
                  KeyboardNumber(
                      n:5,
                      onPressed: () {
                        pinIndexSetup("5");
                      }
                  ),
                  KeyboardNumber(
                      n:6,
                      onPressed: () {
                        pinIndexSetup("6");
                      }
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyboardNumber(
                      n:7,
                      onPressed: () {
                        pinIndexSetup("7");
                      }
                  ),
                  KeyboardNumber(
                      n:8,
                      onPressed: () {
                        pinIndexSetup("8");
                      }
                  ),
                  KeyboardNumber(
                      n:9,
                      onPressed: () {
                        pinIndexSetup("9");
                      }
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 60.0,
                    child: MaterialButton(
                      onPressed: null,
                      child: SizedBox(),
                    ),
                  ),
                  KeyboardNumber(
                      n:0,
                      onPressed: () {
                        pinIndexSetup("0");
                      }
                  ),
                  Container(
                    width: 60.0,
                    child: MaterialButton(
                      height: 60.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      onPressed: () {
                          clearPin();
                      },
                      child: Icon(Icons.keyboard_return),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  pinIndexSetup (String text) {
    if(pinIndex==0) {
      pinIndex=1;
    }else if (pinIndex<6)
      pinIndex++;
    setPin(pinIndex,text);
    currentPin[pinIndex-1]=text;
    String strPin="";
    currentPin.forEach((element) {
      strPin +=element;
    });
    if(pinIndex == 6) {
      print(strPin);
      BlocProvider.of<ValidateBloc>(context).add(ValidateEvent(code:int.parse(strPin),email:widget.email!));
    }
  }

  setPin(int n,String text) {
    switch(n) {
      case 1:
        pinOneController.text=text;
        break;
      case 2:
        pinTwoController.text=text;
        break;
      case 3:
        pinThreeController.text=text;
        break;
      case 4:
        pinFourController.text=text;
        break;
      case 5:
        pinFiveController.text=text;
        break;
      case 6:
        pinSixController.text=text;
        break;
    }
  }

  clearPin() {
    if(pinIndex ==0) {
      pinIndex=0;
    }else if(pinIndex==6){
      setPin(pinIndex,"");
      currentPin[pinIndex-1]="";
      pinIndex--;
    }else {
      setPin(pinIndex,"");
      currentPin[pinIndex-1]="";
      pinIndex--;
    }

  }

  buidPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PINNumber(
          outlineInputBorder:outlineInputBorder,
          textEditingController:pinOneController,
        ),
        PINNumber(
          outlineInputBorder:outlineInputBorder,
          textEditingController:pinTwoController,
        ),
        PINNumber(
          outlineInputBorder:outlineInputBorder,
          textEditingController:pinThreeController,
        ),
        PINNumber(
          outlineInputBorder:outlineInputBorder,
          textEditingController:pinFourController,
        ),
        PINNumber(
          outlineInputBorder:outlineInputBorder,
          textEditingController:pinFiveController,
        ),
        PINNumber(
          outlineInputBorder:outlineInputBorder,
          textEditingController:pinSixController,
        )
      ],
    );
  }

  buildSecurityText () {
    return Text("Security PIN",
      style:TextStyle(
        color: Colors.white70,
        fontSize: 21.0,
        fontWeight: FontWeight.bold
    ),
    );
  }

  buildExitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
            padding: EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            height: 50.0,
            minWidth: 50.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Icon(Icons.clear,color:Colors.white),
          ),
        )
      ],
    );
  }
}

class PINNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;
  PINNumber({Key? key,required this.textEditingController,required this.outlineInputBorder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.0),
          border: outlineInputBorder,
          filled: true,
          fillColor: Colors.white30,
        ),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21.0,
          color: Colors.white,

        ),
      ),
    );
  }
}

class KeyboardNumber extends StatelessWidget {
  final int n;
  final Function() onPressed;
  KeyboardNumber({Key? key,required this.n,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        shape:BoxShape.circle,
        color: Colors.purpleAccent.withOpacity(0.1),
      ),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: EdgeInsets.all(8.0),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),

        ),
        height: 90.0,
        child: Text("$n",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24*MediaQuery.of(context).textScaleFactor,
            color:Colors.white,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
    );
  }
}



