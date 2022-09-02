import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductModel {
  String? title;
  String? description;
  List<String>? media;
  int? id;
  int? price;
  int? compPrice;
  bool? chargeTax;
  int? costPerItem;
  double? weight;
  bool? hasOptions;
  bool? isPhysicalProduct;
  bool? doesExpire;
  String? sku;
  bool? trackQuantity;
  bool? sellOutOfStock;
  List<Branches>? branches;
  List<Options>? options;
  List<String>? tags;
  List<String>? category;
  Availabilty? availabilty;
  String? weightCat;
  String? status;
  int? rating;
  int? orderCount;

  List<String> images = [
    'https://images.unsplash.com/photo-1617005082133-548c4dd27f35?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
    'https://images.unsplash.com/photo-1494232410401-ad00d5433cfa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=799&q=80',
    'https://images.unsplash.com/photo-1610824352934-c10d87b700cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
  ];

  ProductModel(
      {this.title,
      this.description,
      this.media,
      this.price,
      this.compPrice,
      this.chargeTax,
      this.costPerItem,
      this.hasOptions,
      this.options,
      this.sku,
      this.trackQuantity,
      this.sellOutOfStock,
      this.branches,
      this.isPhysicalProduct,
      this.weight,
      this.weightCat,
      this.availabilty,
      this.doesExpire,
      this.status,
      this.tags,
      this.category,
      this.rating,
      this.orderCount,
      this.id});

  ProductModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    // media = json['media']?.cast<String>() ?? images;
    media = shuffleMedia();
    media!.insert(0, json['media']);
    price = json['price'] ?? 0;
    compPrice = json['compPrice'] ?? 0;
    chargeTax = json['chargeTax'] ?? false;
    costPerItem = json['costPerItem'] ?? 0;
    hasOptions = json['hasOptions'] ?? false;
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    category = json['category'].cast<String>();
    sku = json['sku'].toString();
    trackQuantity = json['trackQuantity'];
    sellOutOfStock = json['sellOutOfStock'];
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(Branches.fromJson(v));
      });
    }
    isPhysicalProduct = json['isPhysicalProduct'];
    var tempWeight = json['weight'];
    if (tempWeight != null) {
      weight = tempWeight.toDouble();
    } else {
      weight = 0.0;
    }
    weightCat = json['weightCat'];
    availabilty = json['availabilty'] != null
        ? Availabilty.fromJson(json['availabilty'])
        : null;
    doesExpire = json['doesExpire'];
    status = json['status'];
    tags = json['tags'] == null ? [] : json['tags'].cast<String>();
    rating = json['rating'] ?? 0;
    orderCount = json['totalOrders'] ?? 0;
    id = json['id'];
  }
//method that shuffles the media array
  List<String> shuffleMedia() {
    images.shuffle();
    return images;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['media'] = shuffleMedia();
    data['price'] = price;
    data['compPrice'] = compPrice;
    data['chargeTax'] = chargeTax;
    data['costPerItem'] = costPerItem;
    data['hasOptions'] = hasOptions;
    data['category'] = category;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['sku'] = sku;
    data['trackQuantity'] = trackQuantity;
    data['sellOutOfStock'] = sellOutOfStock;
    if (branches != null) {
      data['branches'] = branches!.map((v) => v.toJson()).toList();
    }
    data['isPhysicalProduct'] = isPhysicalProduct;
    data['weight'] = weight;
    data['weightCat'] = weightCat;
    if (availabilty != null) {
      data['availabilty'] = availabilty!.toJson();
    }
    data['doesExpire'] = doesExpire;
    data['status'] = status;
    data['tags'] = tags;
    data['rating'] = rating;
    data['orderCount'] = orderCount;

    data['id'] = id;
    return data;
  }

  //card view to display important infos of product
  Card dynamicCard() {
    //list of random image urls of products from unsplash api

    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // const SizedBox(
          //   height: 4,
          // ),
          ListTile(
            title: Text(title ?? '-',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            subtitle: description != null
                ? description!.isEmpty
                    ? const Offstage()
                    : Text(
                        description ?? '-',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      )
                : const Offstage(),
            trailing: Text(
              '\$${price ?? '0'}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Hero(
            tag: id ?? 'default id',
            child: ClipRRect(
              //border only for top
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: media![0],
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Options {
  String? optionName;
  List<OptionValue>? optionValue;

  Options({this.optionName, this.optionValue});

  Options.fromJson(Map<String, dynamic> json) {
    optionName = json['optionName'];
    if (json['optionValue'] != null) {
      optionValue = <OptionValue>[];
      json['optionValue'].forEach((v) {
        optionValue!.add(OptionValue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['optionName'] = optionName;
    if (optionValue != null) {
      data['optionValue'] = optionValue!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OptionValue {
  String? value;
  int? price;
  int? qty;
  int? sku;
  List<Branches>? branches;

  OptionValue({this.value, this.price, this.qty, this.sku, this.branches});
  @override
  String toString() {
    return 'OptionValue{value: $value, price: $price, qty: $qty, sku: $sku, branches: $branches}';
  }

  OptionValue.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    price = json['price'];
    qty = json['qty'];
    sku = json['sku'];
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(Branches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['price'] = price;
    data['qty'] = qty;
    data['sku'] = sku;
    if (branches != null) {
      data['branches'] = branches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Branches {
  String? selectedLocation;
  String? stockCount;

  Branches({this.selectedLocation, this.stockCount});

  Branches.fromJson(Map<String, dynamic> json) {
    selectedLocation = json['selectedLocation'];
    stockCount = json['stockCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['selectedLocation'] = selectedLocation;
    data['stockCount'] = stockCount;
    return data;
  }
}

class Availabilty {
  String? from;
  String? to;

  Availabilty({this.from, this.to});

  Availabilty.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}

Future<List<ProductModel>> getProductListFromJson(String jsonData) async {
  final jsonResponse = json.decode(jsonData);
  return List<ProductModel>.from(
      jsonResponse.map((x) => ProductModel.fromJson(x)));
}
