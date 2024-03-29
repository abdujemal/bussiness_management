import 'dart:io';

import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/data/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductGallery extends StatefulWidget {
  final List<ProductModel> products;
  final String? selectedSku;
  const ProductGallery({
    super.key,
    required this.products,
    required this.selectedSku,
  });

  @override
  State<ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery> {
  List<Map<String, Object?>> images = [];

  Map<String, Object?>? currentImage;

  @override
  void initState() {
    super.initState();
    if (widget.products.isNotEmpty) {
      for (ProductModel model in widget.products) {
        int i = 0;
        for (String url in model.images) {
          images.add({
            "url": url,
            'sku': "${model.sku}$i",
            'name': model.name,
            'price': model.price,
            'file': null,
          });
          i++;
        }
      }
    } else {}

    if (widget.selectedSku != null) {
      currentImage = images.where(
        (element) {
          return element["sku"].toString().contains(widget.selectedSku!);
        },
      ).toList()[0];
    } else {}

    setImageFile();
  }

  setImageFile() async {
    int i = 0;
    for (var image in images) {
      File? file = await displayImage(
        image["url"].toString(),
        image["sku"].toString(),
        FirebaseConstants.products,
      );
      images[i]['file'] = file;
      if (mounted) {
        setState(() {});
      }
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: PageView.builder(
        controller: PageController(initialPage: images.indexOf(currentImage!)),
        physics: const BouncingScrollPhysics(),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: title(images[index]['name'].toString()),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              actions: [
                RotatedBox(
                  quarterTurns: 2,
                  child: ClipPath(
                    clipper: BestSellerClipper(),
                    child: Container(
                      color: primaryColor,
                      padding: const EdgeInsets.only(
                          left: 10, top: 5, right: 20, bottom: 5),
                      child: Center(
                        child: RotatedBox(
                          quarterTurns: 2,
                          child: Text(
                            "${images[index]['price']} Br",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: images[index]['file'] != null
                  ? BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: FileImage(
                          images[index]['file'] as File,
                        ),
                      ),
                    )
                  : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  images[index]['file'] == null
                      ? CircularProgressIndicator(
                          color: primaryColor,
                        )
                      : (images[index]['file'] as File).path == ""
                          ? const Text("No Network.")
                          : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BestSellerClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();

    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 20, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
