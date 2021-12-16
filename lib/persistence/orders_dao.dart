import 'package:app_tienda_mobile/model/order.dart';
import 'package:app_tienda_mobile/persistence/server_connection.dart';
import 'dart:convert' as JSON;

class OrderDAO {
  static final List<Order> orders = [];

  Future<List<Order>> getProductsOrderFromServer(String idpedido) async {
    final List<Order> orders = [];
    var srvConn = ServerConnection();

    await srvConn.getProductsOrder(idpedido).then((productsData) {
      List<String> records = productsData.split('|');
      for (var element in records) {
        orders.add(Order.fromString(idpedido + ";" + element));
      }
    });
    return orders;
  }
}
