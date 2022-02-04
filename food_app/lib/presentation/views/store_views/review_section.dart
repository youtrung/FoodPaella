
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/bloc/login_bloc.dart';
import 'package:food_app/bloc/review_list_bloc.dart';
import 'package:food_app/bloc/review_list_bloc_v2.dart';
import 'package:food_app/constant/circular_loading.dart';
import 'package:food_app/models/customer_model.dart';

import 'package:food_app/models/rate_model.dart';
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

    super.initState();
    BlocProvider.of<CommentBloc>(context).users=[];
   widget.store!.reviews!.forEach((element) {
      BlocProvider.of<CommentBloc>(context).add(EventGetCommentUserById(storeId: widget.store!.id,customerId: element.customerId,rate: element.rate));
    });
  }

  @override
  Widget build(BuildContext context) {
    double ratingStore(List<RateModel>? rateList) {
      double t=0.0;
      if (rateList !=null && rateList.length>0) {
        rateList.forEach((element) {
          t+=element.rate!;
        });
        return t/rateList.length.toDouble();
      } else
        return 0.0;
    }
    return BlocBuilder<ReviewBloc,ReviewState>(
      builder: (context,reviewState) {
        if(reviewState is ReviewUsersState) {
          if (reviewState.reviews!=null && widget.store!.reviews!.length>0) {
            return Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text("${ratingStore(reviewState.reviews).toStringAsFixed(1)}",style:
                      TextStyle(
                          fontSize: 18,
                          fontWeight:FontWeight.w700,
                          color: Colors.black
                      ),
                      ),
                    ),
                  ),
                  Center(child: Text("Overall"),),
                  Center(
                    child: RatingBarIndicator(
                      rating: ratingStore(reviewState.reviews),
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 30.0,
                    ),
                  ),
                  Flexible(child: ListCommentWidget(storeId: widget.store!.id,reviews: reviewState.reviews,length: widget.store!.reviews!.length,))
                ],
              ),
            );
          }else return Container();
        }else if (reviewState is ReviewLoadingState) {
          return CircularLoading();
        } else return Container();
      },
    );
  }
}

class ListCommentWidget extends StatefulWidget {
  List<RateModel>? reviews;
  String? storeId;
  int? length;
  ListCommentWidget({Key? key,required this.reviews,this.storeId,this.length}) : super(key: key);

  @override
  _ListCommentWidgetState createState() => _ListCommentWidgetState();
}

class _ListCommentWidgetState extends State<ListCommentWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<CommentBloc,CommentState>(
        builder: (context,commentState) {
      if(commentState is CommentUsersState) {
        if(commentState.users !=null) {
          return  ListView.builder(
            shrinkWrap: true,
            itemCount:widget.length,
            itemBuilder: (BuildContext context, int index) {
              List<Widget> t =[];
              for (int i=0;i<commentState.users!.length;i++) {
                if(widget.storeId == commentState.users![i].storeId){
                  t.add(ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.account_circle),
                    ),
                    title: Text("${commentState.users![i].customerModel!.name}"),
                    subtitle: RatingBarIndicator(
                      rating: commentState.users![i].rate!,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amberAccent,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                    ),
                  ));
                }
              }
              return t[index];
            },
          );
        } else return Container();
      }else if (commentState is CommentLoadingState) {
        return CircularLoading();
      } else return Container();
    }
    );
  }
}

