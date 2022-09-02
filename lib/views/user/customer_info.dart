// ignore_for_file: deprecated_member_use

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;

import '../../global/constants.dart';
import '../../global/models/customer_model.dart';
import '../../global/style.dart';
import 'add_new_customer.dart';

class CustomerDetail extends StatefulWidget {
  CustomerDetail({Key? key, required this.customer}) : super(key: key);
  CustomerModel? customer;

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Account'),
          actions: [
            //edit customer and logout pop up menu
            PopupMenuButton<String>(
              onSelected: (String selected) {
                if (selected == 'edit') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp(
                        customer: widget.customer,
                      ),
                    ),
                  );
                } else if (selected == 'logout') {
                  setState(() {
                    isCustomerSignedIn = false;
                  });
                  Navigator.pop(context);
                }
              },
              color: FlexColorScheme.light().secondaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              position: PopupMenuPosition.under,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit Profile'),
                ),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ],
            ),
          ],
        ),
        body: personalInfo(context));
  }

  ListView personalInfo(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: [
          //basic info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Basic Info",
                    style: Theme.of(context).textTheme.headline5),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.user),
                    const SizedBox(width: 8),
                    Flexible(
                        child: Text(
                      '${widget.customer!.firstName} ${widget.customer!.lastName}',
                      maxLines: 3,
                      style: Theme.of(context).textTheme.headline6,
                    )),
                  ],
                ),
                //customer company
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.business_center_rounded),
                    const SizedBox(width: 8),
                    Flexible(
                        child: Text(
                      widget.customer!.company!,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.headline6,
                    )),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          Divider(),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Contact Info",
                    style: Theme.of(context).textTheme.headline5),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.phone),
                    const SizedBox(width: 8),
                    Text(
                      widget.customer!.phno ?? 'No phone number',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                //email
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.envelope),
                    const SizedBox(width: 8),
                    Flexible(
                        child: Text(
                      widget.customer!.email!,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.headline6,
                    )),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          //address box
          Divider(),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Address", style: Theme.of(context).textTheme.headline5),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.mapMarkerAlt),
                    const SizedBox(width: 8),
                    Flexible(
                        child: Text(
                      '${widget.customer!.address!}, ${widget.customer!.city!}, ${widget.customer!.state!}, ${widget.customer!.pinCode!}, ${widget.customer!.country!}',
                      maxLines: 3,
                      style: Theme.of(context).textTheme.headline6,
                    )),
                  ],
                ),
              ],
            ),
          ),
        ]);
  }
}
