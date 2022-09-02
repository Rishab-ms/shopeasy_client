import 'package:riverpod/riverpod.dart';
import 'package:shopeasy_client/global/models/product_model.dart';

import '../Services/network_services.dart';

final productsStateFuture = FutureProvider<List<ProductModel>>(
  ((ref) async {
    return fetchProducts();
  }),
);
