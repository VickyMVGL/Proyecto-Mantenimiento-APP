import 'package:flutter/material.dart';



class MaintenanceDetail extends StatelessWidget {
  final String maintenanceName;
  const MaintenanceDetail({super.key, required this.maintenanceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(maintenanceName, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        leading: IconButton(onPressed:() {Navigator.pop(context);}, 
        icon: Icon(Icons.arrow_back_ios_new), 
        color: Colors.white,),
      ),

      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            
          ]
        ),
        ),


    );
  }
}