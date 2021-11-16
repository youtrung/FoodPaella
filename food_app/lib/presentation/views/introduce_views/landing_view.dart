
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/login_bloc.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/utils/helper.dart';

class LandingView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Container(
          width: Helper.getScreenWidth(context),
          height: Helper.getScreenHeight(context),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ClipPath(
                  // clipper: CustomClipperAppbar(),
                  child: Container(
                    width: double.infinity,
                    height: Helper.getScreenHeight(context)*0.5,
                    decoration: ShapeDecoration(
                        color: AppColor.yellow,
                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(18)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Helper.getAssetName(fileName: "login_screen_bg.png")),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(Colors.black54,BlendMode.softLight)
                          )
                      ),)
                    // Image.asset(Helper.getAssetName(fileName:"login_screen_bg.png"),fit: BoxFit.cover,),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child:
                Image.asset(
                  Helper.getAssetName(fileName: "food_logo.png"),
                  fit: BoxFit.fill,
                )
                ,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: Helper.getScreenHeight(context)*0.32,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      SizedBox(height: 45,),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context).add(Authentication());
                            Navigator.pushNamed(context,LOGIN_ROUTE);
                          },
                          child:Text("LOGIN",textAlign: TextAlign.center,) ,
                        ),
                      ),
                     SizedBox(height: 20,),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            foregroundColor: MaterialStateProperty.all(AppColor.yellow),
                            shape: MaterialStateProperty.all(StadiumBorder(
                              side: BorderSide(color: AppColor.yellow,width: 2.0)
                            ))
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context,REGISTER_ROUTE);
                          },
                          child:Text("CREATE AN ACCOUNT",textAlign: TextAlign.center,) ,
                        ),
                      ),


                    ],
                  ),

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

// class CustomClipperAppbar extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Offset controlPoint = Offset(size.width * 0.24, size.height);
//     Offset endPoint = Offset(size.width * 0.25, size.height * 0.96);
//     Offset controlPoint2 = Offset(size.width * 0.3, size.height * 0.78);
//     Offset endPoint2 = Offset(size.width * 0.5, size.height * 0.78);
//     Offset controlPoint3 = Offset(size.width * 0.7, size.height * 0.78);
//     Offset endPoint3 = Offset(size.width * 0.75, size.height * 0.96);
//     Offset controlPoint4 = Offset(size.width * 0.76, size.height);
//     Offset endPoint4 = Offset(size.width * 0.79, size.height);
//    Path path=Path() //cascade notation
//    ..lineTo(0,size.height)
//    ..lineTo(size.width*0.21,size.height)
//    ..quadraticBezierTo(
//        controlPoint.dx,
//        controlPoint.dy,
//        endPoint.dx,
//        endPoint.dy
//    )..quadraticBezierTo(
//          controlPoint2.dx,
//          controlPoint2.dy,
//          endPoint2.dx,
//          endPoint2.dy
//      )..quadraticBezierTo(
//          controlPoint3.dx,
//          controlPoint3.dy,
//          endPoint3.dx,
//          endPoint3.dy
//      )..quadraticBezierTo(
//          controlPoint4.dx,
//          controlPoint4.dy,
//          endPoint4.dx,
//          endPoint4.dy
//      )..lineTo(size.width,size.height)
//    ..lineTo(size.width,0)
//    ;
//    return path;
//
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     // TODO: implement shouldReclip
//     return true;
//   }
// }
