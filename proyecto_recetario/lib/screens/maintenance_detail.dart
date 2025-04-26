import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:proyecto_recetario/providers/maintenance_provider.dart';

class MaintenanceDetail extends StatelessWidget {
  final Map<String, dynamic> maintenanceData;
  const MaintenanceDetail({super.key, required this.maintenanceData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(maintenanceData['maintenance'] ?? 'Sin datos', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mantenimiento: ${maintenanceData['maintenance'] ?? 'Sin datos'}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Vehículo: ${maintenanceData['car'] ?? 'Sin datos'}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Descripción: ${maintenanceData['description'] ?? 'Sin datos'}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Mecanico o taller: ${maintenanceData['mechanic'] ?? 'Sin datos'}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Fecha de Mantenimiento: ${maintenanceData['date'] ?? 'Sin datos'}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Notas: ${maintenanceData['notes'] ?? 'Sin datos'}",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
