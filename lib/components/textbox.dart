import 'package:fitnestx_flutter/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Textbox extends StatelessWidget {
  final String hintText;
  final enable;
  final suffixIcon;
  final Widget icon;
  final minLen;
  final TextEditingController controller;
  final String? validator;
  final bool? isPassword;
  const Textbox({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.suffixIcon,
    this.enable,
    this.validator,
    this.isPassword,
    this.minLen,
  });

  @override
  Widget build(BuildContext context) {
    int validate(String? address, String patttern) {
      final regExp = RegExp(patttern);
      if (address!.isEmpty || address.isEmpty) {
        return 1;
      } else if (address.length < minLen) {
        return 3;
      } else if (!regExp.hasMatch(address)) {
        return 4;
      } else {
        return 0;
      }
    }

    int validatePassword(String? address, String patttern) {
      final regExp = RegExp(patttern);
      if (address == null || address.isEmpty) {
        return 1;
      } else if (!address.contains(RegExp(r'[A-Z]'))) {
        return 2;
      } else if (!address.contains(RegExp(r'[a-z]'))) {
        return 3;
      } else if (!regExp.hasMatch(address)) {
        return 4;
      } else if (!address.contains(RegExp(r'[0-9]'))) {
        return 5;
      } else if (address.length < minLen) {
        return 6;
      } else {
        return 0;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        autovalidateMode: validator == null
            ? AutovalidateMode.disabled
            : AutovalidateMode.onUserInteraction,
        validator: validator == null
            ? null
            : (value) {
                if (isPassword != null) {
                  int res = validatePassword(value!, validator!);
                  if (res == 1) {
                    return "Please enter some data";
                  } else if (res == 6) {
                    return "Please enter minimum $minLen characters";
                  } else if (res == 4) {
                    return "Please include a special character";
                  } else if (res == 2) {
                    return "Please include a uppercase character";
                  } else if (res == 3) {
                    return "Please include a lowercase character";
                  } else if (res == 5) {
                    return "Please include a numeric character";
                  } else {
                    return null;
                  }
                } else {
                  int res = validate(value!, validator!);
                  if (res == 1) {
                    return "Please enter some data";
                  } else if (res == 3) {
                    return "Please enter minimum $minLen characters";
                  } else if (res == 4) {
                    return "Please enter valid data";
                  } else {
                    return null;
                  }
                }
              },
        obscureText: (isPassword != null && isPassword!) ? true : false,
        enabled: enable,
        controller: controller,
        decoration: InputDecoration(
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 40, maxWidth: 40),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: icon,
          ),
          suffixIconConstraints:
              const BoxConstraints(maxHeight: 40, maxWidth: 40),
          suffixIcon: (suffixIcon != null)
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SvgPicture.asset(
                    suffixIcon,
                    color: Colors.grey,
                  ),
                )
              : null,
          filled: true,
          fillColor: Colors.grey.shade100, //grayColor,
          hintText: hintText,
          hintStyle: greyFont,
          border: InputBorder.none,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
          ),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(
                width: 1,
                color: Colors.red,
              )),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
