import 'package:app_tienda_mobile/view/home_view.dart';
import 'package:app_tienda_mobile/view/stores_view_mcja.dart';
import 'package:flutter/material.dart';
import 'package:app_tienda_mobile/persistence/server_connection.dart';
import 'dart:ui';
import 'package:app_tienda_mobile/customer_form_mcja.dart';

import 'orders_views.dart';

class MailBoxFormView extends StatelessWidget {
  const MailBoxFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Buzón de Sugerencias';
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(85, 107, 47, 1.0),
        ),
        body: MyCustomForm(),
        bottomNavigationBar: Container(
          height: 55.0,
          child: BottomAppBar(
            color: Color.fromRGBO(85, 107, 47, 1.0),
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
                  icon: Icon(Icons.account_box, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerFormView()));
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
                /*
                IconButton(
                  icon: Icon(Icons.markunread_mailbox, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MailBoxFormView()));
                  },
                )
                */
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
  late String _subject, _name, _email, _cellphone, _message;
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.topic),
            ),
            hint: Text('Ingrese su tema'),
            items: <String>['Calidad', 'Precio', 'Servicio', 'Otro']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (_) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el texto en la casilla';
              } else {
                setState(() {
                  this._subject = value;
                });
                return null;
              }
            },
          ),
          /*
    TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Ingrese su nombre completo',
              labelText: 'Nombres y apellidos',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el texto en la casilla';
              } else {
                setState(() {
                  this._name = value;
                });
                return null;
              }
            },
          ),
          /*
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.topic),
              hintText: 'Ingrese su tema',
              labelText: 'Tema',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el texto en la casilla';
              } else {
                setState(() {
                  this._subject = value;
                });
                return null;
              }
            },
          ),
          */
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.email),
              hintText: 'Ingrese su email',
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
              icon: const Icon(Icons.phone_iphone),
              hintText: 'Ingrese su número de celular',
              labelText: 'Celular',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el texto en la casilla';
              } else {
                setState(() {
                  this._cellphone = value;
                });
                return null;
              }
            },
          ),
          */
          TextFormField(
            maxLines: 4,
            decoration: const InputDecoration(
              icon: const Icon(Icons.markunread_mailbox),
              hintText: 'Ingrese su mensaje',
              labelText: 'Mensaje',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el texto en la casilla';
              } else {
                setState(() {
                  this._message = value;
                });
                return null;
              }
            },
          ),
          new Container(
            padding: const EdgeInsets.only(left: 150.0, top: 20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(85, 107, 47, 1.0), // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  var srvcon = ServerConnection()
                      .insert('MailBox', _subject + ';' + _message)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Datos insertados en el servidor')),
                    );
                  });
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
