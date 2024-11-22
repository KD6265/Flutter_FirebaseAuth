import 'package:flex_box/screen/home_screen.dart';
import 'package:flex_box/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CustomBottomNavigationbar extends StatefulWidget {
   final Function(int) onTabSelected;

  const CustomBottomNavigationbar({super.key,required this.onTabSelected});

  @override
  State<CustomBottomNavigationbar> createState() => _CustomBottomNavigationbarState();
}

class _CustomBottomNavigationbarState extends State<CustomBottomNavigationbar> {
 
  
  int myIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const ProfileScreen(),
    // const Center(child: Text("Settings")),
  ];

  @override
  Widget build(BuildContext context) {
    return  Align(
        alignment: Alignment.bottomCenter,
        child: BottomNavigationBar(
          currentIndex: myIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(AntDesign.home_fill),
              label: "Home",
              backgroundColor: Color.fromARGB(255, 137, 5, 160),
            ),
            BottomNavigationBarItem(
              icon: Icon(AntDesign.profile_fill),
              label: "Profile",
              backgroundColor: Color.fromARGB(255, 62, 13, 225),
            ),
            // BottomNavigationBarItem(icon: Icon(AntDesign.play_square_fill)),
          ],
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
            widget.onTabSelected(index);
          },
        ),
      );
  }
}
