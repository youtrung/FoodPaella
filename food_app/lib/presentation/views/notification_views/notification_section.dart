import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/notification_bloc.dart';
import 'package:food_app/constant/circular_loading.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/services/cloud_message_services.dart';
import 'package:intl/intl.dart';

class NotificationSection extends StatefulWidget {
  const NotificationSection({Key? key}) : super(key: key);

  @override
  _NotificationSectionState createState() => _NotificationSectionState();
}

class _NotificationSectionState extends State<NotificationSection> {

  @override
  void initState() {
    // TODO: implement initState
    // FirebaseMessaging.instance
    //     .getInitialMessage();
   //
   //
   //  //when the app is in background but opened and user taps
   //  // on notification
   //  FirebaseMessaging.onMessageOpenedApp.listen((message) {
   //      // final routeFromMessage=message.data["route"];
   //  });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context,state) {
        if (state is ReciveNotification) {
          print("thong bao khoi dong");
          if(state.messageList!.length > 0) {
            print("thong bao ${state.messageList}");
            return ListView.builder(
              itemCount:state.messageList!.length,
              itemBuilder: (BuildContext context, int index) {
                RemoteMessage _remoteMessage =state.messageList![index];
                return Dismissible(
                  key:ObjectKey(_remoteMessage),
                  child: Card(
                    child: ListTile(
                      onTap:() {
                        Navigator.pushNamed(context,RATE_ROUTE,arguments: _remoteMessage.data["store_id"]);
                      } ,
                      title: Text("Announcement !",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      subtitle: Text("your order has arrived - ${DateFormat("dd/MM/yyyy").format(DateTime.now())}"),
                      trailing: IconButton( onPressed: () {
                        BlocProvider.of<NotificationBloc>(context).add(DelNotificationEvent(storeId:_remoteMessage.data["store_id"]));
                      }, icon:Icon(Icons.cancel)),
                    ),
                  ),
                );
              },
            );
          }else
            return Container(child: Center(child: Text("There are currently no announcements",style: TextStyle(fontSize: 22),)),);
        }else if (state is LoadingNotification) {
          return CircularLoading();
        }else {
          print("ket thuc ");
          return Container(child: Center(child: Text("There are currently no announcements",style: TextStyle(fontSize: 22))),);
        }

      },
    );
  }
}
