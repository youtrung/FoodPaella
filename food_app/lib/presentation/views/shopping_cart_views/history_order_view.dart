import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/login_bloc.dart';
import 'package:food_app/bloc/payment_bloc.dart';
import 'package:food_app/constant/circular_loading.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/utils/helper.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class HistoryView extends StatefulWidget {
  HistoryView({Key? key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {

  DateTimeRange? dateTimeRange;
  String getFrom() {
    if(dateTimeRange==null)
      return "FROM";
    else return DateFormat("dd/MM/yyyy").format(dateTimeRange!.start);
  }
  String getUntil() {
    if(dateTimeRange==null)
      return "UNTIL";
    else return DateFormat("dd/MM/yyyy").format(dateTimeRange!.end);
  }
  @override
  Widget build(BuildContext context) {
    CustomerModel? customer=BlocProvider.of<LoginBloc>(context).customerModel;
    final formatCurrency = new NumberFormat();
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Date Range :",style: TextStyle(color: Colors.black,fontSize: 20),),
          Row(
            children: [
              Expanded(child: OutlinedButton(child:Text(getFrom()),onPressed: () {
                pickDateRange(context);
              },)
              ),
              SizedBox(width: 8,),
              Icon(Icons.arrow_forward),
              SizedBox(width: 8,),
              Expanded(child: OutlinedButton(child:Text(getUntil()),onPressed: () {
                pickDateRange(context);
              },)
              )
            ],
          ),
          dateTimeRange !=null ?
              OutlinedButton(onPressed: () {
                BlocProvider.of<PaymentBloc>(context).add(GetPaymentDayToDay(userId: customer!.id,startDate: dateTimeRange!.start,endDate: dateTimeRange!.end));
              }, child:Text("Filter")):Container(),
          BlocBuilder<PaymentBloc,PaymentState>(
            builder: (BuildContext context,payState) {
              if (payState is PaymentLoadingState) {
                  return CircularLoading();
              }else if (payState is PaymentState) {
                List<OrderModel> cartOrder=BlocProvider.of<PaymentBloc>(context).orders;
                List<Food> foodList=BlocProvider.of<PaymentBloc>(context).foodList;
                if (cartOrder !=null && cartOrder.length >0) {
                  return  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount:cartOrder.length,
                      padding: EdgeInsets.only(top: 10),
                      itemBuilder: (BuildContext context, int index) {
                        if(cartOrder[index].status=="Đã giao") {
                          return ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cartOrder[index].foods!.length,
                              itemBuilder: (BuildContext context, int foodIdx) {
                                if (foodList.length > 0) {
                                  Food food = foodList
                                      .where((element) =>
                                  element.id ==
                                      cartOrder[index].foods![foodIdx].id)
                                      .single;
                                  return
                                    Card(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child:
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            Expanded(
                                              child:
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text("${food.name}"),
                                                  Text(
                                                      "Quantity: ${cartOrder[index]
                                                          .foods![foodIdx]
                                                          .quantity}"),
                                                  Text("Price:${formatCurrency.format( cartOrder[index]
                                                      .foods![foodIdx].price)} VND"),
                                                  Text("Date: ${DateFormat(
                                                      "dd-MM-yyyy").format(
                                                      cartOrder[index].createdAt!)}")
                                                ],
                                              ),
                                            ),
                                            Text("${cartOrder[index].status}")
                                          ],
                                        ),
                                      ),
                                    );
                                } else {
                                  return Container();
                                }
                              }
                          );
                        }else {
                          return Container();
                        }
                      },
                    ),
                  );
                }else return Container();
              }else return Container();
            },
          )
        ],
      ),
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange=DateTimeRange(
        start: DateTime.now(),end: DateTime.now().add(Duration(days: 3)),
    );
    final newDateRange=await showDateRangePicker(context: context,
        firstDate: DateTime(DateTime.now().year-5),
        lastDate: DateTime(DateTime.now().year+5),
      initialDateRange: dateTimeRange ?? initialDateRange,

    );
    if (newDateRange ==null) return;
    setState(() => dateTimeRange=newDateRange);
  }
}
