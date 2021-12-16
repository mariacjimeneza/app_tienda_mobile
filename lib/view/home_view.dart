import 'package:app_tienda_mobile/view/stores_view.dart';
import 'package:app_tienda_mobile/view/stores_view_mcja.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../customer_form_mcja.dart';
import 'mailbox_view.dart';
import 'orders_views.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> images = [
    //"https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "images/Tiendas.png",
    "images/Clientes.png",
    "images/Pedidos.png",
    "images/BuzonSug.png"
    /*
    "images/TuComercio.png"

*/
  ];

  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          print(message.notification!.body);
          print(message.notification!.title);
        }
        print(message);
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (messagge) {
        final routeMessagge = messagge.data["route"];
        print(routeMessagge);
        Navigator.of(context).pushNamed(routeMessagge);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("TuComercio"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        ),
        body: Container(
          padding: EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: images.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                /*
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                */
                crossAxisCount: 2,
                childAspectRatio: 2 / 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 5),
            itemBuilder: (context, index) => buildCell(context, index),
          ),
          decoration: BoxDecoration(
            color: Colors.indigo[20],
          ),
        ),
      ),
    );
  }

  Widget buildCell(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        _navigateTo(context, index);
      }, // handle your image tap here
      child: Image.asset(
        images[index],
        fit: BoxFit.cover, // this is the solution for border
        width: 15.0,
        height: 15.0,
      ),
    );
  }

  _navigateTo(context, int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListPage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CustomerFormView()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FinalOrdersListView()),
      );
//StoresListView
      // HomePage

      /*var t1 = Store("149", "Maria", "Modelia", 20.2, -78.2, "4108655",
          "maria@gmail", "www.maria", BusinessType.Drogueria, "xxx");
      var t2 = Store("150", "Camila", "Salitre", 30.2, -98.2, "2954585",
          "camila@gmail", "www.camila", BusinessType.Minimercado, "yyy");

      DataBaseManager.db.insertarNuevaTienda(t1);
      DataBaseManager.db.insertarNuevaTienda(t2);

      DataBaseManager.db.listaTiendas("SELECT * FROM Tienda").then((value) {
        var tiendas = value.toList();
        tiendas.forEach((element) {
          print(element.toString());
        });
      });
    */
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MailBoxFormView()),
      );
    }
    return;
  }
}
