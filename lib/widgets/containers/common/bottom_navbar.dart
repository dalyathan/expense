import 'package:flutter/material.dart';

import '../../icons/overview.dart';
import '../../icons/stats.dart';
import 'default_bottom_navbar_icon.dart';
import 'selected_bottom_navbar_icon.dart';

class CustomBottomNavBar extends StatefulWidget {
  final void Function(int) onItemTapped;
  final int selectedIndex;
  const CustomBottomNavBar(
      {Key? key, required this.onItemTapped, required this.selectedIndex})
      : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double iconWidth = size.width * 0.06;
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        getCustomItem(OverviewIcon(
          width: iconWidth,
        )),
        getCustomItem(Icon(
          Icons.payments_outlined,
          size: iconWidth * 1.5,
        )),
      ],
      currentIndex: widget.selectedIndex,
      onTap: widget.onItemTapped,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    );
  }

  BottomNavigationBarItem getCustomItem(Widget icon) {
    return BottomNavigationBarItem(
      icon: DefaultBottomNavBarIcon(icon: icon),
      label: '',
      activeIcon: ActiveBottomNavBarIcon(
        icon: icon,
      ),
    );
  }
}
