import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/store_model.dart';

class InfoSection extends StatelessWidget {
  Store? store;
  InfoSection({Key? key,this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.add_location_alt,color: Colors.black,),
            title: Text("${store!.contact!.address!.street},${store!.contact!.address!.ward},${store!.contact!.address!.district}",
              style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
          ),
          ListTile(
            leading: Icon(Icons.phone,color: Colors.black,),
            title: Text("${store!.contact!.phone}",
              style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
          ),
          store!.contact!.address!.activity !=null ?
          store!.contact!.address!.activity!.length >0?
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: store!.contact!.address!.activity!.length,
              itemBuilder: (context,index) {
                return Row(children: [
                  Text("Activity:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18.0)),
                  Expanded(child: Text("${store!.contact!.address!.activity![index].day}",style: TextStyle(fontSize: 18,color: Colors.black),) ),
                  Text("${store!.contact!.address!.activity![index].open}- ${store!.contact!.address!.activity![index].close}",
                    style:TextStyle(fontSize: 18,color: Colors.black),)
                ],);
              }
          ),
          ) :Container():Container()

        ],
      ),
    );
  }
}
