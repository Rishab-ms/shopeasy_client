class CustomerModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phno;
  bool? recieveMail;
  bool? recieveSMS;
  String? country;
  String? company;
  String? address;
  String? city;
  String? state;
  String? pinCode;
  bool? collectTax;
  String? note;
  List<String>? tags;
  List<Events>? events;

  CustomerModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phno,
      this.recieveMail,
      this.recieveSMS,
      this.country,
      this.company,
      this.address,
      this.city,
      this.state,
      this.pinCode,
      this.collectTax,
      this.note,
      this.tags,
      this.events});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phno = json['phno'];
    recieveMail = json['recieveMail'];
    recieveSMS = json['recieveSMS'];
    country = json['country'];
    company = json['company'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pinCode = json['pinCode'];
    collectTax = json['collectTax'];
    note = json['note'];
    tags = json['tags'] == null ? [] : json['tags'].cast<String>();

    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phno'] = phno;
    data['recieveMail'] = recieveMail;
    data['recieveSMS'] = recieveSMS;
    data['country'] = country;
    data['company'] = company;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['pinCode'] = pinCode;
    data['collectTax'] = collectTax;
    data['note'] = note;
    data['tags'] = tags;

    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  //to string method
  @override
  String toString() {
    return 'CustomerModel{id: $id, firstName: $firstName, lastName: $lastName, email: $email, phno: $phno, recieveMail: $recieveMail, recieveSMS: $recieveSMS, country: $country, company: $company, address: $address, city: $city, state: $state, pinCode: $pinCode, collectTax: $collectTax, note: $note, tags: $tags, events: $events}';
  }
}

class Events {
  int? id;
  String? text;
  String? time;

  Events({this.id, this.text, this.time});

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['time'] = time;
    return data;
  }
}
