import 'package:app_tienda_mobile/model/order.dart';
import 'package:app_tienda_mobile/persistence/orders_dao.dart';
import 'package:app_tienda_mobile/view/stores_view_mcja.dart';
import 'package:flutter/material.dart';
import '../customer_form_mcja.dart';
import 'home_view.dart';
import 'mailbox_view.dart';

class FinalOrdersListView extends StatefulWidget {
  @override
  _FinalOrdersListViewState createState() => _FinalOrdersListViewState();
}

class _FinalOrdersListViewState extends State<FinalOrdersListView> {
  final _orders = OrderDAO.orders;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //title: appTitle,
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(250, 235, 215, 1.0),
      appBar: topAppBar,
      bottomNavigationBar: Container(
        height: 55.0,
        child: BottomAppBar(
          color: Color.fromRGBO(218, 165, 32, 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeView()));
                },
              ),
              IconButton(
                icon: Icon(Icons.store, color: Colors.white),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListPage()));
                },
              ),
              IconButton(
                icon: Icon(Icons.account_box, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerFormView()));
                },
              ),
              IconButton(
                icon: Icon(Icons.markunread_mailbox, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MailBoxFormView()));
                },
              )
            ],
          ),
        ),
      ),
      body: _buildProductsOrderList(),
    ));
  }

  final topAppBar = AppBar(
    elevation: 0.1,
    backgroundColor: Color.fromRGBO(218, 165, 32, 1.0),
    title: Text('Lista de Pedidos'),
    centerTitle: true,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.list),
        onPressed: () {},
      )
    ],
  );

  /*CORREGIR*/
  Widget _buildProductsOrderList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _orders.length,
        itemBuilder: (context, i) {
          return _buildRow(_orders[i]);
        });
  }

  Widget _buildRow(Order or) {
    return ListTile(
      title: Text(
        or.idpedido.toString(),
        /*style: _biggerFont,*/
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      trailing: Icon(Icons.location_on_outlined, size: 30, color: Colors.black),
      onLongPress: () {},
      onTap: () {},
    );
  }
}
