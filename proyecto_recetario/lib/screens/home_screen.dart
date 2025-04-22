import 'package:flutter/material.dart';
import 'maintenance_detail.dart';
import 'package:provider/provider.dart';
import '../providers/maintenance_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
        // Android 10.0.2.2
        // IOS 127.0.0.1
        // Web localhost:12346


  @override
  Widget build(BuildContext context) {
    final maintenancesProvider = Provider.of<MaintenanceProvider>(context, listen: false);
    maintenancesProvider.FetchMaintenances();
    maintenancesProvider.FetchMaintenances();

    return Scaffold(
      body: Consumer<MaintenanceProvider>(

        builder: (context, provider, child){
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (provider.maintenances.isEmpty) {
            return Center(child: Text("No hay mantenimientos"),);
          } else {
            return ListView.builder(
              itemBuilder: (context, index){
                return _BuildCard(context, provider.maintenances[index]);
              },
              itemCount:provider.maintenances.length,
              );
          }  
        }
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: (){
          _showBotton(context);
        },
          // Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeForm()));
      ),
    );
  }


  Future<void> _showBotton(BuildContext context){
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: MaintenanceForm(),
        ),
      ) 
    );
  }



  Widget _BuildCard (BuildContext context, dynamic maintenance){
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

class MaintenanceForm extends StatelessWidget {
  const MaintenanceForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    
    TextEditingController _carController = TextEditingController();
    TextEditingController _dateController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();
    TextEditingController _notesController = TextEditingController();
    TextEditingController _mechanicController = TextEditingController();
    TextEditingController _maintenanceController = TextEditingController();

    return Padding(padding: EdgeInsets.all(8),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Añadir nuevo mantenimiento", 
          style: TextStyle(color: Colors.deepOrangeAccent, 
          fontSize: 24),),
          SizedBox(height: 20,),
          _builtTextField(controller: _carController, label: "Carro", validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingrese el nombre del carro';
            }
            return null;
          },),
          SizedBox(height: 20,),
          _builtTextField(
            controller: _maintenanceController, 
            label: "Mantenimiento Realizado", 
            validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingrese el tipo de mantenimiento';
            }
            return null;
          },),
          SizedBox(height: 20,),
          _builtTextField(
            controller: _mechanicController,
            label: "Taller o Mecanico",
            validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingrese el nombre del taller o mecanico';
            }
            return null;
          },),
          SizedBox(height: 20,),
          _builtTextField(
            controller: _descriptionController,
            maxLines: 4,
            label: "Descripcion del mantenimiento", validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingrese una descripcion del mantenimiento';
            }
            return null;
          },),
          SizedBox(height: 20,),
          _builtTextField( 
            controller: _dateController ,
            label: "Fecha de Mantenimiento" , 
            validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingrese la fecha del mantenimiento';
            }
            return null;
          },),
          SizedBox(height: 20,),
          _builtTextField(
            controller: _notesController,  
            maxLines: 3,
            label:  "Notas", validator: (value) {
            if (value == null || value.isEmpty) {
              return null;
            }
            return null;
          },),
          SizedBox(height: 20,),
          Center(
            child: ElevatedButton(
              onPressed: (){
                if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
                }
              }
              ,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )
              ),
              child: Text("Guardar", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),),
            ) 
          )
        ],
      )
    ));
  }

  Widget _builtTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int maxLines = 1,}) {

    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontFamily: "Quicksand",
          color: Colors.deepOrangeAccent,
          fontSize: 16,
        ),
        
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.deepOrangeAccent,
            width: 2,
          )
        ), 
      ),
      validator: validator,
      maxLines: maxLines,   
    );
  }
}

