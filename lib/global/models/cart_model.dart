class CartModel {
  int? prodid;
  String? name;
  String? variant;
  int? price;
  int? qty;
  int? rating;
  String? media;
  int? id;

  CartModel(
      {this.prodid,
      this.name,
      this.variant,
      this.price,
      this.qty,
      this.rating,
      this.media,
      this.id});

  CartModel.fromJson(Map<String, dynamic> json) {
    prodid = json['prodid'];
    name = json['name'];
    variant = json['variant'];
    price = json['price'];
    qty = json['qty'];
    rating = json['rating'];
    media = json['media'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prodid'] = this.prodid;
    data['name'] = this.name;
    data['variant'] = this.variant;
    data['price'] = this.price;
    data['qty'] = this.qty;
    data['rating'] = this.rating;
    data['media'] = this.media;
    data['id'] = this.id;
    return data;
  }
}
