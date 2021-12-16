import 'package:app_tienda_mobile/model/product.dart';
import 'package:app_tienda_mobile/model/store.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseManager {
  static late Database _database;
  final String _dataBaseName = "MiBarrioAppBaseDatos.db";

  DataBaseManager._(); //constructor que se debe llamar igual a la clase y es privado
  static final DataBaseManager db = DataBaseManager._();
  var initialize = false;

  Future<Database> get database async {
    if (!initialize) {
      _database = await iniciarBaseDatos();
      initialize = true;
    }
    return _database;
  }

// instrucción sql para crear la tabla Tienda
//#region
  final String _CREATE_TABLE_TIENDA = "CREATE TABLE TIENDA("
      "id INTEGER PRIMARY KEY,"
      "name TEXT,"
      "address TEXT,"
      "latitude real,"
      "longitude real,"
      "cellphone TEXT,"
      "email TEXT,"
      "webpage TEXT,"
      "type TEXT,"
      "logo TEXT"
      ")";

//#endregion

  // instrucción sql para crear la tabla pedido temporal
//#region
  final String _CREATE_TABLE_PEDIDOTEMP = "CREATE TABLE PEDIDOTEMP("
      "id INTEGER,"
      "idstore INTEGER,"
      "name TEXT,"
      "presentation TEXT,"
      "price DOUBLE,"
      "quantity INTEGER"
      ")";

//#endregion

  iniciarBaseDatos() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dataBaseName);
    return await openDatabase(path, version: 14, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(_CREATE_TABLE_TIENDA);
      await db.execute(_CREATE_TABLE_PEDIDOTEMP);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      if (oldVersion < newVersion) {
        await db.execute("DROP TABLE IF EXISTS TIENDA");
        await db.execute(_CREATE_TABLE_TIENDA);
        await db.execute("DROP TABLE IF EXISTS PEDIDOTEMP");
        await db.execute(_CREATE_TABLE_PEDIDOTEMP);
      }
    });
  }

  insertarNuevaTienda(Store st) async {
    final db = await database;
    var res = await db.insert("TIENDA", st.toJson());
    return res;
  }

  insertarNuevoProductoTemp(Product pdt) async {
    final db = await database;
    //var res = await db.insert("PEDIDOTEMP", pdt.toJson());
    var selectPdt = await db.rawQuery(
        "SELECT quantity FROM PEDIDOTEMP WHERE id = " + pdt.id.toString());
    if (selectPdt.isNotEmpty) {
      int nuevaCantidad = int.parse(selectPdt[0]["quantity"].toString()) + 1;
      var updatePdt = await db.rawUpdate("UPDATE PEDIDOTEMP SET quantity = " +
          nuevaCantidad.toString() +
          " WHERE id = " +
          pdt.id.toString());
      return updatePdt;
    }
    else {
      var res = await db.insert("PEDIDOTEMP", pdt.toJson());
      return res;
    }
  }

  eliminarNuevoProductoTemp(Product pdt) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT quantity FROM PEDIDOTEMP WHERE id = " + pdt.id.toString());
    if (int.parse(res[0]["quantity"].toString()) > 1) {
      int nuevaCantidad = int.parse(res[0]["quantity"].toString()) - 1;
      var updatePdt = await db.rawUpdate("UPDATE PEDIDOTEMP SET quantity = " +
          nuevaCantidad.toString() +
          " WHERE id = " +
          pdt.id.toString());
      return updatePdt;
    }
    else {
      var deletePdt = await db.rawDelete(
          "DELETE FROM PEDIDOTEMP WHERE id = " + pdt.id.toString());
      return deletePdt;
    }
  }

  Future<List<Store>> listaTiendas(String query) async {
    final db = await database;
    var res = await db.rawQuery(query);
    List<Store> list = [];
    if (res.isNotEmpty) {
      List<Map<String, dynamic>> temp = res.toList();
      for (Map<String, dynamic> t in temp) {
        list.add(Store.fromJson(t));
      }
    }
    return list;
  }

  Future<List<Product>> listaProductosPedidoTemp() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM PEDIDOTEMP");
    List<Product> list = [];
    if (res.isNotEmpty) {
      //await db.rawQuery("DELETE FROM PEDIDOTEMP");
      List<Map<String, dynamic>> temp = res.toList();
      for (Map<String, dynamic> t in temp) {
        list.add(Product.fromJson(t));
      }
    }
    return list;
  }

  // borra todo el pedido
  Future deleteProductosPedidoTemp() async{
    final db = await database;
    await db.rawQuery("DELETE FROM PEDIDOTEMP");
  }

  /*Future<List<Product>> deleteProductosPedidoTemp() async {
    final db = await database;
    var res = await db.rawQuery("DELETE FROM PEDIDOTEMP");
    List<Product> list = [];
    if (res.isNotEmpty) {
      List<Map<String, dynamic>> temp = res.toList();
      for (Map<String, dynamic> t in temp) {
        list.add(Product.fromJson(t));
      }
    }
    return list;
  }
*/
}
