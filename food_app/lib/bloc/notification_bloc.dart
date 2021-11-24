

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_app/constant/route_strings.dart';

import 'navigator_bloc.dart';




class NotificationBloc extends Bloc<NotificationEvent,NotificationState>  {
  List<RemoteMessage>? messageList=[] ;
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    if (message.notification !=null) {
      print("you press this notification");
    }
  }

  initialize(BuildContext context) async {
    final NotificationDetails notificationDetails=NotificationDetails(
        android: AndroidNotificationDetails(
          "default_notification_channel_id",
          "fcm_default_channel",
          importance: Importance.max,
          priority: Priority.high,
        )
    );
    final InitializationSettings initializationSettings=
    InitializationSettings(android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification:(payload)  async {
          BlocProvider.of<NavigatorBloc>(context).add(NavigateToRateEvent(storeId: payload));
        },
    );
    final id=1;
    String? token=await FirebaseMessaging.instance.getToken();
    print(token);
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification!=null) {
        await _notificationsPlugin.show(
          id, message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data["store_id"]
        );
        add(NotificationEvent(message: message));
      }
    }


    );
  }
  FlutterLocalNotificationsPlugin  _notificationsPlugin = FlutterLocalNotificationsPlugin();
  NotificationBloc():super(StartUpNotificationState()) {
      on<NotificationEvent> ( (event,emit) async {
        try {
          emit(LoadingNotification());
          await Future.delayed(const Duration(seconds: 2));
          if(!_isItemAlreadyAddedOrder(event.message!.data["store_id"])){
            messageList!.add(event.message!);
          }else  emit(NotificationErrorState());
          emit(ReciveNotification(messageList: messageList));
        }catch(e) {
          emit(NotificationErrorState(error: e.toString()));
        }
      });
      on<DelNotificationEvent> ( (event,emit) async {
        try {
          emit(LoadingNotification());
          await Future.delayed(const Duration(seconds: 2));
          if(_isItemAlreadyAddedOrder(event.storeId)){
            RemoteMessage _remoteMess=messageList!.where((element) => element.data["store_id"]==event.storeId).first;
            messageList!.remove(_remoteMess);
          }else emit(NotificationErrorState());
          emit(ReciveNotification(messageList: messageList));
        }catch(e) {
          emit(NotificationErrorState(error: e.toString()));
        }
      });
  }
  bool _isItemAlreadyAddedOrder(String? storeId) =>
      messageList!.where((element) => element.data["store_id"]==storeId).isNotEmpty;
}




class NotificationEvent {
  //carries the payload sent for notification
  RemoteMessage? message ;
  NotificationEvent({this.message});
}

class DelNotificationEvent extends NotificationEvent {
  String? storeId;
  DelNotificationEvent({this.storeId});
}

class NotificationErrorEvent extends NotificationEvent {
  final String? error;

  NotificationErrorEvent({this.error}) ;
}

class NotificationState extends Equatable {
  NotificationState();

  @override
  List<Object> get props => [];
}

class StartUpNotificationState extends NotificationState {}
class NotificationErrorState extends NotificationState {
  String? error ;
  NotificationErrorState({this.error});
}
class LoadingNotification extends NotificationState {}

class ReciveNotification extends NotificationState {
  List<RemoteMessage>? messageList=[] ;

  ReciveNotification ({this.messageList});

  @override
  List<Object> get props => [this.messageList!];

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => super.hashCode;
}



