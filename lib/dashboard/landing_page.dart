import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnestx_flutter/auth/auth_service.dart';
import 'package:fitnestx_flutter/auth/crud_firebase.dart';
import 'package:fitnestx_flutter/components/button.dart';
import 'package:fitnestx_flutter/components/my_tile.dart';
import 'package:fitnestx_flutter/components/textbox.dart';
import 'package:fitnestx_flutter/helper/constants.dart';
import 'package:fitnestx_flutter/helper/heper_methods.dart';
import 'package:fitnestx_flutter/models/dashboard/workout.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

String weightTxt = "";
String name = "User";
final dio = Dio();

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    bmiCalculator();
  }

  final String exerciseBodyPart =
      'https://exercisedb.p.rapidapi.com/exercises/bodyPart/';
  final String exerciseEquiptments =
      'https://exercisedb.p.rapidapi.com/exercises/equipment/';

  void serviceCall(String target, String limit, String url) async {
    showLoading();
    try {
      Response response = await dio.get(
        url + target,
        queryParameters: {'limit': limit, 'offset': '0'},
        options: Options(
          contentType: "application/json",
          responseType: ResponseType.plain,
          headers: {
            "Accept": "application/json",
            "x-rapidapi-ua": "RapidAPI-Playground",
            "x-rapidapi-key":
                "5b4b3c86eamsh684492759978cbdp17a1cbjsncef2e9a810c1",
            "x-rapidapi-host": "exercisedb.p.rapidapi.com",
          },
        ),
      );
      final List<dynamic> dataList = jsonDecode(response.toString());
      if (context.mounted) {
        Navigator.of(context).pushNamed("/exercisepage", arguments: dataList);
      }
    } on DioException {
      dismissLoading();
    }
    dismissLoading();
  }

  final List<Workout> exercise = [
    Workout(
      imgName: "assets/exercises/chest_workout.jpg",
      text: "Chest",
      bodyPart: "chest",
      limit: 100,
    ),
    Workout(
      imgName: "assets/exercises/legs_workout.jpg",
      text: "Legs",
      bodyPart: "upper legs",
      limit: 100,
    ),
    Workout(
      imgName: "assets/exercises/bicep_workout.jpg",
      text: "Arms",
      bodyPart: "upper arms",
      limit: 100,
    ),
    Workout(
      imgName: "assets/exercises/abs_workout.jpg",
      text: "Abs",
      bodyPart: "waist",
      limit: 100,
    ),
    Workout(
      imgName: "assets/exercises/tricep_workout.jpg",
      text: "Triceps",
      bodyPart: "lower arms",
      limit: 37,
    ),
    Workout(
      imgName: "assets/exercises/shoulder_workout.jpg",
      text: "Shoulder",
      bodyPart: "shoulders",
      limit: 100,
    ),
    Workout(
      imgName: "assets/exercises/back_exercise.jpg",
      text: "Back",
      bodyPart: "back",
      limit: 100,
    ),
    Workout(
      imgName: "assets/exercises/cardio.jpg",
      text: "Cardio/Fat Burn",
      bodyPart: "cardio",
      limit: 29,
    ),
  ];

  final List<Workout> equipments = [
    Workout(
      imgName: "assets/exercises/barbell.jpg",
      text: "Barbell",
      bodyPart: "barbell",
      limit: 100,
    ),
    Workout(
      imgName: "assets/exercises/dumbell.jpg",
      text: "Dumbbell",
      bodyPart: "dumbbell",
      limit: 100,
    ),
    Workout(
      imgName: "assets/exercises/kettlebell.jpg",
      text: "Kettle Bell",
      bodyPart: "kettlebell",
      limit: 41,
    ),
    Workout(
      imgName: "assets/exercises/smith_machine.jpg",
      text: "Smith Machine",
      bodyPart: "smith machine",
      limit: 48,
    ),
    Workout(
      imgName: "assets/exercises/band.jpg",
      text: "Resistance Band",
      bodyPart: "resistance band",
      limit: 7,
    ),
    Workout(
      imgName: "assets/exercises/trap_bar.jpg",
      text: "Trap Bar",
      bodyPart: "trap bar",
      limit: 1,
    ),
    Workout(
      imgName: "assets/exercises/bike.jpg",
      text: "Bike",
      bodyPart: "stationary bike",
      limit: 1,
    ),
    Workout(
      imgName: "assets/exercises/stability_ball.jpg",
      text: "Ball",
      bodyPart: "stability ball",
      limit: 28,
    ),
    Workout(
      imgName: "assets/exercises/elliptical.jpg",
      text: "Elliptical",
      bodyPart: "elliptical machine",
      limit: 1,
    ),
    Workout(
      imgName: "assets/exercises/body_weight.jpg",
      text: "Body Weight",
      bodyPart: "body weight",
      limit: 29,
    ),
  ];

  Future<void> bmiCalculator() async {
    showLoading();
    String txt = "";
    String nm = "";
    try {
      User? userCredential = FirebaseAuth.instance.currentUser;
      if (userCredential != null && userCredential.email != null) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.email)
            .get()
            .then((doc) {
          nm = doc.get("name").toString();
          double weight = double.parse(doc.get("weight"));
          double height = double.parse(doc.get("height")) / 100 * 2;
          double bmi = double.parse((weight / height).toStringAsFixed(1));
          if (bmi <= 18.4) {
            txt = "You are underweight";
          } else if (bmi > 18.4 && bmi <= 24.9) {
            txt = "You are normal weight";
          } else if (bmi > 24.9 && bmi <= 39.9) {
            txt = "You are over weight";
          } else {
            txt = "You are obese";
          }
        });
      }
      setState(() {
        weightTxt = txt;
        name = nm;
      });
    } catch (e) {
      print("Error --$e");
      dismissLoading();
    }
    dismissLoading();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Back,',
                                style: font16pxLightBlack,
                              ),
                              Text(
                                name,
                                style: blackBold,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await AuthService().logOut();
                                Navigator.of(context)
                                    .pushNamed('/registration');
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 0.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.2, color: grayColorFade),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  width: 54,
                                  height: 54,
                                  child: const Icon(FontAwesomeIcons.signOut),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await AuthService().logOut();
                                Navigator.of(context).pushNamed('/savedpage');
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.2, color: grayColorFade),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  width: 54,
                                  height: 54,
                                  child: const Icon(FontAwesomeIcons.save),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: const DecorationImage(
                          image: AssetImage('assets/dashboard/background.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'BMI (Body Mass Index)',
                                  style: whiteBold,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  weightTxt,
                                  style: whiteFont,
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (context) => Center(
                                      child: Container(
                                        margin: const EdgeInsets.all(25),
                                        padding: const EdgeInsets.all(25.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Textbox(
                                              hintText: 'Your Weight..',
                                              icon: SvgPicture.asset(
                                                  'assets/icons/weight.svg'),
                                              controller: controller,
                                            ),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            Button(
                                              btnText: 'Update',
                                              onTap: () async {
                                                showLoading();
                                                await updateUserDocument(
                                                    {'weight': controller.text},
                                                    context,
                                                    null);
                                                await bmiCalculator();
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    width: 150,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      gradient: purpleGradient,
                                      color: secondaryPurple,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Update",
                                        style: whiteFont,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            Expanded(
                              child: PieChart(
                                PieChartData(
                                  centerSpaceRadius: 0,
                                  titleSunbeamLayout: true,
                                  sections: [
                                    PieChartSectionData(
                                      gradient: purpleGradient,
                                      value: 20,
                                      title: '20.1',
                                      radius: 70,
                                      titlePositionPercentageOffset: 0.7,
                                      borderSide: const BorderSide(
                                          color: Colors.transparent, width: 10),
                                      titleStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: Colors.white,
                                      value: 80,
                                      title: '',
                                      radius: 60,
                                      borderSide: const BorderSide(
                                          color: Colors.transparent, width: 10),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(157, 206, 255, 0.5),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Today\'s Target',
                                style: font16pxLightBlack,
                              ),
                              Container(
                                width: 120,
                                height: 35,
                                decoration: BoxDecoration(
                                  gradient: blueGradient,
                                  color: blueColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    "Check",
                                    style: whiteFont,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 25.0,
                      ),
                      child: Text(
                        'Exercises(Body Parts)',
                        style: blackBold16px,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height:
                          (Platform.operatingSystem == "android") ? 800 : 870,
                      child: GridView.builder(
                        primary: false,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: exercise.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: MyTile(
                              imgName: exercise[index].imgName,
                              text: exercise[index].text,
                              onTap: () => serviceCall(
                                exercise[index].bodyPart,
                                exercise[index].limit.toString(),
                                exerciseBodyPart,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 25.0,
                        left: 25.0,
                        right: 25.0,
                      ),
                      child: Text(
                        'Exercises(Equipment List)',
                        style: blackBold16px,
                      ),
                    ),
                    SizedBox(
                      height:
                          (Platform.operatingSystem == "android") ? 1000 : 1100,
                      child: GridView.builder(
                        primary: false,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: equipments.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: MyTile(
                              imgName: equipments[index].imgName,
                              text: equipments[index].text,
                              onTap: () => serviceCall(
                                equipments[index].bodyPart,
                                equipments[index].limit.toString(),
                                exerciseEquiptments,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
