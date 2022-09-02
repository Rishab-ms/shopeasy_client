// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopeasy_client/views/user/customer_info.dart';

import '../../global/models/customer_model.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({Key? key, this.customer}) : super(key: key);
  final CustomerModel? customer;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //TextEditingControllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phnoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  bool collectTax = true;
  bool receiveMail = true;
  bool receiveSms = true;

  @override
  void initState() {
    super.initState();
    if (widget.customer != null) {
      _firstNameController.text = widget.customer!.firstName!;
      _lastNameController.text = widget.customer!.lastName!;
      _companyController.text = widget.customer!.company!;
      _emailController.text = widget.customer!.email!;
      _phnoController.text = widget.customer!.phno!;
      _addressController.text = widget.customer!.address!;
      _cityController.text = widget.customer!.city!;
      _stateController.text = widget.customer!.state!;
      _pinCodeController.text = widget.customer!.pinCode!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          widget.customer != null ? 'Edit My Details' : 'Sign Up',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: addOrUpdate,
          ),
        ],
      ),
      body: ListView(
        children: [
          //customer name text field
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(children: [
                //first name text field
                Expanded(
                  child: TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                //last name text field
                Expanded(
                  child: TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ])),
          //company name text field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _companyController,
              decoration: InputDecoration(
                prefixIcon: const Icon(FontAwesomeIcons.building),
                labelText: 'Company',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          //email text field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(FontAwesomeIcons.envelope),
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          //phone number text field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _phnoController,
              decoration: InputDecoration(
                prefixIcon: const Icon(FontAwesomeIcons.phone),
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          //address text field
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _addressController,
              decoration: InputDecoration(
                prefixIcon: const Icon(FontAwesomeIcons.addressBook),
                labelText: 'Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          //city and state text field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                //city text field
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(FontAwesomeIcons.city),
                      labelText: 'City',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                //state text field
                Expanded(
                  child: TextField(
                    controller: _stateController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(FontAwesomeIcons.city),
                      labelText: 'State',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //pin code and country text field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                //pin code text field
                Expanded(
                  child: TextField(
                    controller: _pinCodeController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(FontAwesomeIcons.mapMarkerAlt),
                      labelText: 'Pin Code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                //country text field
                Expanded(
                  child: TextField(
                    controller: _countryController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(FontAwesomeIcons.globe),
                      labelText: 'Country',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SwitchListTile(
            value: receiveMail,
            onChanged: (value) {
              setState(() {
                receiveMail = value;
              });
            },
            title: Text('Email Updates'),
          ),
          SwitchListTile(
            value: receiveSms,
            onChanged: (value) {
              setState(() {
                receiveSms = value;
              });
            },
            title: Text('SMS Updates'),
          ),
        ],
      ),

      // child:
    );
  }

  void addOrUpdate() {
    CustomerModel customer = CustomerModel(
        //random id

        firstName:
            _firstNameController.text.isEmpty ? '' : _firstNameController.text,
        lastName:
            _lastNameController.text.isEmpty ? '' : _lastNameController.text,
        company: _companyController.text.isEmpty ? '' : _companyController.text,
        email: _emailController.text.isEmpty ? '' : _emailController.text,
        phno: _phnoController.text.isEmpty ? '' : _phnoController.text,
        address: _addressController.text.isEmpty ? '' : _addressController.text,
        city: _cityController.text.isEmpty ? '' : _cityController.text,
        state: _stateController.text.isEmpty ? '' : _stateController.text,
        pinCode: _pinCodeController.text.isEmpty ? '' : _pinCodeController.text,
        country: _countryController.text.isEmpty ? '' : _countryController.text,
        note: _noteController.text.isEmpty ? '' : _noteController.text,
        tags:
            _tagsController.text.isEmpty ? [] : _tagsController.text.split(','),
        events: [],
        collectTax: collectTax,
        recieveMail: receiveMail,
        recieveSMS: receiveSms);

    // //confirm dialog
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Confirm Details'),
              content: Text(
                widget.customer == null
                    ? 'Save ${customer.firstName} ${customer.lastName}?'
                    : 'Update ${customer.firstName} ${customer.lastName}?',
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: Text(
                    widget.customer == null ? 'Sign up' : 'Confirm edits',
                  ),
                  onPressed: () {
                    //validate first name, last name and city and show a snackbar if any of them is empty
                    if (_firstNameController.text.isEmpty ||
                        _lastNameController.text.isEmpty ||
                        _emailController.text.isEmpty ||
                        _cityController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Please fill atleast name, email and city to Sign Up'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      widget.customer != null
                          ? updateCustomer(customer)
                          : addCustomer(customer);
                    }
                  },
                ),
              ],
            ));
  }

  void addCustomer(CustomerModel customer) async {
    //add customer
    var url = Uri.parse('http://144.24.145.122:3000/customers');
    Map data = customer.toJson();
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 201) {
      Fluttertoast.showToast(
          msg: "Customer added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Error adding customer",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } // //send a post request to add customer
    Navigator.pop(context);
  }

  updateCustomer(CustomerModel customer) async {
    var url = Uri.parse(
        'http://144.24.145.122:3000/customers/${widget.customer!.id}');
    Map data = customer.toJson();
    var body = json.encode(data);
    var response = await http.put(url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Edited successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    Navigator.pop(context);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CustomerDetail(customer: customer)));
  }
}
