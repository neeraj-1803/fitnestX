import 'package:fitnestx_flutter/helper/constants.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String btnText;
  final void Function()? onTap;
  final icon;
  const Button({
    super.key,
    required this.btnText,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.3,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: blueGradient,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            btnText,
            style: whiteBold,
          ),
          if (icon != null) icon
        ]),
      ),
    );
  }
}
