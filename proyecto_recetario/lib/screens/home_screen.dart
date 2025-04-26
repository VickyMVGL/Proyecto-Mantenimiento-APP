import 'package:flutter/material.dart';
import 'maintenance_detail.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
        // Android 10.0.2.2
        // IOS 127.0.0.1
        // Web localhost:12346

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> maintenances = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    print("Inicializando HomeScreen...");
    _fetchMaintenances();
  }

  Future<void> _fetchMaintenances() async {
  setState(() => isLoading = true);

  try {
    // 1. Construcción de la URL (mejor manejada)
    const baseUrl = 'http://10.0.2.2:12346';
    const endpoint = '/maintenances';
    final uri = Uri.parse('$baseUrl$endpoint');

    // 2. Petición HTTP con timeout
    final response = await http.get(uri).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('La solicitud tardó demasiado');
      });

    // 3. Procesamiento de la respuesta
    await _handleResponse(response);

    } on TimeoutException catch (e) {
      _showError('Tiempo de espera agotado: $e');
    } on http.ClientException catch (e) {
      _showError('Error de conexión: ${e.message}');
    } on FormatException catch (e) {
      _showError('Error en el formato de los datos: $e');
    } catch (e) {
      _showError('Error inesperado: $e');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

Future<void> _handleResponse(http.Response response) async {
  switch (response.statusCode) {
    case 200:
    case 201:
      final data = _parseResponse(response.body);
      if (mounted) {
        setState(() => maintenances = data);
      }
      break;
    case 404:
      _showError('Endpoint no encontrado (404)');
      break;
    case 500:
      _showError('Error del servidor (500)');
      break;
    default:
      _showError('Error HTTP: ${response.statusCode}');
  }
}

dynamic _parseResponse(String body) {
  try {
    return jsonDecode(body);
  } on FormatException {
    throw FormatException('Respuesta JSON inválida');
  }
}

void _showError(String message) {
  if (!mounted) return;
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
  
  debugPrint('Error: $message');
}

  @override
  Widget build(BuildContext context) {
    print("Construyendo HomeScreen... isLoading: $isLoading");
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : maintenances.isEmpty
              ? Center(child: Text("No hay mantenimientos"))
              : ListView.builder(
                  itemCount: maintenances.length,
                  itemBuilder: (context, index) {
                    return _BuildCard(context, maintenances[index]);
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _showBotton(context);
        },
      ),
    );
  }

  Future<void> _showBotton(BuildContext context) {
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
      ),
    );
  }

  Widget _BuildCard(BuildContext context, dynamic maintenance) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MaintenanceDetail(maintenanceData: maintenance),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 125,
          child: Card(
            child: Row(
              children: <Widget>[
                SizedBox(width: 26),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      maintenance['maintenance'] ?? 'Sin datos',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 2,
                      width: 100,
                      color: Colors.deepOrangeAccent,
                    ),
                    Text(
                      maintenance['car'] ?? 'Sin datos',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Text(
                      maintenance['date'] ?? 'Sin fecha',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
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
  MaintenanceForm({super.key});

  

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _carController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _mechanicController = TextEditingController();
  final TextEditingController _maintenanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {

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
                _submitForm(context);
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

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Crear un mapa con los datos del formurlario
      final formData = {
        "car": _carController.text,
        "maintenance": _maintenanceController.text,
        "mechanic": _mechanicController.text,
        "description": _descriptionController.text,
        "date": _dateController.text,
        "notes": _notesController.text,
      };

      print(formData); // Verifica los valores antes de enviarlos

      print("Datos del formulario: $formData");

      print("Car: ${_carController.text}");
      print("Maintenance: ${_maintenanceController.text}");
      print("Mechanic: ${_mechanicController.text}");
      print("Description: ${_descriptionController.text}");
      print("Date: ${_dateController.text}");
      print("Notes: ${_notesController.text}");

      try {
        // Realizar la solicitud POST
        final response = await http.post(
          Uri.parse('http://10.0.2.2:12346/maintenances'), 
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(formData),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // cerrar el formulario y mostrar un mensaje
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Mantenimiento guardado con éxito")),
          );
        } else {
          // mostrar un mensaje de error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al guardar 2 el mantenimiento")),
          );
        }
      } catch (e) {
        // Manejo de errores
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error de conexión: $e")),
        );
      }
    }
  }

  Widget _builtTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int maxLines = 1,}) {

    return TextFormField(
      controller: controller,
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

