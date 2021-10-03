import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/widgets.dart';
import 'package:food_app/utils/helper.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: Helper.getAssetName(fileName: "login_screen_bg.png")),
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: CircleAvatar(
                            radius: size.width * 0.14,
                            backgroundColor: Colors.grey[400]!.withOpacity(
                              0.4,
                            ),
                            child: Icon(
                              FontAwesomeIcons.user,
                              size: size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          FontAwesomeIcons.arrowUp,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Column(
                  children: [
                    CustomTestInput(
                      icons: FontAwesomeIcons.user,
                      hintText: 'User',
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 20,),
                    CustomTestInput(
                      icons: FontAwesomeIcons.envelope,
                      hintText:'Email',
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 20,),
                    CustomTestInput(
                      icons: FontAwesomeIcons.lock,
                      hintText: 'Password',
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 20,),
                    CustomTestInput(
                      icons: FontAwesomeIcons.lock,
                      hintText: 'Confirm Password',
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Register"),
                        style:
                        ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.indigo),
                            shape: MaterialStateProperty.all(
                              StadiumBorder(),
                            ),
                            elevation: MaterialStateProperty.all(0)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context,LOGIN_ROUTE);
                          },
                          child: Text(
                            'Login',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

