import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column (
        children: <Widget>[
        _BuildCard(context),
        _BuildCard(context),
      ],)
    );
  }

  Widget _BuildCard (BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width, 
      height: 125,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              height: 125, 
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), 
                child: Container(),
              ),
            ),
            SizedBox(width: 26,),
            Column(
              children: <Widget>[
              Text("Vicky Gonzalez"),
              Text("Lasagna"),
              Container(
                height: 2,
                width: 100,
                color: Colors.deepOrangeAccent,
              )
              ],
            ),
          ],
        ),
      ),
    );
  }

}

