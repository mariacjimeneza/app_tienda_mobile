import 'package:app_tienda_mobile/model/customer.dart';
import 'package:app_tienda_mobile/persistence/server_connection.dart';
import 'dart:convert' as JSON;

class CustomerDAO{
  static final List<Customer> customers = [];

  static Future<void> addCustomersFromServer() async{
    var srvConn = ServerConnection();
    await srvConn.select('Customers').then((customers_data) {
      var json = JSON.jsonDecode(customers_data);
      List records = json["data"];
      records.forEach((tienda_json) {
        customers.add(Customer.fromJson(tienda_json));
      });
    });
  }
}