import 'package:app_tienda_mobile/persistence/stores_dao.dart';
import 'package:app_tienda_mobile/view/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login.dart';

//AIzaSyDYRUHIoeSUvfMQhcuKN2nsANGCYX-qx9g

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    print("Firebase arranca");
    StoreDAO.addStoresFromServer().then((value) {
      print("Datos del servidor cargados");
      runApp(login());
      //HomeView()
      });
  }); // Para que la función main se vuelva asincronica

}
