import 'package:app_tienda_mobile/view/home_view.dart';
import 'package:app_tienda_mobile/view/mailbox_view.dart';
import 'package:app_tienda_mobile/view/orders_views.dart';
import 'package:app_tienda_mobile/view/stores_view_mcja.dart';
import 'package:flutter/material.dart';
import 'package:app_tienda_mobile/persistence/server_connection.dart';
import 'dart:ui';
import 'login.dart';

class CustomerFormView extends StatelessWidget {
  const CustomerFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Registro de Clientes';
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        ),
        body: MyCustomForm(),
        bottomNavigationBar: Container(
          height: 55.0,
          child: BottomAppBar(
            color: Color.fromRGBO(58, 66, 86, 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home, color: Colors.white),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeView()));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.store, color: Colors.white),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListPage()));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.directions_bike, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FinalOrdersListView()));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.markunread_mailbox, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MailBoxFormView()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
final makeBottom = Container(
  height: 55.0,
  child: BottomAppBar(
    color: Color.fromRGBO(58, 66, 86, 1.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.store, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.directions_bike, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.mail, color: Colors.white),
          onPressed: () {},
        )
      ],
    ),
  ),
);
*/

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  late String _nombre, _direccion, _fijo, _celular, _email, _password;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Ingrese su nombre',
              labelText: 'Nombre',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el texto en la casilla';
              } else {
                setState(() {
                  this._nombre = value;
                });
                return null;
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.add_location),
              hintText: 'Ingrese su dirección',
              labelText: 'Dirección',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el texto en la casilla';
              } else {
                setState(() {
                  this._direccion = value;
                });
                return null;
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.phone_iphone),
              hintText: 'Ingrese su número de celular',
              labelText: 'Celular',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el texto en la casilla';
              } else {
                setState(() {
                  this._celular = value;
                });
                return null;
              }
            },
          ),
          /*
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.phone),
              hintText: 'Ingrese su número fijo',
              labelText: 'Teléfono Fijo',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el texto en la casilla';
              } else {
                setState(() {
                  this._fijo = value;
                });
                return null;
              }
            },
          ),
          */
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.alternate_email),
              hintText: 'Ingrese su correo electrónico',
              labelText: 'Email',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el texto en la casilla';
              } else {
                setState(() {
                  this._email = value;
                });
                return null;
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.password),
              hintText: 'Seleccione su contraseña',
              labelText: 'Contraseña',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el texto en la casilla';
              } else {
                setState(() {
                  this._password = value;
                });
                return null;
              }
            },
          ),
          new Container(
            padding: const EdgeInsets.only(left: 100.0, top: 20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(58, 66, 86, 1.0), // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  var srvcon = ServerConnection()
                      .insert(
                          'Customers',
                          ';' +
                              _nombre +
                              ';' +
                              _direccion +
                              ';' +
                              _celular +
                              ';' +
                              _email +
                              ';' +
                              _password)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Datos insertados en el servidor')),
                    );
                  });
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => login()),
                );
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
