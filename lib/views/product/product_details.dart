//product details page
// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:shopeasy_client/global/constants.dart';
import 'package:shopeasy_client/global/models/cart_model.dart';

import 'package:shopeasy_client/views/checkout/cart_page.dart';

import '../../global/models/product_model.dart';
import '../../global/models/variant_model.dart';
import '../../global/style.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({
    Key? key,
    required this.product,
    required this.variantModel,
  }) : super(key: key);
  ProductModel product;
  VariantModel variantModel;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _isInCart = false;
  // bool _isInWishlist = false;
  late VariantDetails selectedVariant =
      widget.variantModel.variantDetails!.first;
  late String? currentPrice = selectedVariant.price;
  late String? currentComparePrice = selectedVariant.compPrice;
  //total stock of selected variant

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          //amazon like product details page
          buildProductImages(context),

          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildProductName(),
                  const SizedBox(
                    height: 8,
                  ),
                  //product status chip
                  buildPrice(),
                ],
              ),
              //add to cart button
              buildAddToCartButton(context)
            ],
          ),
          //variants
          const SizedBox(
            height: 16,
          ),
          widget.product.hasOptions == null
              ? Container()
              : widget.product.hasOptions!
                  ? buildVariants(context)
                  : Container(),
          //material box
          const SizedBox(
            height: 16,
          ),
          descriptionBox(context),
        ],
      ),
    );
  }

  Text buildProductName() {
    return Text(
      widget.product.title ?? '',
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  SizedBox buildProductImages(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Hero(
        tag: widget.product.id ?? '',
        child: Swiper.children(
          loop: true,
          autoplay: true,
          autoplayDelay: 5000,
          autoplayDisableOnInteraction: false,
          // viewportFraction: 0.9,
          // outer: true,
          scale: 0.75,
          pagination: const SwiperPagination(),
          children: List.generate(widget.product.media!.length, (index) {
            return CachedNetworkImage(
              imageUrl: widget.product.media![index],
              fit: BoxFit.contain,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          }),
        ),
      ),
    );
  }

  Material descriptionBox(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Styles.getGrey(context),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.product.description ?? '',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildPrice() {
    return Row(
      children: [
        //actual price
        Text(
          '\u20B9${currentComparePrice ?? ''}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          //price in rupees symbol
          '\u20B9 ${currentPrice ?? ''}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  ElevatedButton buildAddToCartButton(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          primary: FlexColor.redWineDarkPrimaryContainer,
          onPrimary: Colors.white,
          textStyle: Theme.of(context).textTheme.button!),
      label:
          _isInCart ? const Text('Added to Cart') : const Text('Add to Cart'),
      icon: _isInCart
          ? const Icon(Icons.check)
          : const Icon(Icons.add_shopping_cart),
      onPressed: () {
        setState(() {
          _isInCart = true;
          CartModel cartModel = CartModel(
            media: widget.product.media!.first,
            name: widget.product.title,
            price: int.parse(currentPrice ?? ''),
            rating: widget.product.rating,
            qty: 1,
            variant: selectedVariant.variantName,
            prodid: widget.product.id,
          );

          //if item is not in cart, add it to cart
          if (cartList
              .where((element) => element.prodid == widget.product.id)
              .isEmpty) {
            cartList.add(cartModel);
          }
          // if (productCartList.contains(widget.product)) {
          //   return;
          // }
          // productCartList.add(widget.product);
          // variantCartList.add(selectedVariant);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Added to Cart'),
            action: SnackBarAction(
              label: 'View Cart',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartPage()));
              },
            ),
          ),
        );
      },
    );
  }

  buildVariants(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < (widget.product.options?.length ?? 0); i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.product.options![i].optionName ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: DropdownButton<VariantDetails>(
                  value: selectedVariant,
                  onChanged: (VariantDetails? variant) {
                    setState(() {
                      // selectedVariant = variant ?? VariantDetails();
                      // currentPrice = variant?.price ?? ' ';
                      // currentComparePrice = variant?.compPrice;
                    });
                  },
                  items: widget.variantModel.variantDetails!
                      .map((VariantDetails variant) {
                    return DropdownMenuItem<VariantDetails>(
                      value: variant,
                      child: Text(
                        variant.variantName ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.variantModel.variantDetails!.map((variant) {
            return buildVariantChip(context, variant);
          }).toList(),
        ),
      ],
    );
  }

  Widget buildVariantChip(BuildContext context, VariantDetails variant) {
    return ActionChip(
      label: Text(variant.variantName ?? ''),
      backgroundColor: Colors.white,
      elevation: variant.variantName == selectedVariant.variantName ? 0 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
        side: BorderSide(
          //if variant is selected, change border color to primary color
          color: variant.variantName == selectedVariant.variantName
              ? FlexColor.redWineDarkPrimaryContainer
              : Colors.grey.shade100,

          // width: 1,
        ),
      ),
      onPressed: () {
        setState(() {
          selectedVariant = variant;
          currentPrice = variant.price ?? '';
          currentComparePrice = variant.compPrice ?? '';
        });
      },
    );
  }
}
