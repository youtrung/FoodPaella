import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class NotificationSection extends StatefulWidget {
  const NotificationSection({Key? key}) : super(key: key);

  @override
  _NotificationSectionState createState() => _NotificationSectionState();
}

class _NotificationSectionState extends State<NotificationSection> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();

    //foreground work
    FirebaseMessaging.onMessage.listen((message) {
        print(message.notification!.body);
        print(message.notification!.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Hi"),);
  }
}
