import 'package:flutter/material.dart';
import 'maintenance_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<dynamic>> FetchMaintenances() async {
    final url = Uri.parse('http://localhost:12346/maintenances');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column (
        children: <Widget>[
        _BuildCard(context),
        _BuildCard(context),
      ],),
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



  Widget _BuildCard (BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MaintenanceDetail(maintenanceName: 'mantenimiento',)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width, 
          height: 125,
          child: Card(
            child: Row(
              children: <Widget>[
                Container(
                  height: 125, 
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network("data:image/jpeg;base64,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", fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(width: 26,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Text("Lasagna", style: TextStyle(fontSize: 20),),
                  SizedBox(height: 5,),
                  Container(
                    height: 2,
                    width: 100,
                    color: Colors.deepOrangeAccent,
                  ),
                  Text("Vicky Gonzalez", style: TextStyle(fontSize: 14)),
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

