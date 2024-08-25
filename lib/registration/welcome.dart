import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnestx_flutter/components/button.dart';
import 'package:fitnestx_flutter/helper/constants.dart';
import 'package:fitnestx_flutter/helper/heper_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

String name = "";

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    nameCalc();
  }

  Future<void> nameCalc() async {
    showLoading();
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
        });
      }
      setState(() {
        name = nm;
      });
    } catch (e) {
      dismissLoading();
    }
    dismissLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    SvgPicture.asset("assets/onboarding/group.svg"),
                    const SizedBox(height: 40),
                    Text(
                      'Welcome, $name',
                      style: blackBold,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'You are all set now, let’s reach your goals together with us',
                      style: font16pxLightBlack,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Button(
                  btnText: 'Go to Home',
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
