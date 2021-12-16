import 'package:app_tienda_mobile/model/product.dart';
import 'package:app_tienda_mobile/model/store.dart';
import 'package:app_tienda_mobile/persistence/database_manager.dart';
import 'package:flutter/material.dart';
import 'carrito_view.dart';

class ProductsListView extends StatefulWidget {
  final List<Product> LstPr;
  final Store comercio;

  ProductsListView(this.LstPr, this.comercio);

  @override
  _ProductsListViewState createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  final _biggerFont =
      const TextStyle(fontSize: 18.0, color: Color.fromRGBO(255, 99, 71, 1.0));

  void handleTap(int item) {
    switch (item) {
      case 1:
        //DataBaseManager.db.deleteProductosPedidoTemp();
        DataBaseManager.db.listaProductosPedidoTemp().then((value) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OrderListView(value)));
        });
        //OrderListView(value)
        //print("Seleccionó carrito compra");
        break;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Productos"),
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
              PopupMenuItem<int>(value: 1, child: Text('Carrito de Compras')),
            ],
          ),
        ],
      ),
      body: _buildStoresList(),
    );
  }

  Widget _buildStoresList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.LstPr.length,
        itemBuilder: /*1*/ (context, i) {
          return ListTile(
            title: _buildRow(widget.LstPr[i]),
          );
        });
  }

  Widget _buildRow(Product pdt) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(
                    width: 1.0, color: Color.fromRGBO(165, 42, 42, 1.0)))),
        child: IconButton(
          icon: Icon(Icons.add_shopping_cart, color: Colors.black),
          onPressed: () {
            pdt.quantity = 214;
            //print(pdt.name);
            DataBaseManager.db.insertarNuevoProductoTemp(pdt);
            DataBaseManager.db.listaProductosPedidoTemp().then((value) {
              print(value);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Producto agregado al carrito")),
            );
          },
        ),

        //Icon(Icons.local_grocery_store, color: Colors.black54),
      ),
      title: Text(
        pdt.name,
        /*style: _biggerFont,*/
        style: TextStyle(fontSize: 17, color: Colors.black),
      ),
      subtitle: Text(
        '\$' + pdt.price.toString() + '\n' + pdt.presentation,
        style: TextStyle(fontSize: 12, color: Colors.blueGrey),
      ),
      /*
      trailing: IconButton(
        icon: Icon(Icons.add_shopping_cart, color: Colors.black),
        onPressed: () {
          pdt.quantity = 214;
          //print(pdt.name);
          DataBaseManager.db.insertarNuevoProductoTemp(pdt);
          DataBaseManager.db.listaProductosPedidoTemp().then((value) {
            print(value);
          });
        },
      ),
      */
    );
  }
}
