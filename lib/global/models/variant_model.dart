class VariantModel {
  List<VariantDetails>? variantDetails;
  int? id;

  VariantModel({this.variantDetails, this.id});

  VariantModel.fromJson(Map<String, dynamic> json) {
    if (json['variantDetails'] != null) {
      variantDetails = <VariantDetails>[];
      json['variantDetails'].forEach((v) {
        variantDetails!.add(VariantDetails.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (variantDetails != null) {
      data['variantDetails'] = variantDetails!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}

class VariantDetails {
  bool? editVariant;
  String? sku;
  String? variantName;
  String? price;      
  String? compPrice;
  bool? chargeTax;
  String? costPerItem;
  OptionsAvail? optionsAvail;

  VariantDetails(
      {this.editVariant,
      this.sku,
      this.variantName,
      this.price,
      this.compPrice,
      this.chargeTax,
      this.costPerItem,
      this.optionsAvail});

  VariantDetails.fromJson(Map<String, dynamic> json) {
    editVariant = json['editVariant'];
    sku = json['sku'].toString();

    variantName = json['variantName'];
    price = json['price'].toString();
    compPrice = json['compPrice'].toString();
    chargeTax = json['chargeTax'];
    costPerItem = json['costPerItem'].toString();
    optionsAvail = json['optionsAvail'] != null
        ? OptionsAvail.fromJson(json['optionsAvail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['editVariant'] = editVariant;
    data['sku'] = sku;
    data['variantName'] = variantName;
    data['price'] = price;
    data['compPrice'] = compPrice;
    data['chargeTax'] = chargeTax;
    data['costPerItem'] = costPerItem;
    if (optionsAvail != null) {
      data['optionsAvail'] = optionsAvail!.toJson();
    }
    return data;
  }
}

class OptionsAvail {
  String? size;
  String? color;
  String? material;
  String? style;

  OptionsAvail({this.size, this.color, this.material, this.style});

  OptionsAvail.fromJson(Map<String, dynamic> json) {
    size = json['size'].toString();
    color = json['color'].toString();
    material = json['material'].toString();
    style = json['style'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    data['color'] = color;
    data['material'] = material;
    data['style'] = style;
    return data;
  }
}
