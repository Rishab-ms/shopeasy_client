import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:shopeasy_client/global/constants.dart';
import 'package:shopeasy_client/global/models/product_model.dart';
import 'package:shopeasy_client/global/models/store_model.dart';
import 'package:shopeasy_client/views/checkout/cart_page.dart';
import 'package:shopeasy_client/views/user/add_new_customer.dart';
import 'package:shopeasy_client/views/user/customer_info.dart';
import 'package:shopeasy_client/views/user/sign_up.dart';

import '../checkout/orders.dart';
import '../product/product_category.dart';
import '../user/wishlist.dart';
import 'components/offer_tile.dart';
import 'components/product_tile.dart';

class ProductsHomePage extends StatefulWidget {
  const ProductsHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsHomePage> createState() => _ProductsHomePageState();
}

class _ProductsHomePageState extends State<ProductsHomePage> {
  final _advancedDrawerController = AdvancedDrawerController();
  late ScrollController _scrollController;
  bool _isAppBarExpanded = true;
  List<Categories>? productCategories = storeDetails.categories;
  List<ProductModel> latestProductList = [];
  List<ProductModel> popularProductList = [];
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels > (200 - kToolbarHeight)) {
          setState(() {
            _isAppBarExpanded = true;
          });
        } else {
          setState(() {
            _isAppBarExpanded = false;
          });
        }
      });
    latestProductList = getLatestProducts();
    popularProductList = getTopOrders();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      openScale: 0.8,
      openRatio: 0.5,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: buildDrawer(),
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            buildAppBar(context),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  //offers
                  buildOffers(context),
                  //top picks
                  buildTopPicks(context),
                  //latest products
                  buildLatestProducts(context),
                  //product categories large cards view
                  buildProductCategoriesLargeCardsView(context),
                  //store logo
                  buildStoreLogo(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SafeArea buildDrawer() {
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            //Greetings and user name
            const ListTile(
              title: Text(
                'Welcome to Shop Easy,\nRishab',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            //profile picture

            //home page
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                _advancedDrawerController.toggleDrawer();
              },
            ),
            //profile page
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My Details'),
              onTap: () {
                //check if customer is signed in
                if (isCustomerSignedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CustomerDetail(customer: customerDetails),
                    ),
                  );
                } else {
                  SignUpDialog(context).signUpDialog();
                }

                _advancedDrawerController.toggleDrawer();
              },
            ),
            //cart
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () {
                _advancedDrawerController.toggleDrawer();
                //push replacement
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const CartPage()),
                  ),
                );
              },
            ),
            //wishlist
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Wishlist'),
              onTap: () {
                _advancedDrawerController.toggleDrawer();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WishlistPage(),
                  ),
                );
              },
            ),
            //orders
            ListTile(
              leading: const Icon(Icons.shopping_basket),
              title: const Text('Orders'),
              onTap: () {
                //check if customer is signed in
                if (isCustomerSignedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrdersPage(),
                    ),
                  );
                } else {
                  SignUpDialog(context).signUpDialog();
                }
                _advancedDrawerController.toggleDrawer();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const OrdersPage(),
                //   ),
                // );
              },
            ),
            //settings
            // ListTile(
            //   leading: const Icon(Icons.settings),
            //   title: const Text('Settings'),
            //   onTap: () {
            //     _advancedDrawerController.toggleDrawer();
            //   },
            // ),

            const Spacer(),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white54,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: const Text('Terms of Service | Privacy Policy'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar buildAppBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: true,

      elevation: 0,
      expandedHeight: 250,
      leading: drawerIcon(),
      // backgroundColor: FlexColor.redWineDarkPrimaryContainer,
      actions: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _isAppBarExpanded
              ? IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _advancedDrawerController.toggleDrawer();
                  },
                )
              : Container(),
        ),
      ],
      title: const Text(
        'Home',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                FlexColor.redWineDarkPrimaryContainer,
                FlexColor.redWineDarkPrimaryContainer,
                FlexColor.redWineDarkPrimary,
                // FlexColor.redWineLightPrimaryContainer,
                Colors.white,
                // Colors.white,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + kToolbarHeight,
              ),
              //search bar
              buildSearchBar(context),
              //list of product categories
              buildProductCategories(context),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedSwitcher drawerIcon() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: IconButton(
        onPressed: _handleMenuButtonPressed,
        icon: ValueListenableBuilder<AdvancedDrawerValue>(
          valueListenable: _advancedDrawerController,
          builder: (_, value, __) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: Icon(
                value.visible ? Icons.clear : Icons.menu,
                color: Colors.white,
                key: ValueKey<bool>(value.visible),
              ),
            );
          },
        ),
      ),
    );
  }

  buildSearchBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          // BoxShadow(
          //   color: Colors.black12,
          //   blurRadius: 16,
          //   offset: Offset(0, 8),
          // ),
        ],
      ),
      child: Row(
        children: const [
          Icon(Icons.search),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: false,
                hintText: 'Search for any product',
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildProductCategories(BuildContext context) {
    //horizontal list of categories in action chips

    return Wrap(
      runAlignment: WrapAlignment.start,
      spacing: 8,
      children: [
        //show first 6 categories
        for (int i = 0;
            i < (productCategories!.length < 6 ? productCategories!.length : 6);
            i++)
          ActionChip(
              backgroundColor: Colors.white,
              label: Text(productCategories![i].name ?? ''),
              // avatar: productCategories.entries.elementAt(i).value,
              elevation: 2,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductCategory(category: productCategories![i]),
                  ),
                );
              }),
      ],
    );
  }

  buildOffers(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return offerTile(storeDetails.banner!.elementAt(index));
        },
        itemCount: storeDetails.banner!.length,
        autoplay: true,
        autoplayDelay: 4000,
        pagination: const SwiperPagination(),
      ),
    );
  }

  offerTile(String url) {
    return OfferTile(
      context: context,
      url: url,
    );
  }

  buildTopPicks(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top picks', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 16),
          //horizontal list of products
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularProductList.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                  product: popularProductList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  buildLatestProducts(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Latest Products', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 16),
          //horizontal list of products
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: latestProductList.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(product: latestProductList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  buildProductCategoriesLargeCardsView(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Product Categories',
                  style: Theme.of(context).textTheme.headline6),
            ],
          ),
        ),
        Wrap(
          spacing: 16,
          children: [
            for (var value in productCategories!)
              buildProductCategoriesLargeCard(context, value)
          ],
        ),
      ],
    );
  }

  Widget buildProductCategoriesLargeCard(
      BuildContext context, Categories category) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductCategory(category: category),
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: AspectRatio(
          aspectRatio: 3 / 2,
          child: Card(
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  //image

                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://images.unsplash.com/photo-1582974114209-b508ec603c6e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=865&q=80",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      fadeInDuration: const Duration(milliseconds: 500),
                      placeholderFadeInDuration:
                          const Duration(milliseconds: 500),
                    ),
                  ),

                  //gradient
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //text
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        category.name ?? '',
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  List<ProductModel> getLatestProducts() {
    //sort by descending order of id
    return productList.reversed.toList().sublist(
        0,
        productList.length -
            (productList.length ~/ 2)); //get first half of products
  }

  //top orders by order count
  List<ProductModel> getTopOrders() {
    List<ProductModel> topOrders = productList.toList();
    //sort by order count
    topOrders.sort((a, b) => b.orderCount!.compareTo(a.orderCount!));
    return topOrders.sublist(0, 5);
  }

  buildStoreLogo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: Material(
            borderRadius: BorderRadius.circular(16),
            color: FlexColor.redWineDarkPrimaryContainer,
            child: Stack(
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/splashScreen.png',
                    fit: BoxFit.cover,
                    // width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                ),
                Positioned(
                  bottom: 8,
                  child: Center(
                    child: Text(
                      'Happy Shopping!',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
