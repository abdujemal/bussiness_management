
import 'package:bussiness_management/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bottom_nav_item.dart';

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
      child: BottomAppBar(        
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavItem(label: "Home", iconData: Icons.home_outlined, activeIcon: Icons.home_filled, index: 0,),
              BottomNavItem(label: "Order", iconData: Icons.delivery_dining_outlined, activeIcon: Icons.delivery_dining, index: 1,),
              const SizedBox(width: 40,),
              BottomNavItem(label: "Budget", iconData: Icons.account_balance_wallet_outlined, activeIcon: Icons.account_balance_wallet, index: 2,),
              BottomNavItem(label: "Products", iconData: Icons.star_outline, activeIcon: Icons.star, index: 3,),
            ],
          ),
        ),
      ),
    );
  }
}
