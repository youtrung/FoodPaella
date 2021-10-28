

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/bloc/login_bloc.dart';
import 'package:food_app/constant/widgets.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/utils/helper.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  CustomerModel customerModel = CustomerModel.initial();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  TextEditingController errorEmailController =TextEditingController();
  TextEditingController errorPassController =TextEditingController();
  final _formkey = GlobalKey<FormState>();
  FocusNode emailFocus=new FocusNode();
  FocusNode passFocus=new FocusNode();
  SnackBar mySnackBar=SnackBar(content: Text("Login Error"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
      ),
      body: BlocProvider(
        create: (context)=>LoginBloc()..add(Authentication()),
        child: BlocListener<LoginBloc,LoginState>(
          listener: (context,state) {
            final formStatus=state.formStatus;
            if (formStatus is FormSubmitting) {
              Fluttertoast.cancel();
            }
            if (formStatus is SubmissionSuccess) {
              Fluttertoast.showToast(
                msg:"Login success",
                fontSize: 18,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white,
              );
              Navigator.of(context).pushReplacementNamed(HOME_ROUTE,arguments:formStatus.customerModel);
              Fluttertoast.cancel();
            }else if (formStatus is SubmissionFailed) {
                ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
            }
          },
          child: BlocBuilder<LoginBloc,LoginState>(
            builder: (context,state)=>
            state.formStatus is FormSubmitting ?
            CircularLoading():
            state.formStatus is SubmissionFailed ||  state.formStatus is InitialFormStatus ?
            Form(
              key: _formkey,
              child: Container(
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
                                            fontFamily: "Pacifico",
                                            color: Colors.white,
                                            fontSize: 60,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                                ),
                                TextField(
                                  style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize:16),
                                  controller: errorEmailController,
                                  textAlign: TextAlign.center,
                                  enabled: false,
                                  decoration: InputDecoration(
                                  border: InputBorder.none
                                ),),
                                CustomTestInput(
                                  hintText: "Your Email",
                                  onChanged: (value) => context.read<LoginBloc>().add(
                                    EmailChanged(email: value),
                                  ),
                                  focusNode: emailFocus,
                                  textEditingController: _emailController,
                                  icons: FontAwesomeIcons.envelope,
                                  textInputType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                ),
                                TextField(
                                  style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize:16),
                                  controller:errorPassController,
                                  textAlign: TextAlign.center,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      border: InputBorder.none
                                  ),),
                                CustomTestInput(
                                  hintText: "Your Password",
                                  onChanged: (value) => context.read<LoginBloc>().add(
                                    PasswordChanged(password: value),
                                  ),
                                  focusNode: passFocus,
                                  textEditingController: _passwordController,
                                  icons:FontAwesomeIcons.lock,
                                  textInputType: TextInputType.name,
                                  textInputAction: TextInputAction.done,
                                  obscureText: true,
                                ),
                                SizedBox(height:8),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, FORGOT_PASSWORD_ROUTE);
                                  },
                                  child: Text("Forgot password ?",
                                    style: TextStyle(
                                      backgroundColor: AppColor.yellow,
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (state.isValidEmail) {
                                        errorEmailController.text="";
                                        if(state.isValidPass)
                                          {
                                            context.read<LoginBloc>().add(LoginSubmitted(
                                                customerModel:customerModel.copyWith(email:_emailController.text,password:_passwordController.text)
                                            )
                                            );
                                          }else {
                                          errorPassController.text="Password is required!";
                                        }
                                      }else {
                                        errorPassController.text="";
                                        errorEmailController.text="Email is invalid !";
                                        FocusScope.of(context).requestFocus(emailFocus);
                                      }
                                    },
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
            ):CircularLoading(),
          ),
        ),
      ),
    );
  }
}

