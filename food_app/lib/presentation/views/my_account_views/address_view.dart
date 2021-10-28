import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/user_bloc.dart';
import 'package:food_app/constant/circular_loading.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/models/customer_model.dart';

class AddressView extends StatefulWidget {
  CustomerModel? customerModel;
  AddressView({Key? key,this.customerModel}) : super(key: key);

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.yellow,
        title: Text("Address"),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                  onTap: () => context.read<UserBloc>().add(UserChangedEvent(customerModel:widget.customerModel)),
                  child: Text("UPDATE",style: TextStyle(color: Colors.blue,fontSize: 16),)
              ),
            ),
          )
        ],
      ),
      body:   BlocBuilder<UserBloc,UserState>(
        builder: (context,userState) => userState is UserLoadingState ? CircularLoading():
            Form(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  onChanged: (value)  {
                    setState(() {
                      widget.customerModel!.address!.district=value;
                    });
                  } ,
                  initialValue: widget.customerModel == null ? null:widget.customerModel!.address!.district,
                  decoration: InputDecoration(
                    labelText: "District",
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      widget.customerModel!.address!.ward=value;
                    });
                  },
                  initialValue: widget.customerModel == null ? null:widget.customerModel!.address!.ward,
                  decoration: InputDecoration(
                    labelText: "Ward",
                  ),
                ),
                TextFormField(
                  onChanged: (value)  {
                    setState(() {
                      widget.customerModel!.address!.city=value;
                    });
                  },
                  initialValue: widget.customerModel == null ? "":widget.customerModel!.address!.city,
                  decoration: InputDecoration(
                    labelText: "City",
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      widget.customerModel!.address!.street=value;
                    });
                  },
                  initialValue: widget.customerModel == null ? "":widget.customerModel!.address!.street,
                  decoration: InputDecoration(
                    labelText: "Street",
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}
