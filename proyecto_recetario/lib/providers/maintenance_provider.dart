import 'package:flutter/material.dart';
import '../models/maintenance_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MaintenanceProvider with ChangeNotifier {
  List<dynamic> maintenances = [];
  bool isLoading = false;

  Future<void> FetchMaintenances() async {
    isLoading = true;
    notifyListeners();

    try {
      final uri = Uri.parse('http://10.0.2.2:12346/maintenances');
      final response = await http.get(uri).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception('La solicitud tardó demasiado');
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        maintenances = jsonDecode(response.body);
        print("Mantenimientos cargados: $maintenances");
      } else {
        maintenances = [];
        print("Error HTTP: ${response.statusCode}");
      }
    } catch (e) {
      print("Error al cargar los mantenimientos: $e");
      maintenances = [];
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> addMaintenance(Maintenance maintenance) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://10.0.2.2:12346/maintenances');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(maintenance.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await FetchMaintenances();
      } else {
        throw Exception("Error al agregar mantenimiento");
      }
    } catch (e) {
      print("Error al agregar mantenimiento: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

//   Future<void> toogleImportantStatus(Maintenance maintenance) async {
//     final isImportant = importantMaintenance.contains(maintenance);

//     try {
//       final url = Uri.parse('http://10.0.2.2:12346/important');
//       final response = isImportant
//           ? await http.delete(url, body: json.encode({"id": maintenance.id}))
//           : await http.post(url, body: json.encode(maintenance.toJson()));

//           if (response.statusCode == 200) {
//             if (isImportant) {
//               importantMaintenance.remove(maintenance);
//             } else {
//               importantMaintenance.add(maintenance);
//             }
//             notifyListeners();
//           } else {
//             throw Exception("Error al cambiar el estado de importante");
//           }
//     } catch (e) {
//       print("Error al actualizar estatus: $e");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }