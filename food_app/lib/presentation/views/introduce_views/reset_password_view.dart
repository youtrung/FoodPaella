import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/bloc/user_bloc.dart';
import 'package:food_app/constant/widgets.dart';
import 'package:food_app/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordView extends StatelessWidget {
  String email;
  ResetPasswordView({required this.email});


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController _passwordController =TextEditingController();
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) => LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [Colors.black, Colors.transparent],
          ).createShader(rect),
          blendMode: BlendMode.darken,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Helper.getAssetName(fileName: "login_screen_bg.png")),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.softLight),
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
              ),
            ),
            title: Text(
              'Forgot Password',
            ),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 30),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height*0.05,
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Text(
                          'Enter your new password we will up to date your password',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTestInput(
                        hintText: "Your password",
                        icons: FontAwesomeIcons.envelope,
                        textEditingController: _passwordController,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            context.read<UserBloc>().add(ResetPasswordEvent(email: this.email,password: _passwordController.text));
                            Navigator.of(context).pushReplacementNamed(LANDING_ROUTE);
                          },
                          child: Text("Update password"),
                          style:ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.indigo),
                              shape: MaterialStateProperty.all(
                                StadiumBorder(),
                              ),
                              elevation: MaterialStateProperty.all(0)
                          )
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}