import 'package:app_tienda_mobile/customer_form_mcja.dart';
import 'package:app_tienda_mobile/model/store.dart';
import 'package:app_tienda_mobile/persistence/products_dao.dart';
import 'package:app_tienda_mobile/persistence/stores_dao.dart';
import 'package:app_tienda_mobile/view/products_view.dart';
import 'package:flutter/material.dart';
import 'google_maps.dart';
import 'home_view.dart';
import 'package:app_tienda_mobile/view/google_maps.dart';
import 'mailbox_view.dart';
import 'orders_views.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _stores = StoreDAO.stores;

  final _biggerFont =
      const TextStyle(fontSize: 18.0, color: Color.fromRGBO(255, 99, 71, 1.0));

  Widget build(BuildContext context) {
    return MaterialApp(
        //title: appTitle,
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(250, 235, 215, 1.0),
      appBar: topAppBar,
      body: _buildStoresList(),
      bottomNavigationBar: Container(
        height: 55.0,
        child: BottomAppBar(
          color: Color.fromRGBO(165, 42, 42, 1.0),
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
                icon: Icon(Icons.account_box, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerFormView()));
                },
              ),
              IconButton(
                icon: Icon(Icons.directions_bike, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FinalOrdersListView()));
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
    ));
  }

  Widget _buildStoresList() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _stores.length,
        itemBuilder: /*1*/ (context, i) {
          return Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration:
                  BoxDecoration(color: Color.fromRGBO(220, 220, 220, .9)),
              child: _buildRow(_stores[i]),
            ),
          );
        });
  }

  Widget _buildRow(Store st) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.black))),
          child:Image.network(
              "https://drive.google.com/uc?export=view&id=" + st.logo),
          //Icon(Icons.storefront_sharp, color: Colors.black54),
        ),
        title: Text(
          st.name,
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Container(
          child: Row(
            children: <Widget>[
              //Icon(Icons.touch_app, color: Colors.yellowAccent),
              Text(st.type.toString().split('.')[1].trim(),
                  style: TextStyle(color: Colors.black54))
            ],
          ),
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.black54, size: 30.0),

        /* Ojo agregado*/
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailPage(st: st)));
        });
  }

  final topAppBar = AppBar(
    elevation: 0.1,
    backgroundColor: Color.fromRGBO(165, 42, 42, 1.0),
    title: Text('Listado de Comercios'),
    centerTitle: true,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.list),
        onPressed: () {},
      )
    ],
  );
}

/***********************/

class DetailPage extends StatelessWidget {
  //final _stores = StoreDAO.stores;
  final Store st;
  //var listaProductos;

  const DetailPage({Key? key, required this.st}) : super(key: key);

  void handleTap(context, int item) {
    switch (item) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleMapsWidget(st)),
        );
        break;
      case 1:
        var prDao = ProductDAO();
        prDao.getProductsFromServer(st.id).then((listaProductos) => {
              print(st.name),
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductsListView(listaProductos, st)),
              ),
            });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          //border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: const Text(
        " ",
        style: TextStyle(color: Colors.white),
      ),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          //border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: const Text(
        " ",
        style: TextStyle(color: Colors.white),
      ),
    );

    final topContentText = ListView(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 4.0),
        const Icon(
          Icons.store_mall_directory,
          color: Colors.black,
          size: 35.0,
        ),
        const SizedBox(
          width: 80.0,
          child: Divider(color: Color.fromRGBO(165, 42, 42, 1.0)),
        ),
        const SizedBox(height: 6.0),
        Text(
          st.name,
          style: const TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        Text(
          "Dirección: " + st.address,
          style: const TextStyle(color: Colors.black, fontSize: 10.0),
        ),
        /*Text(
          "Geolocalización: (" +
              st.latitude.toString() +
              ", " +
              st.longitude.toString() +
              ")",
          style: const TextStyle(color: Colors.black, fontSize: 10.0),
        ),*/
        Text(
          "Teléfono: " + st.cellphone,
          style: const TextStyle(color: Colors.black, fontSize: 10.0),
        ),
        Text(
          "e-mail: " + st.email,
          style: const TextStyle(color: Colors.black, fontSize: 10.0),
        ),
        Text(
          "Página web: " + st.webpage,
          style: const TextStyle(color: Colors.black, fontSize: 10.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(flex: 1, child: coursePrice)
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/drive-steering-wheel.jpg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration:
              const BoxDecoration(color: Color.fromRGBO(250, 235, 215, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            //child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        )
      ],
    );

    final bottomContentText = Container(
      height: 120.0,
      width: MediaQuery.of(context).size.width - 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white60,
          image: DecorationImage(
              image: new NetworkImage(
                  "https://drive.google.com/uc?export=view&id=" + st.logoProducts),
              fit: BoxFit.fill)),
    );

    /*
    final readButton = InkWell(
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
        width: 120,
        height: 40,
        color: Color.fromRGBO(165, 42, 42, 1.0),
        child: Text("Ver productos",
            style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
      ),
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

      /*
      Container(
        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(165, 42, 42, 1.0), // background
            onPrimary: Colors.white, // foreground
          ),
          onPressed: () {
          },
          child: const Text('Ver Productos'),
        ),
      ),
    */
    );
*/
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText], //, readButton
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
      appBar: AppBar(
        title: const Text("TuComercio"),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item) => handleTap(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Text('Mapa')),
              PopupMenuItem<int>(value: 1, child: Text('Productos')),
            ],
          ),
        ],
        centerTitle: true,
        backgroundColor: Color.fromRGBO(165, 42, 42, 1.0),
      ),
    );
  }
}

/***********************/
