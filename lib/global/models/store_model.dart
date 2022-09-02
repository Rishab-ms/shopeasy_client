class StoreModel {
  String? storeName;
  String? legalName;
  String? industry;
  String? country;
  String? apartment;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? phno;
  String? email;
  String? currency;
  String? timeZone;
  String? unitSystem;
  String? weightUnit;
  String? idPrefix;
  String? idSuffix;
  List<String>? locations;
  List<String>? banner;
  List<Categories>? categories;
  int? id;

  StoreModel(
      {this.storeName,
      this.legalName,
      this.industry,
      this.country,
      this.apartment,
      this.address,
      this.city,
      this.state,
      this.pincode,
      this.phno,
      this.email,
      this.currency,
      this.timeZone,
      this.unitSystem,
      this.weightUnit,
      this.idPrefix,
      this.idSuffix,
      this.locations,
      this.categories,
      this.banner,
      this.id});

  StoreModel.fromJson(Map<String, dynamic> json) {
    storeName = json['storeName'];
    legalName = json['legalName'];
    industry = json['industry'];
    country = json['country'];
    apartment = json['apartment'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    phno = json['phno'];
    email = json['email'];
    currency = json['currency'];
    timeZone = json['timeZone'];
    unitSystem = json['unitSystem'];
    weightUnit = json['weightUnit'];
    idPrefix = json['idPrefix'];
    idSuffix = json['idSuffix'];
    locations = json['locations'].cast<String>();
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    banner = json['banner'].cast<String>();
    id = json['id'];
  }
//toString method to print the store details
  @override
  String toString() {
    return 'StoreModel{storeName: $storeName, legalName: $legalName, industry: $industry, country: $country, apartment: $apartment, address: $address, city: $city, state: $state, pincode: $pincode, phno: $phno, email: $email, currency: $currency, timeZone: $timeZone, unitSystem: $unitSystem, weightUnit: $weightUnit, idPrefix: $idPrefix, idSuffix: $idSuffix, locations: $locations, categories: $categories, id: $id}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeName'] = storeName;
    data['legalName'] = legalName;
    data['industry'] = industry;
    data['country'] = country;
    data['apartment'] = apartment;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['pincode'] = pincode;
    data['phno'] = phno;
    data['email'] = email;
    data['currency'] = currency;
    data['timeZone'] = timeZone;
    data['unitSystem'] = unitSystem;
    data['weightUnit'] = weightUnit;
    data['idPrefix'] = idPrefix;
    data['idSuffix'] = idSuffix;
    data['locations'] = locations;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['banner'] = banner;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  List<Children>? children;

  Categories({this.id, this.name, this.children});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String? name;

  Children({this.name});

  Children.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
