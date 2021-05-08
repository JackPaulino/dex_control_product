import 'package:dex_control_product/app/shared/useful/text_style.dart';

class ProductModel {
  int? id;
  late String name;
  String? image;
  double? price;
  double? stock;
  late DateTime dateRegister;

  ProductModel(
      {this.id,
      required this.name,
      this.image,
      this.price,
      this.stock,
      required this.dateRegister});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    stock = json['stock'];
    dateRegister = Appformat.dateHifen.parse(json['date_register']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['date_register'] = Appformat.dateHifen.format(this.dateRegister);
    return data;
  }
}
