import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/view/Pages/search_page.dart';
import 'package:bussiness_management/view/controller/main_controller.dart';
import 'package:bussiness_management/view/widget/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductTab extends StatefulWidget {
  const ProductTab({super.key});

  @override
  State<ProductTab> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab>
    with AutomaticKeepAliveClientMixin<ProductTab> {
  MainConntroller mainConntroller = Get.find<MainConntroller>();

  // List<ProductCategoryModel> categories = [];

  RequestState categoryStatus = RequestState.idle;

  @override
  void initState() {
    super.initState();
    // calculateQuantity();
  }

  // calculateQuantity() async {
  //   categoryStatus = RequestState.loading;
  //   categories = [];
  //   for (ProductCategoryModel categoryModel in ProductCategory.listWIcons) {
  //     int quantity = await mainConntroller.count(
  //         FirebaseConstants.products, 'category', categoryModel.name);
  //     categories.add(categoryModel.copyWith(quantity: quantity));
  //   }
  //   categoryStatus = RequestState.loaded;
  //   if(mounted){
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: title("Products"),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/menu icon.svg',
            color: whiteColor,
            height: 21,
          ),
          onPressed: () {
            mainConntroller.z.value.open!();
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              mainConntroller.getProducts(quantity: numOfDocToGet);
              Get.to(() => SearchPage(path: FirebaseConstants.products));
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () async {
              // calculateQuantity();
              setState(() {});
            },
            icon: const Icon(
              Icons.refresh_rounded,
            ),
          ),
        ],
      ),
      body: categoryStatus == RequestState.loading
          ? Center(
              child: CircularProgressIndicator(color: primaryColor),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: ProductCategory.listWIcons.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 13,
                  crossAxisCount: 2,
                  mainAxisSpacing: 13,
                  childAspectRatio: 1 / 1.05),
              itemBuilder: (context, index) {
                return CategoryCard(
                    productCategoryModel: ProductCategory.listWIcons[index]);
              },
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
