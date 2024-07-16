import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:minimal_online_shop/ui/screens/cart_screen.dart';
import 'package:minimal_online_shop/ui/screens/home_screen.dart';
import 'package:minimal_online_shop/ui/screens/orders_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        buttonBackgroundColor: Colors.amber,
        color: Colors.amber,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.shopping_cart, size: 30),
          Icon(Icons.list, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentScreen = index;
          });
        },
      ),
      body: IndexedStack(
        index: _currentScreen,
        children: const [HomeScreen(), CartScreen(), OrdersScreen()],
      ),
    );
  }
}
