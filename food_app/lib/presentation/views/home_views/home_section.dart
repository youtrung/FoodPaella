import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/presentation/views/home_views/tab_home_view_widgets.dart';
import 'package:food_app/utils/helper.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Helper.getScreenHeight(context),
      padding: EdgeInsets.all(10),
      child: TabHomeView(),
    );
  }
}

// Widget buildSearch(BuildContext context) {
//   return Container(
//     height: 40,
//     width: Helper.getScreenWidth(context),
//     child: ElevatedButton.icon(
//       style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all(Colors.white),
//           shape: MaterialStateProperty.all(StadiumBorder(
//               side: BorderSide(color: AppColor.yellow,width: 2.0)
//           ))
//       ),
//       icon:Icon(Icons.search,color: Colors.black,),
//       onPressed: () {  },
//       label: Text("Search for food",style: TextStyle(color: Colors.black,fontSize: 20),),
//     ),
//   );
// }


