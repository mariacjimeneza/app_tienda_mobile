import 'package:app_tienda_mobile/model/product.dart';
import 'package:app_tienda_mobile/persistence/server_connection.dart';

class ProductDAO {
  Future<List<Product>> getProductsFromServer(String idstore) async {
    final List<Product> products = [];
    var srvConn = ServerConnection();

    await srvConn.getProducts(idstore).then((productsData) {
      List<String> records = productsData.split('|');
      for (var element in records) {
        products.add(Product.fromString(idstore + ";" + element));
      }
    });
    return products;
  }
}
