


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/shopping_cart_bloc.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/presentation/views/store_views/food_item.dart';
import 'package:intl/intl.dart';


class CardItemWidgets extends StatefulWidget {
  CustomerModel? customerModel;
   CardItemWidgets({Key? key,this.customerModel}) : super(key: key);

  @override
  _CardItemWidgetsState createState() => _CardItemWidgetsState();
}

class _CardItemWidgetsState extends State<CardItemWidgets> {
  final formatCurrency = new NumberFormat();

  @override
  Widget build(BuildContext context) {
    var orderList=BlocProvider.of<CartBloc>(context).cartOrder;
   List<Food> foodList=[];
   orderList.forEach((element) { element.foods!.forEach((f) { foodList.add(f); }); });
   String? getStoreIdByFood(Food food) {
     var storeId=orderList.where((element) => element.foods!.contains(food)).first.storeId;
     return storeId;
   }

    double sumPrice() {
      double t=0;
      orderList.forEach((element)  {
        element.foods!.forEach((foodElement) { t+=foodElement.quantity*foodElement.price!.toDouble(); } );
      });
      return t;
    };
    double totalProduct() {
      double t=0;
      orderList.forEach((element)  {
        t+=element.foods!.length;
      });
      return t;
    };


    return SafeArea(
      child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom:20),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 12,
                  child: Container(
                      color: AppColor.yellow,
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      child: Text('Total Products in cart: ${totalProduct().toInt()}', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                ),
              ),
              Expanded(
                child:
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: totalProduct().toInt(),
                    itemBuilder: (context, idx) {
                      Food _prd = foodList[idx];
                      return Dismissible(
                          key:ObjectKey(_prd),
                          child: FoodItem(food: _prd,storeId: getStoreIdByFood(_prd),)
                      );
                    }
                ),
              ),
              totalProduct()>0
                  ? Card(
                elevation: 12,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Total Price: ${formatCurrency.format(sumPrice())}',
                          style:TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                          textAlign: TextAlign.start,),
                      ),
                      ElevatedButton(onPressed: () {
                        Navigator.pushNamed(context,BILL_ROUTE,arguments: widget.customerModel);
                      }, child:Text("Get Bill"))
                    ],
                  )
                  ),
                ) : Container()
            ],
          )
      ),
    );
  }
}
