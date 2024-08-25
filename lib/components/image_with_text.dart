import 'package:fitnestx_flutter/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageWithText extends StatelessWidget {
  final String imageName, title, subtitle;
  const ImageWithText({
    super.key,
    required this.imageName,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(imageName),
        const SizedBox(height: 30),
        Text(
          title,
          style: whiteBold,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
            width: 50,
            child: Divider(
              color:
                  whiteColor, //make the style dynamic and then use it in welcome.dart
            )),
        Text(
          subtitle,
          style: whiteBold,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
