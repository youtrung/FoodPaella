import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/bloc/register_bloc.dart';
import 'package:food_app/constant/widgets.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/utils/helper.dart';


class RegisterView extends StatefulWidget {
   RegisterView() ;

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final CustomerModel customerModel = CustomerModel.initial();
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  final TextEditingController _phoneController =TextEditingController();
  final _formkey = GlobalKey<FormState>();
  SnackBar mySnackBar=SnackBar(content: Text("This email already exists"));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: BlocProvider(
            create: (context)=>RegisterBloc(),
            child: BlocListener<RegisterBloc,RegisterState>(
              listener: (context,state) {
                final formStatus=state.formStatus;
                if (formStatus is SubmissionSuccess) {
                  Navigator.of(context).pushReplacementNamed(LANDING_ROUTE);
                }else if (formStatus is SubmissionFailed) {
                  print("error:"+formStatus.exception.toString());
                  ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
                }
              },
              child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: BlocBuilder<RegisterBloc,RegisterState>(
                    builder: (context,state)=>
                    state.formStatus is FormSubmitting ?
                    CircularLoading():
                    state.formStatus is SubmissionFailed ?
                    Column(
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
                              textEditingController: _nameController,
                              validator: (value)  {
                                if (value !=null) {
                                 return value.length >0 ? null:"user is required";
                                }else {
                                  value="";
                                  return value.length >0 ? null:"user is required";
                                }
                              },
                              hintText: 'User',
                              textInputType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 20,),
                            CustomTestInput(
                              icons: FontAwesomeIcons.envelope,
                              hintText:'Email',
                              onChanged: (value) => context.read<RegisterBloc>().add(
                                EmailChanged(email: value),
                              ),
                              validator: (value)=>state.isValidEmail ? null:"email is not valid",
                              textEditingController: _emailController,
                              textInputType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 20,),
                            CustomTestInput(
                              icons: FontAwesomeIcons.phone,
                              hintText: 'Phone number',
                              textEditingController: _phoneController,
                              validator: (value)=> value!.length !=10 ? "phone number is invalid":null,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 20,),
                            CustomTestInput(
                              icons: FontAwesomeIcons.lock,
                              hintText: 'Password',
                              onChanged: (value) => context.read<RegisterBloc>().add(
                                PasswordChanged(password: value),
                              ),
                              textEditingController: _passwordController,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              height: 50,
                              width: Helper.getScreenWidth(context)*0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  if(_formkey.currentState!.validate()) {
                                    context.read<RegisterBloc>().add(RegisterSubmitted(
                                        customerModel:customerModel.copyWith(
                                            name: _nameController.text,
                                            email:_emailController.text,
                                            password:_passwordController.text,
                                            phone: _phoneController.text
                                        )
                                    )
                                    );
                                  }
                                },
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context,LOGIN_ROUTE);
                                  },
                                  child: Text(
                                    'Already have an account?Login',
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
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
                    ):Column(
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
                              textEditingController: _nameController,
                              validator: (value)  {
                                if (value !=null) {
                                  return value.length >0 ? null:"user is required";
                                }else {
                                  value="";
                                  return value.length >0 ? null:"user is required";
                                }
                              },
                              hintText: 'User',
                              textInputType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 20,),
                            CustomTestInput(
                              icons: FontAwesomeIcons.envelope,
                              hintText:'Email',
                              onChanged: (value) => context.read<RegisterBloc>().add(
                                EmailChanged(email: value),
                              ),
                              validator: (value)=>state.isValidEmail ? null:"email is not valid",
                              textEditingController: _emailController,
                              textInputType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 20,),
                            CustomTestInput(
                              icons: FontAwesomeIcons.phone,
                              hintText: 'Phone number',
                              textEditingController: _phoneController,
                              validator: (value)=> value!.length !=10 ? "phone number is invalid":null,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 20,),
                            CustomTestInput(
                              icons: FontAwesomeIcons.lock,
                              hintText: 'Password',
                              onChanged: (value) => context.read<RegisterBloc>().add(
                                PasswordChanged(password: value),
                              ),
                              textEditingController: _passwordController,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              height: 50,
                              width: Helper.getScreenWidth(context)*0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  if(_formkey.currentState!.validate()) {
                                    context.read<RegisterBloc>().add(RegisterSubmitted(
                                        customerModel:customerModel.copyWith(
                                            name: _nameController.text,
                                            email:_emailController.text,
                                            password:_passwordController.text,
                                            phone: _phoneController.text
                                        )
                                    )
                                    );
                                  }
                                },
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context,LOGIN_ROUTE);
                                  },
                                  child: Text(
                                    'Already have an account?Login',
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
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
                    )
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

