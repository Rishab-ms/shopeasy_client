import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopeasy_client/global/models/customer_model.dart';
import 'package:shopeasy_client/global/models/order_model.dart';
import 'package:shopeasy_client/global/models/store_model.dart';
import 'package:shopeasy_client/global/models/variant_model.dart';
import 'package:shopeasy_client/global/utilities.dart';

import 'package:http/http.dart' as http;

import '../global/constants.dart';
import '../global/models/cart_model.dart';
import '../global/models/product_model.dart';

//method to get all products from server
List<ProductModel> parseProducts(String responseBody) {
  var list = json.decode(responseBody) as List;
  List<ProductModel> products =
      list.map((i) => ProductModel.fromJson(i)).toList();
  return products;
}

Future<List<ProductModel>> fetchProducts() async {
  final response = await http.get(Uri.parse('${baseUrl}products'));
  if (response.statusCode == 200) {
    storeDetails = await fetchStoreData();
    variantModelList = await fetchVariantList();
    cartList = await fetchCartData();
    if (!isCustomerSignedIn) {
      orderList = await fetchOrderData();
    }
    return parseProducts(response.body);
  } else {
    Utilities.showToast(
      'Something went wrong while fetching products',
      false,
    );
    throw Exception('Failed to load products');
  }
}

//fetch store data from server
Future<StoreModel> fetchStoreData() async {
  final response = await http.get(Uri.parse('${baseUrl}storeDetails'));
  if (response.statusCode == 200) {
    return parseStoreDetails(response.body);
  } else {
    Utilities.showToast(
      'Something went wrong while fetching store details',
      false,
    );
    throw Exception('Failed to load store details');
  }
}

StoreModel parseStoreDetails(String body) {
  var list = json.decode(body) as List;
  List<StoreModel> storeModels =
      list.map((i) => StoreModel.fromJson(i)).toList();
  return storeModels[0];
}

//variants
Future<List<VariantModel>> fetchVariantList() async {
  final response = await http.get(Uri.parse('${baseUrl}variants'));
  if (response.statusCode == 200) {
    return parseVariantList(response.body);
  } else {
    Utilities.showToast(
      'Something went wrong while fetching variants',
      false,
    );
    throw Exception('Failed to load variants');
  }
}

List<VariantModel> parseVariantList(String responseBody) {
  var list = json.decode(responseBody) as List;
  List<VariantModel> variantDetails =
      list.map((i) => VariantModel.fromJson(i)).toList();
  return variantDetails;
}

//fetch customer data from server
Future<List<CustomerModel>> fetchCustomerData() async {
  final response = await http.get(Uri.parse('${baseUrl}customers'));
  if (response.statusCode == 200) {
    return parseCustomerList(response.body);
  } else {
    Utilities.showToast(
      'Something went wrong while fetching customers',
      false,
    );
    throw Exception('Failed to load customers');
  }
}

List<CustomerModel> parseCustomerList(String body) {
  var list = json.decode(body) as List;
  List<CustomerModel> customerModels =
      list.map((i) => CustomerModel.fromJson(i)).toList();
  return customerModels;
}

//fetch cart data from server
Future<List<CartModel>> fetchCartData() async {
  final response = await http.get(Uri.parse('${baseUrl}cart'));
  if (response.statusCode == 200) {
    return parseCartList(response.body);
  } else {
    Utilities.showToast(
      'Something went wrong while fetching carts',
      false,
    );
    throw Exception('Failed to load carts');
  }
}

parseCartList(String body) {
  var list = json.decode(body) as List;
  List<CartModel> cartModels = list.map((i) => CartModel.fromJson(i)).toList();
  return cartModels;
}

//fetch orders data from server
Future<List<OrderModel>> fetchOrderData() async {
  final response = await http.get(Uri.parse('${baseUrl}orders'));
  if (response.statusCode == 200) {
    return parseOrderList(response.body);
  } else {
    Utilities.showToast(
      'Something went wrong while fetching orders',
      false,
    );
    throw Exception('Failed to load orders');
  }
}

parseOrderList(String body) {
  var list = json.decode(body) as List;
  List<OrderModel> orderModels =
      list.map((i) => OrderModel.fromJson(i)).toList();
  return orderModels;
}
