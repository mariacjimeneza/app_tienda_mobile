import 'package:app_tienda_mobile/model/store.dart';
import 'package:app_tienda_mobile/persistence/server_connection.dart';
import 'dart:convert' as JSON;

class StoreDAO{
  static final List<Store> stores = [];

  static Future<void> addStoresFromServer() async{
    var srvConn = ServerConnection();
    await srvConn.select('Stores').then((stores_data) {
      var json = JSON.jsonDecode(stores_data);
      List records = json["data"];
      records.forEach((tienda_json) {
        stores.add(Store.fromJson(tienda_json));
      });
    });
  }
}