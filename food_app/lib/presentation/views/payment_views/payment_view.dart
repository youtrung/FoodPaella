

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/login_bloc.dart';
import 'package:food_app/bloc/payment_bloc.dart';
import 'package:food_app/bloc/shopping_cart_bloc.dart';
import 'package:food_app/constant/circular_loading.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/utils/helper.dart';
import 'package:intl/intl.dart';


class PaymentView extends StatefulWidget {
   PaymentView({Key? key}) : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late TextEditingController addressController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressController=new TextEditingController(
        text:"Your Coupon here");
  }

  @override
  Widget build(BuildContext context) {
    final _formKey=GlobalKey<FormState>();
    final formatCurrency = new NumberFormat();
    var cartOrder=BlocProvider.of<CartBloc>(context).cartOrder;
    CustomerModel? customer=BlocProvider.of<LoginBloc>(context).customerModel;
    List<Food> foodList=[];
    cartOrder.forEach((element) { element.foods!.forEach((f) { foodList.add(f); }); });
    double sumPriceAllOrder() {
      double t=0;
      cartOrder.forEach((element)  {
        element.foods!.forEach((foodElement) { t+=foodElement.quantity*foodElement.price!.toDouble(); } );
      });
      return t;
    };

    return BlocProvider<PaymentBloc>(
      create: (_)=>PaymentBloc(),
      child: BlocConsumer<PaymentBloc,PaymentState>(
        listener: (context,payState) {
              if (payState is PaymentSuccessState) {


              }
              if(payState is PaymentFailedState) {
                print(payState.error);
              }
        },
        builder: (context,payState)
         => payState is PaymentState ?
            Scaffold(
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
                            if (_formKey.currentState!.validate()) {
                              cartOrder.forEach((element) {
                                double t =0;
                                element.foods!.forEach((f) { t+=(f.quantity* f.price!.toDouble()) ; });
                                element.totalMoney=t;
                                BlocProvider.of<PaymentBloc>(context).add(PaymentEvent(order: element));
                                AwesomeDialog(
                                        context: context,
                                        animType: AnimType.LEFTSLIDE,
                                        headerAnimationLoop: false,
                                        dialogType: DialogType.SUCCES,
                                        showCloseIcon: true,
                                        title: 'You Place the Order Successfully',
                                        desc:
                                        'You placed the order successfully.You will get your food within 26 minutes. Thanks for using our service.Enjoy your food :)',
                                        btnOkOnPress: () {
                                          Navigator.of(context).maybePop();
                                          BlocProvider.of<CartBloc>(context).add(ClearCart());
                                        },
                                        btnOkIcon: Icons.check_circle,
                                        onDissmissCallback: (type) {
                                        debugPrint('Dialog Dissmiss from callback $type');
                                        })..show();
                              });
                            }
                          },
                          child: Text("ORDER NOW",style:TextStyle(
                              color:Colors.white,
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
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    title: Text("Bill details"),
                    backgroundColor: AppColor.yellow,
                    centerTitle: true,
                  )
                ];
              },
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding:const EdgeInsets.all(4.0) ,
                        child:SizedBox(
                          width: Helper.getScreenWidth(context),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bill details",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                                  ListView(
                                    shrinkWrap: true,
                                    children: foodList.map((e) => Row(
                                      children: [
                                        Expanded(child: Text("${e.quantity}x ${e.name}",style: TextStyle(fontSize: 16),)),
                                        Text("${formatCurrency.format(e.price)} VND",style: TextStyle(fontSize: 16))
                                      ], )).toList(),
                                  ),
                                  Divider(color: Colors.grey,),
                                  Row(
                                    children: [
                                      Expanded(child: Text("Total amount payable :",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),)),
                                      Text("${formatCurrency.format(sumPriceAllOrder())} VND",style: TextStyle(fontSize: 16))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding:const EdgeInsets.all(4.0),
                        child:SizedBox(
                          width: Helper.getScreenWidth(context),
                          child: Card(
                            shadowColor: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("User details :",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Expanded(child: Text("Name:",style: TextStyle(fontSize: 16),)),
                                      Text("${customer!.name}",style: TextStyle(fontSize: 16))
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Expanded(child: Text("Phone:",style: TextStyle(fontSize: 16),)),
                                      Text("${customer.phone}",style: TextStyle(fontSize: 16))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color:Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10,right: 10,left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Delivery to :",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text("Đường ${customer.address!.street},phường:${customer.address!.ward},"
                                        "quận: ${customer.address!.district}, thành phố : ${customer.address!.city} ",
                                      softWrap: true,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  OutlinedButton(onPressed: () {
                                    Navigator.pushNamed(context,ADDRESS_ROUTE,arguments:customer).then((_){
                                      setState(() {

                                      });
                                    });
                                  }, child:Text("EDIT"))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 38,
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Colors.grey[300],
                                      hintText: "Your coupon here"
                                  ),
                                ),
                              ),
                            ),
                            OutlinedButton(onPressed: (){}, child:Text("Apply"))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ),
          ) : payState is PaymentSuccessState? CircularLoading()
             :CircularLoading()
      ),
    );
  }
}


