// ignore_for_file: file_names

import 'package:exhibition/Controller/ordercontroller.dart';
import 'package:exhibition/Screens/Home/orders.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'Scan.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(),
    const Scan(),
    const Orders(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: "Home",
                backgroundColor: Theme.of(context).primaryColor),
            BottomNavigationBarItem(
                icon: const Icon(Icons.qr_code_scanner),
                label: "scan",
                backgroundColor: Theme.of(context).primaryColor),
            BottomNavigationBarItem(
                icon: const Icon(Icons.shop),
                label: "Order",
                backgroundColor: Theme.of(context).primaryColor),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
