import 'dart:io';

import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/data/model/item_model.dart';
import 'package:bussiness_management/view/controller/main_controller.dart';
import 'package:bussiness_management/view/widget/custom_btn.dart';
import 'package:bussiness_management/view/widget/my_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../widget/sl_input.dart';

class AddItem extends StatefulWidget {
  final ItemModel? itemModel;
  const AddItem({super.key, this.itemModel});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  var itemNameTc = TextEditingController();

  var selectedCategory = ItemCategory.Accessories;

  MainConntroller mainConntroller = Get.find<MainConntroller>();

  var selectedUnit = Units.Pcs;

  var pricePerUnitTc = TextEditingController();

  var itemDescriptionTc = TextEditingController();

  File? selectedImage;

  var itemFormState = GlobalKey<FormState>();

  var urlImage = "";

  File? imageFromUrl;

  @override
  void dispose() {
    itemNameTc.dispose();
    pricePerUnitTc.dispose();
    itemDescriptionTc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.itemModel != null) {
      itemNameTc.text = widget.itemModel!.name;
      selectedCategory = widget.itemModel!.category;
      selectedUnit = widget.itemModel!.unit;
      pricePerUnitTc.text = widget.itemModel!.pricePerUnit.toString();
      itemDescriptionTc.text = widget.itemModel!.description;
      urlImage = widget.itemModel!.image!;
      setImageFile();
    }
  }

  setImageFile() async {
    imageFromUrl = await displayImage(
        urlImage, widget.itemModel!.name, FirebaseConstants.items);
    if (mounted) {
      setState(() {});
    }
  }

  image() {
    if (selectedImage != null) {
      return Image.file(
        selectedImage!,
        height: 200,
        width: 200,
      );
    } else if (urlImage != "") {
      return imageFromUrl != null
          ? imageFromUrl!.path == ""
              ? Container(
                  color: mainBgColor,
                  height: 200,
                  width: 200,
                  child: const Center(child: Text("No Network")),
                )
              : Image.file(
                  imageFromUrl!,
                  height: 200,
                  width: 200,
                )
          : Container(
              color: mainBgColor,
              height: 200,
              width: 200,
              child: Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            );
    } else {
      return const Icon(Icons.image, size: 100);
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
        title: title(widget.itemModel != null ? "Item Detail" : "New Item"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            }),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: itemFormState,
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    XFile? xFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (xFile != null) {
                      setState(() {
                        selectedImage = File(xFile.path);
                      });
                    } else {
                      toast("No Image is selected.", ToastType.error);
                    }
                  },
                  child: Ink(child: image()),
                ),
                SLInput(
                  title: "Item Name",
                  hint: 'MDF',
                  inputColor: whiteColor,
                  otherColor: textColor,
                  keyboardType: TextInputType.text,
                  controller: itemNameTc,
                  isOutlined: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyDropdown(
                  value: selectedCategory,
                  list: ItemCategory.list,
                  title: "Category",
                  onChange: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyDropdown(
                  value: selectedUnit,
                  list: Units.list,
                  title: "Unit",
                  onChange: (value) {
                    setState(() {
                      selectedUnit = value!;
                    });
                  },
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 15,
                ),
                SLInput(
                  title: "Price per unit",
                  hint: '2000',
                  inputColor: whiteColor,
                  otherColor: textColor,
                  keyboardType: TextInputType.number,
                  controller: pricePerUnitTc,
                  isOutlined: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                SLInput(
                  title: "Description",
                  hint: 'add Description',
                  inputColor: whiteColor,
                  otherColor: textColor,
                  keyboardType: TextInputType.text,
                  controller: itemDescriptionTc,
                  isOutlined: true,
                ),
                const SizedBox(
                  height: 50,
                ),
                Obx(() {
                  return mainConntroller.itemStatus.value ==
                          RequestState.loading
                      ? CircularProgressIndicator(
                          color: primaryColor,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomBtn(
                              btnState: Btn.filled,
                              color: primaryColor,
                              onTap: () {
                                if (itemFormState.currentState!.validate()) {
                                  if (widget.itemModel != null) {
                                    if (selectedImage != null) {
                                      mainConntroller.updateItem(
                                        selectedImage!,
                                        ItemModel(
                                          id: widget.itemModel!.id,
                                          image: null,
                                          name: itemNameTc.text,
                                          category: selectedCategory,
                                          unit: selectedUnit,
                                          pricePerUnit:
                                              double.parse(pricePerUnitTc.text),
                                          description: itemDescriptionTc.text,
                                          quantity: 0,
                                          history: const [],
                                        ),
                                      );
                                    } else {
                                      mainConntroller.updateItem(
                                        null,
                                        ItemModel(
                                          id: widget.itemModel!.id,
                                          image: urlImage,
                                          name: itemNameTc.text,
                                          category: selectedCategory,
                                          unit: selectedUnit,
                                          pricePerUnit:
                                              double.parse(pricePerUnitTc.text),
                                          description: itemDescriptionTc.text,
                                          quantity: 0,
                                          history: const [],
                                        ),
                                      );
                                    }
                                  } else {
                                    mainConntroller.addItem(
                                      selectedImage!,
                                      ItemModel(
                                        id: null,
                                        image: null,
                                        name: itemNameTc.text,
                                        category: selectedCategory,
                                        unit: selectedUnit,
                                        pricePerUnit:
                                            double.parse(pricePerUnitTc.text),
                                        description: itemDescriptionTc.text,
                                        quantity: 0,
                                        history: const [],
                                      ),
                                    );
                                  }
                                }
                              },
                              text: "Save",
                            ),
                            widget.itemModel == null
                                ? const SizedBox()
                                : Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text("or"),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      CustomBtn(
                                          btnState: Btn.outlined,
                                          color: textColor,
                                          onTap: () {
                                            mainConntroller.delete(
                                                FirebaseConstants.items,
                                                widget.itemModel!.id!,
                                                widget.itemModel!.name,
                                                true,
                                                null);
                                          },
                                          text: "Delete")
                                    ],
                                  )
                          ],
                        );
                }),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
