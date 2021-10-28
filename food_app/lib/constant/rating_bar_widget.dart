import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final double rating;
   RatingBar({Key? key,required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(rating.floor(), (index) {
      return Icon(
        Icons.star,
        color: Colors.white,
        size: 16,
      );
      }),
    );
  }
}
