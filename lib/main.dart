import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopeasy_client/State/state_manager.dart';
import 'package:shopeasy_client/global/constants.dart';
import 'package:shopeasy_client/global/models/product_model.dart';
import 'package:shopeasy_client/views/product/product_details.dart';

import 'views/homepage/home_page.dart';

void main() {
  runApp(const ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const FlexScheme usedScheme = FlexScheme.redWine;
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(
        textTheme: GoogleFonts.nunitoTextTheme(textTheme),
        useMaterial3: true,
        scheme: usedScheme,
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => ProductsHomePage(),
      //   '/cart': (context) => CartPage(),
      //   '/checkout': (context) => CheckoutPage(),
      //   '/product': (context) => ProductDetails(),
      // },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<ProductModel>> products = ref.watch(productsStateFuture);
    return products.when(
      data: (data) {
        //set the products in the state manager
        productList = data;
        // print("Color scheme: " +
        //     FlexColor.redWineLightPrimaryContainer.toString());
        return const ProductsHomePage();
      },
      loading: () => const SplashScreen(),
      error: (error, stack) =>
          Scaffold(body: Center(child: Text('Error: ${error.toString()}'))),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlexColor.redWineDarkPrimaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splashScreen.png',
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
