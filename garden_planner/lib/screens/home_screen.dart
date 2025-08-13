// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'garden_layout_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    GardenLayoutView(),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('Task List', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('Coming in the next session!', style: TextStyle(color: Colors.grey)),
        ],
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Donaho\'s Garden Planner'),
        elevation: 2,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Garden Beds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Tasks',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
      ),
    );
  }
}


