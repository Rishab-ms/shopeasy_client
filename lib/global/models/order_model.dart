import 'dart:convert';

class OrderModel {
  String? order;
  String? date;
  List<int>? products;
  int? customer;
  String? status;
  int? subtotal;
  double? taxes;
  double? discount;
  double? total;
  List<String>? tags;
  String? notes;
  int? id;

  OrderModel(
      {this.order,
      this.date,
      this.products,
      this.customer,
      this.status,
      this.subtotal,
      this.taxes,
      this.discount,
      this.total,
      this.tags,
      this.notes,
      this.id});

  OrderModel.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    date = json['date'];
    products = json['products'].cast<int>();
    customer = json['customer'];
    status = json['status'];
    subtotal = json['subtotal'];
    taxes = json['taxes'];
    discount = json['discount'];
    total = json['total'];
    tags = json['tags'].cast<String>();
    notes = json['notes'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order'] = order;
    data['date'] = date;
    data['products'] = products;
    data['customer'] = customer;
    data['status'] = status;
    data['subtotal'] = subtotal;
    data['taxes'] = taxes;
    data['discount'] = discount;
    data['total'] = total;
    data['tags'] = tags;
    data['notes'] = notes;
    data['id'] = id;
    return data;
  }

  Future<List<OrderModel>> getOrderListFromJson(String jsonData) async {
    var data = json.decode(jsonData);
    return List<OrderModel>.from(data.map((x) => OrderModel.fromJson(x)));
  }
}
