class Order {
  late int idpedido;
  late int idstore;
  late int id;
  late String name;
  late String presentation;
  late int quantity;
  late double price;

  //Product(this.id, this.idstore, this.name, this.presentation, this.price, this.quantity);

  //data = id;name;unity;price
  Order.fromString(String texto) {
    texto = texto.replaceAll(",", ";");
    List<String> list_pr = texto.split(";");
    idpedido = int.parse(list_pr[0]);
    idstore = int.parse(list_pr[1]);
    id = int.parse(list_pr[2]);
    name = list_pr[3];
    presentation = list_pr[4];
    quantity = int.parse(list_pr[5]);
    price = double.parse(list_pr[6]);
  }

  Order.fromJson(Map<String, dynamic> json)
      : idpedido = int.parse(json['idpedido'].toString()),
        idstore = int.parse(json['idstore'].toString()),
        id = int.parse(json['id'].toString()),
        name = json['name'],
        presentation = json['presentation'],
        quantity = int.parse(json['quantity'].toString()),
        price = double.parse(json['price'].toString());

  Map<String, dynamic> toJson() => {
        "idpedido": idpedido,
        "idstore": idstore,
        "id": id,
        "name": name,
        "presentation": presentation,
        "quantity": quantity,
        "price": price,
      };
}
