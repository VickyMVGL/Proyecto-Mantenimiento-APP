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
      child: Column(
        children: [
          Text(maintenance.maintenance, style: TextStyle(color: Colors.black, fontSize: 20),),
          Text(maintenance.car, style: TextStyle(color: Colors.black, fontSize: 16),),
        ],
      ),
    );
  }
}