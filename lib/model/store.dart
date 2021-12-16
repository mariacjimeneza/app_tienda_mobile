enum BusinessType {
  Tienda,
  Drogueria,
  Panaderia,
  Papeleria,
  Licoreria,
  Minimercado
}

class Store {
  final String id;
  final String name;
  final String address;
  final double latitude, longitude;
  final String cellphone;
  final String email;
  final String webpage;
  final BusinessType type;
  final String logo;
  final String logoProducts;

  Store(
      this.id,
      this.name,
      this.address,
      this.latitude,
      this.longitude,
      this.cellphone,
      this.email,
      this.webpage,
      this.type,
      this.logo,
      this.logoProducts);

  Store.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['name'],
        address = json['address'],
        //latitude = double.parse(json['latitude'].toString()),
        //longitude = double.parse(json['longitude'].toString()),
        latitude = json['latitude'],
        longitude = json['longitude'],
        cellphone = json['cellphone'].toString(),
        email = json['email'],
        webpage = json['webpage'],
        type = BusinessType.values.firstWhere(
            (element) => element.toString() == json['type'].toString()),
        logo = json['logo'],
        logoProducts = json['logoProducts'];
//'BusinessType.' +
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "cellphone": cellphone,
        "email": email,
        "webpage": webpage,
        "type": type.toString(),
        "logo": logo,
        "logoProducts": logoProducts,
      };
}
