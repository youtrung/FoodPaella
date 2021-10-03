import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/presentation/views/store_views/food_item.dart';
import 'package:grouped_list/grouped_list.dart';

class GroupFood extends StatelessWidget {
  List<Food> foods;
  GroupFood({Key? key,required this.foods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupedListView<Food,String>(
        elements: foods,
        groupBy:(Food element)=>element.category ?? "",
        groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      itemBuilder: (c, element) {
        return FoodItem(food: element);
      },

    );
  }
}
