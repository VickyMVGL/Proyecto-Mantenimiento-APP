import 'package:flutter/material.dart';
import '../../screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "hola mundo",
      home: RecipeBook(),
      theme: ThemeData(primarySwatch: Colors.deepOrange, fontFamily: 'Roboto'),
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text("Recipe Book", style: TextStyle(color: Colors.white)
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [
            Tab(icon: Icon(Icons.home) , text: "Home",)
          ]),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
          ],
        )
      ),
    );
  }
}
