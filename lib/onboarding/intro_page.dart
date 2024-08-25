import 'package:fitnestx_flutter/helper/constants.dart';
import 'package:fitnestx_flutter/models/onboarding/onboarding.dart';
import 'package:fitnestx_flutter/models/onboarding/onboarding_tile.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

double percentage = 0.25;

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    // final double deviceWidth = MediaQuery.of(context).size.width;
    // final double deviceHeight = MediaQuery.of(context).size.height;
    final List<Onboarding> onboarding = [
      Onboarding(
        imageName: 'assets/onboarding/track.svg',
        title: 'Track Your Goal',
        subtitle:
            "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals",
      ),
      Onboarding(
        imageName: 'assets/onboarding/burn.svg',
        title: 'Get Burn',
        subtitle:
            "Let’s keep burning, to achive yours goals, it hurts only temporarily, if you give up now you will be in pain forever",
      ),
      Onboarding(
        imageName: 'assets/onboarding/eat.svg',
        title: 'Eat Well',
        subtitle:
            "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun",
      ),
      Onboarding(
        imageName: 'assets/onboarding/sleep.svg',
        title: 'Improve Sleep Quality',
        subtitle:
            "Improve the quality of your sleep with us, good quality sleep can bring a good mood in the morning",
      ),
    ];

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: onboarding.length,
              onPageChanged: (value) => setState(() {
                percentage = (value + 1) * 0.25;
              }),
              itemBuilder: (context, index) {
                return OnboardingTile(
                  imageName: onboarding[index].imageName,
                  title: onboarding[index].title,
                  subtitle: onboarding[index].subtitle,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/userregistration');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(seconds: 25),
            builder: (context, value, _) => CircularPercentIndicator(
              radius: 42,
              lineWidth: 2.0,
              center: Container(
                padding: const EdgeInsets.all(20),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  gradient: blueGradient,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
              percent: percentage,
              backgroundColor: whiteColor,
              progressColor: blueColor,
              animation: true,
            ),
          ),
        ),
      ),
    );
  }
}
