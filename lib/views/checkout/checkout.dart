import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shopeasy_client/views/user/add_new_customer.dart';

import '../../global/constants.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key, required this.totalPrice}) : super(key: key);
  final totalPrice;
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  var paymentMethod = 'cash';
  RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(4),
                children: [
                  //order summary section
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey,
                          // width: 1,
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Summary:',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Items: ',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Spacer(),
                            Text(
                              '${cartList.length}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total: ',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Spacer(),
                            Text(
                              '\u20b9 ${widget.totalPrice}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                        const SizedBox(height: 4),
                        //tax and delivery charges section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tax: ',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Spacer(),
                            Text(
                              "\u20b9 " +
                                  calculateTotalPriceWithTaxAndDelivery()
                                      .toString(),
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                        const SizedBox(height: 8),
                        //total amount section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total payable: ',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Spacer(),
                            Text(
                              '\u20b9 ${widget.totalPrice + calculateTotalPriceWithTaxAndDelivery()}',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                        // const SizedBox(height: 4),
                        // Text(
                        //   'Order Total: \u20b9${widget.totalPrice}',
                        //   style: Theme.of(context).textTheme.headline6,
                        // ),
                        // const SizedBox(height: 4),
                        // //tax and delivery charges section
                        // Text(
                        //   'Tax and Delivery Charges:',
                        //   style: Theme.of(context).textTheme.headline6,
                        // ),
                        // const SizedBox(height: 4),
                        // Text(
                        //   '\u20b9${calculateTotalPriceWithTaxAndDelivery()}',
                        //   style: Theme.of(context).textTheme.headline6,
                        // ),
                      ],
                    ),
                  ),
                  const Divider(),
                  //payment method section
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Method:',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: 8),
                        RadioListTile(
                          title: const Text('Cash on Delivery'),
                          value: 'cash',
                          groupValue: paymentMethod,
                          selected: paymentMethod == 'cash',
                          contentPadding: const EdgeInsets.all(0),
                          onChanged: (value) {
                            setState(() {
                              paymentMethod = value.toString();
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text('Credit/Debit Card'),
                          contentPadding: const EdgeInsets.all(0),
                          value: 'card',
                          groupValue: paymentMethod,
                          selected: paymentMethod == 'card',
                          onChanged: (value) {
                            setState(() {
                              paymentMethod = value.toString();
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text('Net Banking'),
                          contentPadding: const EdgeInsets.all(0),
                          selected: paymentMethod == 'netbanking',
                          value: 'netbanking',
                          groupValue: paymentMethod,
                          onChanged: (value) {
                            setState(() {
                              paymentMethod = value.toString();
                            });
                          },
                        ),
                        //Upi
                        RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text('UPI'),
                          selected: paymentMethod == 'upi',
                          value: 'upi',
                          groupValue: paymentMethod,
                          onChanged: (value) {
                            setState(() {
                              paymentMethod = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  //address section
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //icon
                            const Icon(
                              Icons.map_rounded,
                              color: Colors.black,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Address:',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.edit_location_alt_rounded,
                                // color: Colors.grey,
                                size: 20,
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp(
                                      customer: customerDetails,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        //display customer address
                        Row(
                          children: [
                            Text("Address: ",
                                style: Theme.of(context).textTheme.headline6),
                            Text(
                              '${customerDetails.address!.isEmpty ? 'Not Available' : customerDetails.address}',
                              style: customerDetails.address!.isEmpty
                                  ? Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.red)
                                  : Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        //city
                        Row(
                          children: [
                            Text("City: ",
                                style: Theme.of(context).textTheme.headline6),
                            Text(
                              '${customerDetails.city!.isEmpty ? 'Not Available' : customerDetails.city}',
                              style: customerDetails.city!.isEmpty
                                  ? Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.red)
                                  : Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        //state
                        Row(
                          children: [
                            Text("State: ",
                                style: Theme.of(context).textTheme.headline6),
                            Text(
                              '${customerDetails.state!.isEmpty ? 'Not Available' : customerDetails.state}',
                              style: customerDetails.state!.isEmpty
                                  ? Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.red)
                                  : Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        //country

                        Row(
                          children: [
                            Text("Country: ",
                                style: Theme.of(context).textTheme.headline6),
                            Text(
                              '${customerDetails.country!.isEmpty ? 'Not Available' : customerDetails.country}',
                              style: customerDetails.country!.isEmpty
                                  ? Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.red)
                                  : Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        //zipcode
                        Row(
                          children: [
                            Text("Zipcode: ",
                                style: Theme.of(context).textTheme.headline6),
                            Text(
                              '${customerDetails.pinCode!.isEmpty ? 'Not Available' : customerDetails.pinCode}',
                              style: customerDetails.pinCode!.isEmpty
                                  ? Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.red)
                                  : Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //place order button
            buildPlaceOrderButton(),
          ],
        ));
  }

  Container buildPlaceOrderButton() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      child: RoundedLoadingButton(
        controller: _btnController,
        color: FlexColor.redWineDarkPrimary,
        onPressed: () {
          //button load for 2 seconds and then show success or failure
          _btnController.start();
          Future.delayed(const Duration(seconds: 2), () {
            _btnController.success();
            showSuccessDialog();
          });
        },
        child: const Text('Place Order',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
    );
  }

  calculateTotalPriceWithTaxAndDelivery() {
    double total = 0;
    for (int i = 0; i < cartList.length; i++) {
      total += cartList[i].price!.toDouble();
    }
    return total * 0.05;
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Order Placed Successfully!'),
          actions: [
            ElevatedButton(
              child: const Text('Continue Shopping'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
