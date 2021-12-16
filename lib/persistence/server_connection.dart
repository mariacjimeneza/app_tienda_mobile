import 'package:http/http.dart' as http;

class ServerConnection {
  final _svrUrl =
      'https://script.google.com/macros/s/AKfycbziamu5KXfP5qLZcGXs4MHSa_ze7-mAL2oM9mjqTs_l2E4mcQw6/exec';

  Future<String> select(String table) async {
    final url = Uri.parse(_svrUrl + '?acc=1&tbl=' + table);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'Response status: ${response.statusCode}';
    }
  }

  Future<String> insert(String table, String data) async {
    final url = Uri.parse(_svrUrl);
    var response =
        await http.post(url, body: {'acc': '2', 'tbl': table, 'data': data});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'Response status: ${response.statusCode}';
    }
  }

  Future<String> getProducts(String idstore) async {
    final url = Uri.parse(_svrUrl + '?acc=3&idt=' + idstore);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'Response status: ${response.statusCode}';
    }
  }

  Future<String> getProductsOrder(String idpedido) async {
    final url = Uri.parse(_svrUrl + '?acc=4&idt=' + idpedido);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'Response status: ${response.statusCode}';
    }
  }

}
