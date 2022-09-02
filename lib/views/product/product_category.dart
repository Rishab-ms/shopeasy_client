//page to display all products in a category

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopeasy_client/global/constants.dart';
import 'package:shopeasy_client/global/models/store_model.dart';
import 'package:shopeasy_client/global/models/variant_model.dart';
import 'package:shopeasy_client/views/product/product_details.dart';

import '../../global/models/product_model.dart';

class ProductCategory extends StatefulWidget {
  ProductCategory({Key? key, required this.category, this.subCategoryPage})
      : super(key: key);
  final Categories category;
  bool? subCategoryPage = false;

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  final List<ProductModel> productsInCategory = [];
  final List<VariantModel> variantsInCategory = [];
  var subCategoryList = [];

  @override
  void initState() {
    super.initState();
    //iterate through all products and add those that are in the category to the list
    for (ProductModel product in productList) {
      if (product.category![0] == widget.category.name) {
        productsInCategory.add(product);
      }
    }
    //if product is in the category, add the variant to the list where product id = variant id
    for (VariantModel variant in variantModelList) {
      for (ProductModel product in productsInCategory) {
        if (product.id == variant.id) {
          variantsInCategory.add(variant);
        }
      }
    }
    final Categories currentCategory = storeDetails.categories!
        .firstWhere((category) => category.name == widget.category.name);
    for (var subCategory in currentCategory.children!) {
      subCategoryList.add(subCategory);
    }
    print("subCategoryList length: ${subCategoryList.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category.name ?? ' '),
          //search bar
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: productsInCategory.isEmpty
            ? const Center(
                child: Text('No products in this category'),
              )
            : Column(
                children: [
                  //if category has subcategories, display them
                  if (subCategoryList.isNotEmpty)
                    SizedBox(
                      height: 75,
                      child: Row(children: [
                        ActionChip(label: Text('All'), onPressed: () {}
                        ),
                        ListView.builder(
                          itemCount: subCategoryList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: ActionChip(
                                label: Text(subCategoryList[index].name),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductCategory(
                                        category: subCategoryList[index],
                                        subCategoryPage: true,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ]),
                    ),
                  Expanded(child: allStaggeredGrid(productsInCategory)),
                ],
              ));
  }

  AnimationLimiter allStaggeredGrid(List<ProductModel> products) {
    return AnimationLimiter(
        child: MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: productsInCategory.length,
      itemBuilder: (context, index) {
        return
            //list of widgets to be animated
            AnimationConfiguration.staggeredGrid(
          position: 1,
          duration: const Duration(milliseconds: 375),
          columnCount: 2,
          child: ScaleAnimation(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetails(
                      variantModel: variantsInCategory[index],
                      product: productsInCategory[index],
                    ),
                  ),
                );
              },
              child: products[index].dynamicCard(),
            ),
          ),
        );
      },
    ));
  }
}
