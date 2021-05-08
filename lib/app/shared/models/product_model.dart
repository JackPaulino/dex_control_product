class ProductModel {
  int? id;
  late String name;
  String? image;
  double? price;
  double? stock;
  late String dateModify;

  ProductModel(
      {this.id,
      required this.name,
      this.image,
      this.price,
      this.stock,
      required this.dateModify});

  ProductModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    stock = json['stock'];
    dateModify = json['date_modify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['date_modify'] = this.dateModify;
    return data;
  }
}
