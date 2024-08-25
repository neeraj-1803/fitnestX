import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnestx_flutter/auth/crud_firebase.dart';
import 'package:fitnestx_flutter/components/button.dart';
import 'package:fitnestx_flutter/components/textbox.dart';
import 'package:fitnestx_flutter/helper/constants.dart';
import 'package:fitnestx_flutter/helper/heper_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegistrationProfile extends StatefulWidget {
  const RegistrationProfile({super.key});

  @override
  State<RegistrationProfile> createState() => _RegistrationProfileState();
}

String gender = 'Choose a gender';
String dob = 'Date of Birth';

class _RegistrationProfileState extends State<RegistrationProfile> {
  @override
  Widget build(BuildContext context) {
    TextEditingController weightController = TextEditingController();
    TextEditingController heightController = TextEditingController();
    /*List genders = [
      {
        "gender": "Male",
        "icon": Icon(Icons.male_rounded),
      },
      {
        "gender": "Female",
        "icon": Icon(Icons.female_rounded),
      },
      {
        "gender": "Others",
        "icon": SvgPicture.asset('assets/icons/gender.svg'),
      }
    ];*/

    Future<void> createUserDocument() async {
      showLoading();
      User? userCredential = FirebaseAuth.instance.currentUser;
      if (userCredential != null && userCredential.email != null) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.email)
            .update({
          'gender': gender.isEmpty ? "" : gender,
          'dob': dob.isEmpty ? "" : dob,
          'weight': weightController.text.isEmpty ? "" : weightController.text,
          'height': heightController.text.isEmpty ? "" : heightController.text,
        });
      }
      dismissLoading();
      if (context.mounted) Navigator.of(context).pushNamed('/goals');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: 300,
                child: SvgPicture.asset(
                  'assets/onboarding/profile.svg',
                ),
              ),
            ),
            Text(
              'Let’s complete your profile',
              style: blackBold,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'It will help us to know more about you!',
              style: greyFont,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: DropdownButton<String>(
                      hint: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset(
                            'assets/icons/gender.svg',
                            height: 20,
                            width: 29,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            gender,
                            style: greyFont,
                          ),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      dropdownColor: Colors.grey.shade100,
                      isExpanded: true,
                      itemHeight: 50,
                      elevation: 0,
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey,
                      ),
                      iconSize: 34,
                      items: <String>['Male', 'Female', 'Others']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 40,
                                child:
                                    Center(child: Text(value, style: greyFont)),
                              ),
                              const Divider(
                                height: 1,
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              gender = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                  // Textbox(
                  //   enable: false,
                  //   hintText: 'Choose gender',
                  //   icon: SvgPicture.asset(
                  //     'assets/icons/users.svg',
                  //     color: Colors.grey,
                  //   ),
                  //   controller: controller,
                  //   suffixIcon: 'assets/icons/down.svg',
                  // ),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(25),
                                    padding: const EdgeInsets.all(25),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: CalendarDatePicker(
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.utc(1900, 1, 16),
                                      lastDate: DateTime.now(),
                                      onDateChanged: (value) {
                                        setState(() {
                                          dob =
                                              "${value.day}/${value.month}/${value.year}";
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              'assets/icons/calendar.svg',
                              color: Colors.grey,
                              height: 20,
                              width: 29,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              dob,
                              style: greyFont,
                            ),
                          ],
                        ),
                      )
                      // Textbox(
                      //   enable: false,
                      //   hintText: 'Date of Birth',
                      //   icon: SvgPicture.asset(
                      //     'assets/icons/calendar.svg',
                      //     color: Colors.grey,
                      //   ),
                      //   controller: controller,
                      // ),
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.6,
                        height: 50,
                        child: Textbox(
                          hintText: 'Your Weight',
                          icon: SvgPicture.asset(
                            'assets/icons/weight.svg',
                            color: Colors.grey,
                          ),
                          controller: weightController,
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: secondaryPurple,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text("KG"),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.6,
                        height: 50,
                        child: Textbox(
                          hintText: 'Your Height',
                          icon: SvgPicture.asset(
                            'assets/icons/weight.svg',
                            color: Colors.grey,
                          ),
                          controller: heightController,
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: secondaryPurple,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text("CM"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Button(
              btnText: 'Next',
              onTap: () {
                Map<Object, Object?> obj = {
                  'gender': gender.isEmpty ? "" : gender,
                  'dob': dob.isEmpty ? "" : dob,
                  'weight': weightController.text.isEmpty
                      ? ""
                      : weightController.text,
                  'height': heightController.text.isEmpty
                      ? ""
                      : heightController.text,
                };
                updateUserDocument(obj, context, '/goals');
                //createUserDocument();
              },
              icon: const Icon(
                Icons.navigate_next,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
