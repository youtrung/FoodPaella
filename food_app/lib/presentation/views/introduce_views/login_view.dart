import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/widgets.dart';
import 'package:food_app/utils/helper.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
      ),
      body: Container(
        height: Helper.getScreenHeight(context),
        width: Helper.getScreenWidth(context),
        child:Stack(
          children: [
            ShaderMask(
                shaderCallback:(rect)=> LinearGradient(
                  begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors:[Colors.black,Colors.transparent],
                ).createShader(rect),
              blendMode: BlendMode.softLight,
              child:
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Helper.getAssetName(fileName: "login_screen_bg.png")),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black54,BlendMode.softLight)
                  )
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                        child:Center (
                          child: Text(
                            "Paella",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                    ),
                    CustomTestInput(
                      hintText: "Your Email",
                      icons: FontAwesomeIcons.envelope,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 20,),
                    CustomTestInput(
                      hintText: "Your Password",
                      icons:FontAwesomeIcons.lock,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                    ),
                    SizedBox(height:20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, FORGOT_PASSWORD_ROUTE);
                      },
                      child: Text("Forgot Password ?",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Courgette",
                            fontSize: 20,
                          decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Login"),
                        style:
                        ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.indigo),
                            shape: MaterialStateProperty.all(
                              StadiumBorder(),
                            ),
                            elevation: MaterialStateProperty.all(0)
                        ),
                      ),
                    )

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

