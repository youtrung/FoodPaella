import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/bloc/login_bloc.dart';
import 'package:food_app/bloc/notification_bloc.dart';
import 'package:food_app/bloc/review_list_bloc.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/customer_model.dart';

class RateView extends StatelessWidget {
  String? storeId;
  RateView({Key? key,this.storeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomerModel? customer=BlocProvider.of<LoginBloc>(context).customerModel;
    double? _rate=1.0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate View"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(child: Text("Rate this store",style: TextStyle(fontSize:25,color: Colors.black),),),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration.collapsed(hintText: "Enter your comment"),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(8.0) ,
                  child:Text(
                    "Please leave a rating !",
                    style:TextStyle(
                        fontSize: 16,
                        fontWeight:
                        FontWeight.bold
                    ),
                  )
              ),
              Center(
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _rate=rating;
                    print(_rate);
                  },
                )
              ),
            ],),
        ),
      ),
      bottomSheet: Container(
        height: 60,
        child:Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<ReviewBloc>(context).add(EventSendReview(storeId: storeId,customerId: customer!.id,rate:_rate));
                          AwesomeDialog(
                              context: context,
                              animType: AnimType.LEFTSLIDE,
                              headerAnimationLoop: false,
                              dialogType: DialogType.SUCCES,
                              showCloseIcon: true,
                              title: 'Thank you for leaving your comment',
                              desc:
                              '',
                              btnOkOnPress: () {
                                BlocProvider.of<NotificationBloc>(context).add(DelNotificationEvent(storeId:storeId));
                                Navigator.of(context).pushReplacementNamed(HOME_ROUTE);
                              },
                              btnOkIcon: Icons.check_circle,
                              onDissmissCallback: (type) {
                                if (type==DismissType.TOP_ICON){
                                  BlocProvider.of<NotificationBloc>(context).add(DelNotificationEvent(storeId:storeId));
                                  Navigator.of(context).pushReplacementNamed(HOME_ROUTE);
                                };
                                debugPrint('Dialog Dissmiss from callback $type');
                              })..show();
                    },
                    child: Text("REVIEW",style:TextStyle(
                        color:Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
