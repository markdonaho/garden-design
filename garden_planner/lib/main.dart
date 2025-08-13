import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/garden_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GardenProvider>(
      create: (BuildContext context) => GardenProvider(),
      child: MaterialApp(
        title: 'Garden Planner',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

// Removed old MyHomePage scaffold in favor of HomeScreen
