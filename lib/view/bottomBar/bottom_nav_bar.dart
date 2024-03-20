import 'package:flutter/material.dart';
import 'package:meditation/view/setting/setting_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../dashboard/dashboard_screen.dart';
import '../stats/stats_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  var bodyList = [
    MeditationScreen(),
    StatsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyList.elementAt(selectedIndex),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.dashboard),
            title: Text("Dashboard"),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.bar_chart),
            title: Text("Stats"),
            selectedColor: Colors.orange,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Setting"),
            selectedColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
