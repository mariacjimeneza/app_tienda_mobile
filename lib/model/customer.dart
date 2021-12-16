class Customer {
  final String id;
  final String name;
  final String address;
  final String cellphone;
  final String email;
  final String password;

  Customer(this.id, this.name, this.address, this.cellphone, this.email,
      this.password);

  Customer.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['name'],
        address = json['address'],
        cellphone = json['cellphone'].toString(),
        email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "cellphone": cellphone,
        "email": email,
        "password": password,
      };
}
