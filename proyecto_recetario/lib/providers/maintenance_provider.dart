import 'package:flutter/material.dart';
import 'package:proyecto_recetario/screens/maintenance_detail.dart';
import '../models/maintenance_model.dart';
import 	'package:http/http.dart' as http;
import 'dart:convert';

class MaintenanceProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Maintenance> maintenances = [];
  List<Maintenance> importantMaintenance = [];

  Future<void> FetchMaintenances() async {
  isLoading = true;
  notifyListeners();

    final url = Uri.parse('http://10.0.2.2:12346/maintenances');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) { 
        final data = jsonDecode(response.body);
        maintenances= List<Maintenance>.from(data['maintenances'].map((maintenance) => Maintenance.fromJson(maintenance)));
      } else {
        print("Error: ${response.statusCode}");
        maintenances = [];
      }
    }catch (e) {
      print("Error: $e");
      maintenances = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toogleImportantStatus(Maintenance maintenance) async {
    final isImportant = importantMaintenance.contains(maintenance);

    try {
      final url = Uri.parse('http://10.0.2.2:12346/important');
      final response = isImportant
          ? await http.delete(url, body: json.encode({"id": maintenance.id}))
          : await http.post(url, body: json.encode(maintenance.toJson));

          if (response.statusCode == 200) {
            if (isImportant) {
              importantMaintenance.remove(maintenance);
            } else {
              importantMaintenance.add(maintenance);
            }
            notifyListeners();

          } else {
            throw Exception("Error al cambiar el estado de importante");
          }
    } catch (e) {
      print("Error al actualizar estatus: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}