import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_recetario/models/maintenance_model.dart';
import 'package:proyecto_recetario/providers/maintenance_provider.dart';

class MaintenanceDetail extends StatefulWidget {
  final Maintenance maintenanceData;
  const MaintenanceDetail({super.key, required this.maintenanceData});

  @override
  _MaintenanceDetailState createState() => _MaintenanceDetailState();
}

class _MaintenanceDetailState extends State<MaintenanceDetail> {

  bool isImportant = false;

  @override
  void didChangeDependecies(){
    super.didChangeDependencies();
    isImportant = Provider.of<MaintenanceProvider>(context, listen: false).importantMaintenance.contains(widget.maintenanceData);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.maintenanceData.maintenance, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        leading: IconButton(onPressed:() {Navigator.pop(context);}, 
        icon: Icon(Icons.arrow_back_ios_new), 
        color: Colors.white,),
        actions: [
          IconButton(
            onPressed: () async {
              await Provider.of<MaintenanceProvider>(context, listen: false).toogleImportantStatus(widget.maintenanceData);
              setState(() {
                isImportant = !isImportant;
                });
              
            },
            icon: Icon( isImportant ? Icons.star : Icons.star_border, color: Colors.white,),
          ),
        ],
      ),
    );
  }
}
