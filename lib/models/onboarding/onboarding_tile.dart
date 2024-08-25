import 'package:fitnestx_flutter/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingTile extends StatelessWidget {
  final String imageName, title, subtitle;

  const OnboardingTile({
    super.key,
    required this.imageName,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      color: whiteColor,
      child: Column(
        children: [
          Center(
            child: SizedBox(
              height: deviceHeight / 2,
              width: deviceWidth,
              child: SvgPicture.asset(
                imageName,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: blackBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  subtitle,
                  style: greyReg,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
