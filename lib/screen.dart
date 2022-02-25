import 'package:credit_card/routes/home.dart';
import 'package:flutter/material.dart';
import 'routes/overview.dart';
import 'widgets/containers/common/bottom_navbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();
  static const List<Widget> _widgetOptions = <Widget>[
    HomeRoute(
      key: PageStorageKey("HomeRoute1"),
    ),
    OverviewRoute(
      key: PageStorageKey("OverviewRoute0"),
    ),
    HomeRoute(
      key: PageStorageKey("HomeRoute2"),
    ),
    HomeRoute(
      key: PageStorageKey("HomeRoute2"),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: PageStorage(
              bucket: _bucket, child: _widgetOptions[_selectedIndex]),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          onItemTapped: _onItemTapped,
          selectedIndex: _selectedIndex,
        ),
      ),
    );
  }
}
