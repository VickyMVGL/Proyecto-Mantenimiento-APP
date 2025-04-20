import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/home_screen.dart';
import '../../screens/ImportantMaintenanceScreen.dart';
import '../../providers/maintenance_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MaintenanceProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "hola mundo",
        home: const MaintenanceHistory(),
        ),
    );
  }
}

class MaintenanceHistory extends StatelessWidget {
  const MaintenanceHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text("Historial de Mantenimiento", style: TextStyle(color: Colors.white)
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [
            Tab(icon: Icon(Icons.home) , text: "Inicio",),
            Tab(icon: Icon(Icons.taxi_alert), text: "Importante",)
          ]),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            ImportantMaintenanceScreen(),
          ],
        )
      ),
    );
  }
}
