import 'package:bussiness_management/Pages/mainPage/comp/bottom_nav_item.dart';
import 'package:bussiness_management/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
      child: BottomAppBar(
        
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(label: "Home", iconData: Icons.home_filled, index: 0,),
            BottomNavItem(label: "Order", iconData: FontAwesomeIcons.cartPlus, index: 1,),
            const SizedBox(width: 40,),
            BottomNavItem(label: "Budget", iconData: FontAwesomeIcons.wallet, index: 2,),
            BottomNavItem(label: "Products", iconData: Icons.star, index: 3,),
          ],
        ),
      ),
    );
  }
}
