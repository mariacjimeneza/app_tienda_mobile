import 'package:app_tienda_mobile/persistence/server_connection.dart';
import 'package:flutter/material.dart';
/*
void main() => runApp(const MyApp());
*/
class CustomerFormView extends StatelessWidget {
  const CustomerFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Registro de Clientes';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  late String _nombre, _direccion, _fijo, _celular;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    const lblStyle = TextStyle(fontSize: 20, color: Colors.black);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nombre:',
            style: lblStyle,
          ),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else {
                setState(() {
                  this._nombre = value;
                });
                return null;
              }
            },
          ),
          const Text(
            'Dirección:',
            style: lblStyle,
          ),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }else {
                setState(() {
                  this._direccion = value;
                });
                return null;
              }
             },
          ),
          const Text(
            'Teléfono fijo:',
            style: lblStyle,
          ),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }else {
                setState(() {
                  this._fijo = value;
                });
                return null;
              }
            },
          ),
          const Text(
            'Número celular:',
            style: lblStyle,
          ),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }else {
                setState(() {
                  this._celular = value;
                });
                return null;
              }
             },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  var srvcon = ServerConnection().insert('Customers', _nombre + ';' + _direccion + ';'+ _fijo + ';' + _celular).then((value){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Datos insertados en el servidor.')),
                    );
                  });
                  
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.


                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
