import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/utils/helper.dart';

class buildStoreItem extends StatelessWidget {
  Store store;
  buildStoreItem({required this.store});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
          Navigator.pushNamed(context, STORE_ROUTE,arguments: store);
      },
      child: Container(
        margin:EdgeInsetsDirectional.fromSTEB(20,0, 20, 40),
        child:AspectRatio(
          aspectRatio: 3/1,
          child:Container(
            child:Row(
              children: [
                AspectRatio(
                  aspectRatio:1/1,
                  child: ClipRRect(
                    borderRadius:BorderRadius.circular(10),
                    child: Image.asset(Helper.getAssetName(fileName:store.imageStore ?? "" ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                AspectRatio(
                  aspectRatio: 4/3,
                  child:
                  Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text("${store.nameStore}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                  ],
                  ),
                ),
             ]
            ),
          ),
        ),
      ),
    );
  }
}