import 'package:shopeasy_client/global/models/customer_model.dart';
import 'package:shopeasy_client/global/models/order_model.dart';
import 'package:shopeasy_client/global/models/product_model.dart';
import 'package:shopeasy_client/global/models/variant_model.dart';

import 'models/cart_model.dart';
import 'models/store_model.dart';

late Future<List<ProductModel>> futureProductList;
List<ProductModel> productList = [];

String baseUrl = "http://144.24.145.122:3000/";
List<VariantModel> variantModelList = [];
//store data
late StoreModel storeDetails;

late CustomerModel customerDetails;
bool isCustomerSignedIn = false;
List<OrderModel> orderList = [];
List<CartModel> cartList = [];

// List<ProductModel> productCartList = [];
// List<VariantDetails> variantCartList = [];
List<ProductModel> wishList = [];
