
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/review_list_bloc.dart';
import 'package:food_app/constant/circular_loading.dart';
import 'package:food_app/models/store_model.dart';


class ReviewSection extends StatefulWidget {
  Store? store;
  ReviewSection({Key? key,this.store}) : super(key: key);

  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {

  @override
  void initState() {
    // TODO: implement initState
    widget.store!.reviews!.forEach((element) {
      BlocProvider.of<ReviewBloc>(context).add(EventGetReviewUserById(customerId: element.customerId));
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double ratingStore() {
      double t=0.0;
      if (widget.store!.reviews !=null) {
        widget.store!.reviews!.forEach((element) {
          t+=element.rate!;
        });
        return t/widget.store!.reviews!.length.toDouble();
      } else
        return 0.0;
    }
    return BlocBuilder<ReviewBloc,ReviewState>(
      builder: (context,reviewState) {
        if(reviewState is ReviewUsersState) {
          if (reviewState.users!=null) {
            return Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text("${ratingStore()}",style:
                      TextStyle(
                          fontSize: 18,
                          fontWeight:FontWeight.w700,
                          color: Colors.black
                      ),
                      ),
                    ),
                  ),
                  Center(child: Text("Overall"),),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(ratingStore().floor(), (index) {
                      return Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 30,
                      );
                    }
                    ),
                  ),
                  widget.store!.reviews !=null ?
                  reviewState.users!.length >0 ?
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: reviewState.users!.length,
                      itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              leading: CircleAvatar(
                                child: Icon(Icons.account_circle),
                              ),
                              title:Text("${reviewState.users![index].name}"),
                              subtitle: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(widget.store!.reviews![index].rate!.floor(), (index) {
                                  return Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 12,
                                  );
                                }
                                ),
                              )
                          );

                      },

                    ),
                  ) :
                  Container() :Container()
                ],
              ),
            );
          }else return CircularLoading();
        }else if (reviewState is ReviewLoadingState) {
          return CircularLoading();
        } else return CircularLoading();
      },
    );
  }
}
