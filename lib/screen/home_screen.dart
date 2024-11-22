import 'package:flex_box/screen/dashbord_screen.dart';
import 'package:flex_box/screen/profile_screen.dart';
import 'package:flex_box/screen/signIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0; // For BottomNavigationBar

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setBool("IsAuthenticated", false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }

  // List of screens for BottomNavigationBar
  final List<Widget> _screens = [
    const Center(child: DashbordScreen()),
    const Center(child: ProfileScreen()),
  ];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: _signOut, icon: const Icon(Icons.logout)),
        ],
        bottom: _selectedIndex == 0 // Show TabBar only on the first tab
            ? TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(icon: Icon(Icons.home), text: "Home"),
                  Tab(icon: Icon(Icons.person), text: "Person"),
                ],
              )
            : null,
      ),
      body: _selectedIndex == 0
          ? TabBarView(
              controller: _tabController,
              children: const [
                DashbordScreen(),
                Center(child: Text("Person Tab Content")),
              ],
            )
          : _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
