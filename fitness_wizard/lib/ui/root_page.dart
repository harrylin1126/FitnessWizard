import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:page_transition/page_transition.dart';
import '../constants.dart';
import 'screens/home_page.dart';
import 'screens/activity_page.dart';
import 'screens/map_page.dart';
import 'screens/scan_page.dart';
import 'screens/profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _bottomNavIndex = 0;

  //List of the pages
  List<Widget> pages = const [
    HomePage(),
    GoogleMapPage(),
    ActivitiesPage(),
    ProfilePage(),
  ];

  //List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.map,
    Icons.local_fire_department_outlined,
    Icons.person,
  ];

  //List of the pages titles
  List<String> titleList = [
    'Home',
    'GoogleMap',
    'Activity',
    'Profile',
  ];

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleList[_bottomNavIndex],
              style:
              TextStyle(
                color: Constants.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            Icon(Icons.notifications, color: Constants.blackColor, size: 30.0,)
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, PageTransition(child: const ScanPage(), type: PageTransitionType.bottomToTop));
        },
        child: Image.asset('assets/images/code-scan-two.png', height: 30.0,),
        backgroundColor: Constants.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        splashColor: Constants.primaryColor,
        activeColor: Constants.primaryColor,
        inactiveColor: Colors.black.withOpacity(0.5),
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
    );
  }
}