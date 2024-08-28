import 'package:fitnestx_flutter/helper/constants.dart';
import 'package:flutter/material.dart';

class ListTiles extends StatelessWidget {
  final String text;
  // final void Function()? onTap;
  const ListTiles({
    super.key,
    required this.text,
    // required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.2,
      height: 50,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(157, 206, 255, 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: font16pxLightBlack,
        ),
      ),
    );
  }
}
