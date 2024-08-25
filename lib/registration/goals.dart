import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitnestx_flutter/auth/crud_firebase.dart';
import 'package:fitnestx_flutter/components/button.dart';
import 'package:fitnestx_flutter/components/image_with_text.dart';
import 'package:fitnestx_flutter/helper/constants.dart';
import 'package:fitnestx_flutter/models/onboarding/onboarding.dart';
import 'package:flutter/material.dart';

class Goals extends StatefulWidget {
  const Goals({super.key});

  @override
  State<Goals> createState() => _GoalsState();
}

String pageIndex = "Improve Shape";

class _GoalsState extends State<Goals> {
  @override
  Widget build(BuildContext context) {
    final List<Onboarding> onboarding = [
      Onboarding(
          imageName: "assets/onboarding/weights.svg",
          title: "Improve Shape",
          subtitle:
              "I have a low amount of body fat and need / want to build more muscle"),
      Onboarding(
          imageName: "assets/onboarding/rope.svg",
          title: "Lean & Tone",
          subtitle:
              "I’m “skinny fat”. look thin but have no shape. I want to add learn muscle in the right way"),
      Onboarding(
          imageName: "assets/onboarding/run.svg",
          title: "Lose Fat",
          subtitle:
              "I have over 20 lbs to lose. I want to drop all this fat and gain muscle mass"),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'What is your goal?',
                  style: blackBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'It will help us to choose a best\n program for you',
                  style: greyFont,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    pageIndex = onboarding[index].title;
                  });
                },
                height: MediaQuery.of(context).size.height / 1.5,
                enlargeCenterPage: true,
              ),
              items: onboarding.map((onboarding) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: blueGradient,
                        /*boxShadow: const [
                          BoxShadow(
                              color: Colors.black45,
                              blurRadius: 12.0,
                              spreadRadius: 1.0,
                              offset: Offset(
                                0,
                                10,
                              )),
                        ],*/
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: ImageWithText(
                          imageName: onboarding.imageName,
                          title: onboarding.title,
                          subtitle: onboarding.subtitle,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Button(
              btnText: "Confirm",
              onTap: () {
                Map<Object, Object?> obj = {
                  "goal": pageIndex,
                };
                updateUserDocument(obj, context, '/welcome');
                //createUserDocument();
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
