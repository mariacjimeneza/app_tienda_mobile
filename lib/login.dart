
import 'package:app_tienda_mobile/persistence/customers_dao.dart';
import 'package:app_tienda_mobile/view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'customer_form_mcja.dart';
import 'model/customer.dart';

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Bienvenido a TuComercio"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('images/TuComercio.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Ingrese una cuenta de correo válida'),
                /*
                validator: (value) {
                  var myList =
                  //var myList = [24, 56, 84, 92];
                  var value = 84;
                  //var myList = CustomerDAO.addCustomersFromServer();
                  if (value == null ) { //|| value.isEmpty
                    return 'Por favor ingrese el texto en la casilla';
                  } else if (myList.contains(value)) {
                    print('$value is not present in the list $myList');
                  } else {
                    return null;
                  }
                },*/
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                    hintText: 'Ingrese su contraseña'),
              ),
            ),
            FlatButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                '¿Olvidó su contraseña?',
                style: TextStyle(
                    color: Color.fromRGBO(58, 66, 86, 1.0), fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(58, 66, 86, 1.0),
                  borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomeView()));
                },
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerFormView()),
                );
              },
              child: Text('¿Nuevo Usuario? Crear cuenta'),
            )
          ],
        ),
      ),
    );
  }
}
