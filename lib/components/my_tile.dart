import 'package:fitnestx_flutter/helper/constants.dart';
import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  final String imgName, text;
  final void Function()? onTap;
  const MyTile({
    super.key,
    required this.imgName,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 25.0,
        ),
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width / 2.0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade200,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imgName,
                height: 100,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                text,
                style: blackBold16px,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
