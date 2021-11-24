import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/favorite_list_bloc.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/constant/rating_bar_widget.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/store_model.dart';
import 'dart:ui' as ui;

class buildStoreItem extends StatefulWidget {
  Store store;
  buildStoreItem({Key? key,required this.store}): super(key: key);

  @override
  State<buildStoreItem> createState() => _buildStoreItemState();
}

class _buildStoreItemState extends State<buildStoreItem> {

  double ratingStore() {
    double t=0.0;
    if ( widget.store.reviews !=null && widget.store.reviews!.length >0 ) {
      widget.store.reviews!.forEach((element) {
        t+=element.rate!;
      });
      return t/widget.store.reviews!.length.toDouble();
    } else
      return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // LikeArguments likeArguments=LikeArguments(store: widget.store,customerModel: widget.customerModel);
          Navigator.pushNamed(context, STORE_ROUTE,arguments:widget.store).then((_) {
            try {
              BlocProvider.of<FavoriteBloc>(context).add(GetFavoriteStores());
              // neu tu trang store-> main se bao loi no blocProvider
            } catch(e) {

            }
          }
          );
      },
      child:Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [Colors.orangeAccent,Colors.yellow],
                    begin: Alignment.topLeft,
                    end:Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.yellow,
                      blurRadius: 12,
                      offset: Offset(0,6),
                    )
                  ]
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: CustomPaint(
                size: Size(100,150),
                painter:CustomCardShapePainter(radius: 24,startColor: Colors.pink,endColor:AppColor.yellow) ,
              ),
            ),
            Positioned.fill(
              child: Row(
                children: [
                  Expanded(
                    child: Image.network(widget.store.image ?? "",height: 64,width: 64,),
                    flex: 2,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Text(
                            "${widget.store.name}",
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(height: 16,),
                        Row(
                            children :
                            [
                              Icon(Icons.location_on,color: Colors.white,size: 16,),
                              SizedBox(width: 8,),
                              Flexible(
                                child: Text(
                                  "${widget.store.contact!.address!.street},"
                                      "${widget.store.contact!.address!.ward},"
                                      "${widget.store.contact!.address!.district},"
                                      "${widget.store.contact!.address!.city}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ]
                        )
                      ],
                    ),
                  ),
                  ratingStore() >0.0 ?
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${ratingStore().toStringAsFixed(1)}",
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),
                        ),
                        RatingBar(rating:ratingStore(),),
                      ],
                    ),
                  ): Expanded(
                    flex: 2,
                    child:Container()
                  )
                ],
              ),
            )
          ],
        ),
      )
      // Container(
      //   margin:EdgeInsetsDirectional.fromSTEB(20,0, 20, 40),
      //   child:AspectRatio(
      //     aspectRatio: 3/1,
      //     child:Container(
      //       child:Row(
      //         children: [
      //           AspectRatio(
      //             aspectRatio:1/1,
      //             child: ClipRRect(
      //               borderRadius:BorderRadius.circular(10),
      //               child: Image.network(widget.store.image ?? "" ,
      //                 fit: BoxFit.cover,
      //               ),
      //             ),
      //           ),
      //           SizedBox(width: 20,),
      //           AspectRatio(
      //             aspectRatio: 4/3,
      //             child:
      //             Column(
      //               mainAxisAlignment:MainAxisAlignment.start,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children:[
      //                 Text("${widget.store.name}",
      //                   style: TextStyle(
      //                       fontSize: 18,
      //                       fontWeight: FontWeight.bold
      //                   ),
      //                 ),
      //             ],
      //             ),
      //           ),
      //        ]
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}



class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;
  CustomCardShapePainter({required this.radius,required this.startColor,required this.endColor});

  @override
  void paint(Canvas canvas, Size size) {
    var radius=24.0;
    var paint=Paint();
    paint.shader=ui.Gradient.linear(
        Offset(0,0),Offset(size.width,size.height),[
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);
    var path=Path()
      ..moveTo(0,size.height)
      ..lineTo(size.width - radius,size.height)
      ..quadraticBezierTo(
          size.width,size.height ,size.width, size.height-radius)
      ..lineTo(size.width,radius)
      ..quadraticBezierTo(size.width, 0, size.width-radius, 0)
      ..lineTo(size.width-1.5*radius, 0)
      ..quadraticBezierTo(-radius,2*radius, 0,size.height)
      ..close();
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}