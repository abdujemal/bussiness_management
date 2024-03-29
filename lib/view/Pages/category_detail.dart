import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/view/Pages/add_product.dart';
import 'package:bussiness_management/view/Pages/products_gallery.dart';
import 'package:bussiness_management/view/controller/main_controller.dart';
import 'package:bussiness_management/view/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetail extends StatefulWidget {
  final String categoryName;
  const CategoryDetail({required this.categoryName, super.key});

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  MainConntroller mainConntroller = Get.find<MainConntroller>();

  // List<ProductModel> products = [];

  ScrollController controller = ScrollController();

  int pageNum = 2;

  @override
  void initState() {
    super.initState();
    controller.addListener(handleScrolling);
    mainConntroller.getProducts(category: widget.categoryName, quantity: numOfDocToGet);
  }

  void handleScrolling() {
    if (controller.offset >= controller.position.maxScrollExtent) {
      if (mainConntroller.getProductsStatus.value != RequestState.loading) {
        mainConntroller.getProducts(
          quantity: numOfDocToGet,
          category: widget.categoryName,
          isNew: false,
        );
        pageNum = pageNum + 1;
        print("${mainConntroller.products.length} products");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: title(widget.categoryName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => AddProduct(
                  category: widget.categoryName,
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              mainConntroller.getProducts(
                  category: widget.categoryName, quantity: numOfDocToGet);
            },
            icon: const Icon(
              Icons.refresh_rounded,
              size: 30,
            ),
          )
        ],
      ),
      body: Obx(() {
        if (mainConntroller.products.isEmpty &&
            mainConntroller.getProductsStatus.value != RequestState.loading) {
          return Center(
            child: Text("No Products in ${widget.categoryName}."),
          );
        }
        if (mainConntroller.products.isEmpty &&
            mainConntroller.getProductsStatus.value == RequestState.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: controller,
                  itemCount: mainConntroller.products.length,
                  // physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      onClickImage: () {
                        Get.to(
                          () => ProductGallery(
                            products: mainConntroller.products,
                            selectedSku: mainConntroller.products[index].sku,
                          ),
                        );
                      },
                      productModel: mainConntroller.products[index],
                    );
                  }),
            ),
            mainConntroller.getProductsStatus.value == RequestState.loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )
                : SizedBox(),
          ],
        );
      }),
    );
  }
}
