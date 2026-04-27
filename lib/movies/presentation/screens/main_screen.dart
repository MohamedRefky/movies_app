import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/movies/presentation/screens/bookmark_screen.dart';
import 'package:movies_app/movies/presentation/screens/home_screen.dart' show HomeScreen;
import 'package:movies_app/movies/presentation/screens/search_screeen.dart';

class MainScreeen extends StatefulWidget {
  const MainScreeen({super.key});

  @override
  State<MainScreeen> createState() => _MainScreeenState();
}

class _MainScreeenState extends State<MainScreeen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    BookmarkScreen(),
    SearchScreeen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        enableFeedback: false,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bookmark_fill),
            label: "Bookmarks",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: "Search",
          ),
        ],
      ),
    );
  }
}
