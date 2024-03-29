import 'dart:io';

import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/data/model/product_model.dart';
import 'package:bussiness_management/view/Pages/add_product.dart';
import 'package:bussiness_management/view/Pages/products_gallery.dart';
import 'package:bussiness_management/view/Pages/search_page.dart';
import 'package:bussiness_management/view/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ProductCard extends StatefulWidget {
  final ProductModel productModel;
  final void Function() onClickImage;
  const ProductCard(
      {super.key, required this.productModel, required this.onClickImage});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  File? file;
  
  MainConntroller mainConntroller = Get.find<MainConntroller>();
  @override
  void initState() {
    super.initState();
    setImageFile();
  }

  setImageFile() async {
    file = await displayImage(widget.productModel.images[0],
        '${widget.productModel.sku}0', FirebaseConstants.products);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
      child: InkWell(
        onTap: () {
          Get.to(
            () => AddProduct(
              productModel: widget.productModel,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: mainBgColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withAlpha(150),
                  blurRadius: 5,
                  offset: const Offset(-5, 5))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: file == null
                            ? SizedBox(
                                height: 110,
                                width: 110,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                ),
                              )
                            : file!.path == ""
                                ? Container(
                                    height: 110,
                                    width: 110,
                                    color: mainBgColor,
                                    child: const Center(
                                      child: Text("No Network"),
                                    ),
                                  )
                                : InkWell(
                                    onTap: widget.onClickImage,
                                    child: Ink(
                                      child: Image.file(
                                        file!,
                                        width: 110,
                                        height: 110,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                      ),
                      widget.productModel.images.length != 1
                          ? Positioned(
                              bottom: 0,
                              right: 0,
                              child: Card(
                                color: primaryColor,
                                shape: const CircleBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "+${widget.productModel.images.length - 1}"),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productModel.name,
                        style: const TextStyle(fontSize: 22),
                        overflow: TextOverflow.ellipsis,

                      ),
                      Text(
                        '${widget.productModel.price} Br',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: primaryColor),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.productModel.sku,
                        style: TextStyle(fontSize: 20, color: textColor),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.productModel.description,
                style: const TextStyle(fontSize: 17,),
                overflow: TextOverflow.clip,
                
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(
                  widget.productModel.tags.length,
                  (index) => GestureDetector(
                    onTap: () {
                      mainConntroller.searchProducts("name", "#${widget.productModel.tags[index]}", 5);
                      Get.to(() => SearchPage(
                            path: FirebaseConstants.products,
                            tag: "#${widget.productModel.tags[index]}",
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "#${widget.productModel.tags[index]} ",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 125, 196, 255)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
