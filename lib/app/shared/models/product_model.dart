class ProductModel {
  int? id;
  late String name;
  String? img;
  double? preco;
  double? quant;

  ProductModel({this.id, required this.name, this.img, this.preco, this.quant});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    preco = json['preco'];
    quant = json['quant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['preco'] = this.preco;
    data['quant'] = this.quant;
    return data;
  }
}
