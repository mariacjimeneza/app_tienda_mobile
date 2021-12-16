import 'package:app_tienda_mobile/model/store.dart';
import 'package:app_tienda_mobile/persistence/products_dao.dart';
import 'package:app_tienda_mobile/persistence/stores_dao.dart';
import 'package:app_tienda_mobile/view/products_view.dart';
import 'package:flutter/material.dart';

class StoresListView extends StatefulWidget {
  @override
  _StoresListViewState createState() => _StoresListViewState();
}

class _StoresListViewState extends State<StoresListView> {
  final _stores = StoreDAO.stores;

  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.indigo);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Listado de negocios en el barrio';
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          centerTitle: true,
        ),
        body: _buildStoresList(),
      ),
    );
  }




  Widget _buildStoresList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _stores.length,
        itemBuilder: /*1*/ (context, i) {
          return _buildRow(_stores[i]);
        });
  }

  Widget _buildRow(Store st) {
    return ListTile(
      title: Text(
        st.name,
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      subtitle: Text(
        st.address,
        style: TextStyle(fontSize: 15, color: Colors.blueGrey),
      ),
      leading: Image.network(
          "https://drive.google.com/uc?export=view&id=" + st.logo),
      trailing: Icon(Icons.location_on_outlined, size: 30, color: Colors.black),
      onLongPress: () {
        print(st.address);
      },
      onTap: () {
        var prDao = ProductDAO();
        prDao.getProductsFromServer(st.id).then((listaProductos) => {
              print(st.name),
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductsListView(listaProductos, st)),
              ),
            });
      },
    );
  }
}
