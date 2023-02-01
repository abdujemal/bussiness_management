import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/data/model/user_model.dart';
import 'package:bussiness_management/view/controller/main_controller.dart';
import 'package:bussiness_management/view/widget/custom_btn.dart';
import 'package:bussiness_management/view/widget/my_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateUserDialog extends StatefulWidget {
  final UserModel userModel;
  const UpdateUserDialog({super.key, required this.userModel});

  @override
  State<UpdateUserDialog> createState() => _UpdateUserDialogState();
}

class _UpdateUserDialogState extends State<UpdateUserDialog> {
  var selectedPriority = UserPriority.Shopkeeper;

  MainConntroller mainConntroller = Get.find<MainConntroller>();

  @override
  void initState() {
    super.initState();
    selectedPriority = widget.userModel.priority;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: mainBgColor,
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(20),
          left: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(child: title(widget.userModel.name)),
          const SizedBox(
            height: 15,
          ),
          MyDropdown(
            value: selectedPriority,
            list: UserPriority.list,
            title: "Priority",
            onChange: (val) {
              setState(() {
                selectedPriority = val!;
              });
            },
            width: double.infinity,
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: CustomBtn(
              btnState: Btn.filled,
              color: primaryColor,
              text: "Save",
              onTap: () {
                mainConntroller.updateUser(
                  widget.userModel.copyWith(
                    priority: selectedPriority,
                  ),
                );
                Get.back();
              },
            ),
          )
        ],
      ),
    );
  }
}
