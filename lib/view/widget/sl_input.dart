import 'package:bussiness_management/constants.dart';
import 'package:flutter/material.dart';

class SLInput extends StatelessWidget {
  String title, hint;
  TextInputType keyboardType;
  TextEditingController controller;
  Color inputColor;
  Color? otherColor;
  bool isObscure;
  void Function(String val)? onChanged;
  String? Function(String? val)? validation;
  bool isOutlined;
  IconData? sufixIcon;
  void Function()? onTap;
  bool? readOnly;
  double? width;
  double? margin;
  FocusNode? focusNode;
  SLInput(
      {Key? key,
      this.isOutlined = false,
      this.inputColor = const Color(0xff898989),
      this.isObscure = false,
      this.readOnly,
      this.otherColor,
      this.validation,
      this.sufixIcon,
      this.onTap,
      this.width,
      this.margin,
      this.focusNode,
      this.onChanged,
      required this.title,
      required this.hint,
      required this.keyboardType,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin == null
          ? EdgeInsets.symmetric(horizontal: isOutlined ? 23 : 45)
          : EdgeInsets.symmetric(horizontal: margin!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              title,
              style: TextStyle(color: otherColor ?? inputColor),
            ),
          ),
          SizedBox(
            height: isOutlined ? 10 : 0,
          ),
          TextFormField(
            focusNode: focusNode,
            maxLines: keyboardType == TextInputType.multiline ? 5 : null,
            readOnly: readOnly ?? false,
            onTap: onTap,
            onChanged: onChanged,
            validator: validation ??
                (value) {
                  if (value!.isEmpty) {
                    return "This Field is required.";
                  }
                  return null;
                },
            obscureText: isObscure,
            style: TextStyle(color: inputColor),
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
                enabledBorder: isOutlined
                    ? OutlineInputBorder(
                        borderSide: BorderSide(color: otherColor ?? inputColor),
                      )
                    : UnderlineInputBorder(
                        borderSide: BorderSide(color: otherColor ?? inputColor),
                      ),
                focusedBorder: isOutlined
                    ? OutlineInputBorder(
                        borderSide: BorderSide(color: whiteColor),
                      )
                    : UnderlineInputBorder(
                        borderSide: BorderSide(color: whiteColor),
                      ),
                // hoverColor: textColor,
                suffixIcon: sufixIcon != null ? Icon(sufixIcon) : null,
                hintText: hint,
                // hintStyle: TextStyle(color: inputColor),
                contentPadding: const EdgeInsets.all(18)),
          )
        ],
      ),
    );
  }
}
