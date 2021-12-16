import 'package:app_tienda_mobile/model/product.dart';
import 'package:app_tienda_mobile/persistence/database_manager.dart';
import 'package:app_tienda_mobile/persistence/server_connection.dart';
import 'package:app_tienda_mobile/view/stores_view_mcja.dart';
import 'package:flutter/material.dart';

import 'orders_views.dart';

class OrderListView extends StatefulWidget {
  late final idpedido;
  final List<Product> order;

  OrderListView(this.order);

  @override
  _OrderListViewState createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  final _biggerFont =
      const TextStyle(fontSize: 18.0, color: Color.fromRGBO(255, 99, 71, 1.0));
  var counter = 0;
  String datos = '0' +
      ';' +
      '100' +
      ',' +
      '1' +
      ',' +
      'gato' +
      ',' +
      'caja' +
      ',' +
      '2000' +
      ',' +
      '240';

  void handleTap(int item) {
    switch (item) {
      case 1:
        //print("hola");
        DataBaseManager.db.deleteProductosPedidoTemp().then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Pedido eliminado")),
          );
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OrderListView(value)));
        });
        break;

      case 2:
        DataBaseManager.db.listaProductosPedidoTemp().then((value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ListPage()));
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi carrito"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(165, 42, 42, 1.0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        /*
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListPage()),
            );
          },
          child: Icon(
            Icons.arrow_back, // add custom icons also
          ),
        ),
        */
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item) => handleTap(item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 1, child: Text('Eliminar pedido')),
              PopupMenuItem<int>(
                  value: 2, child: Text('Continuar con el pedido')),
            ],
          ),
        ],
/*
        /*AGREGADO OJO*/
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item) => handleTap(item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 1, child: Text('Carrito de Compras')),
            ],
          ),
        ],
        /*HASTA AQUÍ OJO */
*/
      ),
      body: _buildOrderList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FinalOrdersListView()),
          );

          setState(() {
            datos = '';

            widget.order.forEach((prd) {
              //datos = datos + ';' + '[' + prd.id.toString() + ' ' + prd.name + ']';

              datos = datos +
                  prd.idstore.toString() +
                  ',' +
                  prd.id.toString() +
                  ',' +
                  prd.name +
                  ',' +
                  prd.presentation +
                  ',' +
                  prd.quantity.toString() +
                  ',' +
                  prd.price.toString() +
                  '|';
            });
            counter++;
            datos = counter.toString() + ";" + datos;
          });
          var srvcon = ServerConnection();
          srvcon.insert('Orders', datos).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Pedido confirmado")),
            );
          });
        },
        label: Text('Confirmar Pedido'),
        icon: Icon(Icons.touch_app),
        backgroundColor: Color.fromRGBO(165, 42, 42, 1.0),
      ),
    );
  }

  Widget _buildOrderList() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.order.length,
        //widget.order.length * 2,
        itemBuilder: /*1*/ (context, i) {
          return ListTile(
            title: _buildRow(widget.order[i]),
          );
        });
  }

  // itemBuilder: /*1*/ (context, i) {
  // return _buildRow(widget.order[i]);
  //});

  Widget _buildRow(Product pdt) {
    return ListTile(
      title: Text(
        pdt.name,
        /*style: _biggerFont,*/
        style: TextStyle(fontSize: 17, color: Colors.black),
      ),
      subtitle: Text(
        '\$' + pdt.price.toString() + '\n' + pdt.presentation,
        style: TextStyle(fontSize: 12, color: Colors.blueGrey),
      ),
      trailing: Icon(Icons.check_circle_outline, size: 30, color: Colors.green),
    );
  }
}
