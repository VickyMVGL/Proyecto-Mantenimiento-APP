import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_recetario/providers/maintenance_provider.dart';
import 'package:proyecto_recetario/screens/maintenance_detail.dart';
import 'package:proyecto_recetario/models/maintenance_model.dart';

class ImportantMaintenanceScreen extends StatelessWidget{
  const ImportantMaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<MaintenanceProvider>(
        builder: (context, MaintenanceProvider, child) {
          final importantMaintenance = MaintenanceProvider.importantMaintenance;
      
          return importantMaintenance.isEmpty
              ? Center(child: Text("No hay mantenimientos importantes"))
              : ListView.builder(
                  itemCount: importantMaintenance.length,
                  itemBuilder: (context, index) {
                    return ImportantMaintenanceCard(maintenance: importantMaintenance[index]);
                  },
                );
        }
      ) 
    );
  }
}

class ImportantMaintenanceCard extends StatelessWidget {
  final Maintenance maintenance;
  const ImportantMaintenanceCard({super.key, required this.maintenance});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MaintenanceDetail(maintenanceData: maintenance)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width, 
          height: 125,
          child: Card(
            child: Row(
              children: <Widget>[
            
                SizedBox(width: 26,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Text(maintenance.maintenance, style: TextStyle(fontSize: 20),),
                  SizedBox(height: 5,),
                  Container(
                    height: 2,
                    width: 100,
                    color: Colors.deepOrangeAccent,
                  ),
                  Text(maintenance.car, style: TextStyle(fontSize: 14)),
                  SizedBox(height: 5,),
                  
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}