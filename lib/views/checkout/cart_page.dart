//Cart Page

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:shopeasy_client/global/constants.dart';
import 'package:shopeasy_client/views/checkout/checkout.dart';
import 'package:shopeasy_client/views/user/sign_up.dart';

import '../../global/style.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cartList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No Products in Cart',
                      style: Theme.of(context).textTheme.headline5),
                  const SizedBox(
                    height: 16,
                  ),
                  TextButton(
                    child: const Text('Continue Shopping'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          : Column(
              children: [
                //cart summary section
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cart Summary',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${cartList.length} items.',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            '\u20B9 ${calculateTotalPrice()}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.shopping_cart_checkout_rounded),
                        label: const Text('Checkout'),
                        onPressed: () {
                          //check if customer is logged in or not
                          if (isCustomerSignedIn == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckoutPage(
                                    totalPrice: calculateTotalPrice(),
                                  ),
                                ));
                          } else {
                            SignUpDialog(context).signUpDialog();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          primary: FlexColor.redWineDarkPrimaryContainer,
                          onPrimary: Colors.white,
                          textStyle: Theme.of(context).textTheme.button!,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Material(
                    color: Styles.getGrey(context),
                    borderRadius: BorderRadius.circular(8),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: cartList[index].media!,
                              fit: BoxFit.cover,
                              width: 48,
                              height: 48,
                            ),
                          ),
                          title: Text(
                              '${cartList[index].name!} - ${cartList[index].variant}'),
                          subtitle: Text('\u20b9${cartList[index].price}'),
                          //ellipsis button pop up
                          trailing: PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'Remove') {
                                setState(() {
                                  cartList.removeAt(index);
                                });
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'Remove ',
                                child: Text('Remove'),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  calculateTotalPrice() {
    double total = 0;
    for (int i = 0; i < cartList.length; i++) {
      total += cartList[i].price!.toDouble();
    }
    return total;
  }

  calculateTotalPriceWithTaxAndDelivery() {
    double total = 0;
    for (int i = 0; i < cartList.length; i++) {
      total += cartList[i].price!.toDouble();
    }
    return total * 1.18 + total * 0.05;
  }
}
