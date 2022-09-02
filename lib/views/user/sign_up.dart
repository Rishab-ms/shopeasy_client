import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopeasy_client/Services/network_services.dart';
import 'package:shopeasy_client/global/constants.dart';
import 'package:shopeasy_client/global/utilities.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shopeasy_client/views/user/customer_info.dart';
import '../../global/models/customer_model.dart';
import 'add_new_customer.dart';

class SignUpDialog {
  BuildContext? context;
  SignUpDialog(this.context);
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  void signUpDialog() {
    {
      //sign up dialog

      showDialog(
        context: context!,
        builder: (context) => AlertDialog(
          title: const Text('Sign Up'),
          content: const Text('Please sign up to continue'),
          actions: [
            //Already have an account button
            TextButton(
              child: const Text('Already have an account'),
              onPressed: () {
                TextEditingController emailController = TextEditingController();
                Navigator.pop(context);
                //sign in with email dialog
                emailSignIn(context, emailController);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: FlexColor.redWineDarkPrimary),
              child:
                  const Text('Sign Up', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUp(),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('Not Now'),
              onPressed: () {
                Navigator.pop(context);
                //show a snackbar that says they have to sign in to order
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('To order, you must be signed in'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Sign In',
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
  }

  Future<dynamic> emailSignIn(
      BuildContext context, TextEditingController emailController) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign In'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email used to sign up',
              ),
            ),
            const SizedBox(height: 16),
            RoundedLoadingButton(
              controller: _btnController,
              width: MediaQuery.of(context).size.width * 0.5,
              successColor: Colors.green,
              animateOnTap: false,
              color: FlexColor.redWineDarkPrimary,
              onPressed: () {
                if (emailController.text.isNotEmpty) {
                  checkForAccount(
                    context,
                    emailController,
                  );
                } else {
                  Utilities.showToast('Please Enter Email', false);
                }
              },
              child:
                  const Text('Sign In', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  void checkForAccount(
    BuildContext context,
    TextEditingController emailController,
  ) async {
    _btnController.start();
    List<CustomerModel> customerList = await fetchCustomerData();
    bool found = false;

    for (CustomerModel customer in customerList) {
      if (customer.email == emailController.text) {
        Fluttertoast.cancel();
        Utilities.showToast('Account Found!', true);
        customerDetails = customer;
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerDetail(
              customer: customer,
            ),
          ),
        );
        _btnController.stop();
        _btnController.reset();
        found = true;
        isCustomerSignedIn = true;

        break;
      }

      //no account found
      if (found == false) {
        Fluttertoast.cancel();
        Fluttertoast.showToast(
          msg: 'No account found',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      _btnController.stop();
      _btnController.reset();
    }
  }
}
