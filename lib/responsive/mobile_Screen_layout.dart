import 'package:flutter/material.dart';
import 'package:instagram_flutter/constants/global_variables.dart';
import 'package:instagram_flutter/util/colors.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  //int _page = 0;
  int currentPageIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeScreenItems
        
      [currentPageIndex],
      
      bottomNavigationBar: NavigationBar(
        //shadowColor: Colors.red,
        backgroundColor: mobileBackgroundColor,
        //surfaceTintColor: Colors.red,
        indicatorColor: mobileBackgroundColor,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.home,
              color: currentPageIndex == 0 ? primaryColor : secondaryColor,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search,
                color: currentPageIndex == 1 ? primaryColor : secondaryColor),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box_outlined,
                color: currentPageIndex == 2 ? primaryColor : secondaryColor),
            label: 'Post',
          ),
          NavigationDestination(
            icon: Icon(Icons.movie_creation_outlined,
                color: currentPageIndex == 3 ? primaryColor : secondaryColor),
            label: 'Reels',
          ),
          NavigationDestination(
            icon: Icon(Icons.person,
                color: currentPageIndex == 4 ? primaryColor : secondaryColor),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
