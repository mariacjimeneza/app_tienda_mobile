class Product {
  late int id;
  late int idstore;
  late String name;
  late String presentation;
  late double price;
  late int quantity;

  //Product(this.id, this.idstore, this.name, this.presentation, this.price, this.quantity);

  //data = id;name;unity;price
  Product.fromString(String texto) {
    List<String> list_pr = texto.split(";");
    idstore = int.parse(list_pr[0]);
    id = int.parse(list_pr[1]);
    name = list_pr[2];
    presentation = list_pr[3];
    price = double.parse(list_pr[4]);
    quantity = 0;
  }

  Product.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString()),
        idstore = int.parse(json['idstore'].toString()),
        name = json['name'],
        presentation = json['presentation'],
        price = double.parse(json['price'].toString()),
        quantity = int.parse(json['quantity'].toString());

  Map<String, dynamic> toJson() => {
        "id": id,
        "idstore": idstore,
        "name": name,
        "presentation": presentation,
        "price": price,
        "quantity": quantity,
      };
}
