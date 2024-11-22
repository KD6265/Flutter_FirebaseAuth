import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  Widget child;
  Widget? bottomNavigationBar;
  AppBar? appbar =AppBar(
        backgroundColor: Colors.transparent,
        );
  CustomScaffold({super.key, required this.child,  this.bottomNavigationBar,this.appbar});
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      bottomNavigationBar: bottomNavigationBar,
      appBar: appbar,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Base layer
          Image.asset(
            "assets/images/image.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(child: child)
        ],
      ),
    );
  }
}
