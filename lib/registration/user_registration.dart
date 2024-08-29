import 'package:basics/basics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnestx_flutter/auth/auth_service.dart';
import 'package:fitnestx_flutter/auth/crud_firebase.dart';
import 'package:fitnestx_flutter/components/button.dart';
import 'package:fitnestx_flutter/components/textbox.dart';
import 'package:fitnestx_flutter/helper/constants.dart';
import 'package:fitnestx_flutter/helper/heper_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class UserRegistration extends StatefulWidget {
  bool isBack;
  UserRegistration({
    super.key,
    required this.isBack,
  });

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  final String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final int emailLen = 6;
  final String nameRegex = r'^[a-zA-Z ]+$';
  final int nameLen = 3;
  final String passwordRegex = r'[!@#%^&*(),.?":{}|<>]';
  final int pwdLen = 3;
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;
  var box = Hive.box('exercisedb');

  @override
  Widget build(BuildContext context) {
    void clearFields() {
      if (context.mounted) {
        //reset values
        emailController.clear();
        pwdController.clear();
        firstNameController.clear();
        lastNameController.clear();
        isChecked = false;
        dismissLoading();
        if (widget.isBack) {
          Navigator.pushNamed(context, '/welcome');
        } else {
          Navigator.pushNamed(context, '/registrationprofile');
        }
      }
    }

    void loginOrRegister() async {
      showLoading();
      if (emailController.text.isNotEmpty && pwdController.text.isNotEmpty) {
        if (widget.isBack) {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text, password: pwdController.text);
          if (box.get('username') == null) {
            await box.put('username', emailController.text);
          } else if (box.get('username') != emailController.text) {
            await box.clear();
            await box.put('username', emailController.text);
          }
        } else if (!widget.isBack && isChecked) {
          UserCredential userReg = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailController.text, password: pwdController.text);
          Map<String, dynamic> obj = {
            'email': emailController.text,
            'name': "${firstNameController.text} ${lastNameController.text}",
          };
          createUserDocument(userReg, obj);
          await box.put('username', emailController.text);
          // createUserDocument(userReg); //to store the user data
        }
        clearFields();
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Hey there!',
                      style: font16pxLightBlack,
                    ),
                    Text(
                      'Create an Account',
                      style: blackBold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          if (!widget.isBack)
                            Textbox(
                              hintText: 'First Name',
                              icon: SvgPicture.asset(
                                'assets/icons/user.svg',
                                color: Colors.grey,
                              ),
                              controller: firstNameController,
                              validator: nameRegex,
                              minLen: nameLen,
                            ),
                          if (!widget.isBack)
                            const SizedBox(
                              height: 20,
                            ),
                          if (!widget.isBack)
                            Textbox(
                              hintText: 'Last Name',
                              icon: SvgPicture.asset(
                                'assets/icons/user.svg',
                                color: Colors.grey,
                              ),
                              controller: lastNameController,
                              validator: nameRegex,
                              minLen: nameLen,
                            ),
                          if (!widget.isBack)
                            const SizedBox(
                              height: 20,
                            ),
                          Textbox(
                            hintText: 'Email',
                            icon: SvgPicture.asset(
                              'assets/icons/inbox.svg',
                              color: Colors.grey,
                            ),
                            controller: emailController,
                            validator: emailRegex,
                            minLen: emailLen,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Textbox(
                            hintText: 'Password',
                            icon: SvgPicture.asset(
                              'assets/icons/lock.svg',
                              color: Colors.grey,
                            ),
                            controller: pwdController,
                            validator: passwordRegex,
                            isPassword: true,
                            minLen: pwdLen,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (widget.isBack)
                      Text(
                        'Forgot Password',
                        style: GoogleFonts.poppins(
                          color: grayColorFade,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (val) {
                              setState(() {
                                if (val != null && val) {
                                  isChecked = true;
                                } else {
                                  isChecked = false;
                                }
                              });
                            },
                          ),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'By continuing you agree to the ',
                                    style: GoogleFonts.poppins(
                                      color: grayColorFade,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: GoogleFonts.poppins(
                                      color: grayColorFade,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' and ',
                                    style: GoogleFonts.poppins(
                                      color: grayColorFade,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Terms of Use',
                                    style: GoogleFonts.poppins(
                                      color: grayColorFade,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Button(
                      btnText: widget.isBack ? "Login" : "Register",
                      icon: widget.isBack
                          ? const Icon(
                              Icons.login_rounded,
                              color: Colors.white,
                            )
                          : null,
                      onTap: () {
                        if (formKey.currentState == null ||
                            !formKey.currentState!.validate()) {
                          //if form data is invalid
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            dismissDirection: DismissDirection.none,
                            padding: EdgeInsets.zero,
                            margin: const EdgeInsets.only(bottom: 15),
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 2),
                            content: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: const Color(0xff656565),
                                ),
                                child: const Text(
                                  'Please check the entered input data',
                                ),
                              ),
                            ),
                          ));
                        } else {
                          loginOrRegister();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: grayColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "or",
                            style: greyFont,
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: grayColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            showLoading();

                            UserCredential userReg =
                                await AuthService().signInWithGoogle();
                            var email = userReg.additionalUserInfo!.profile!
                                .get("email");
                            if (userReg.additionalUserInfo!.isNewUser) {
                              setState(() {
                                widget.isBack = false;
                              });

                              var name = userReg.additionalUserInfo!.profile!
                                  .get("name");
                              Map<String, dynamic> obj = {
                                'email': email,
                                'name': name,
                              };
                              await createUserDocument(userReg, obj);
                              box.put('username', email);
                            } else {
                              if (box.get('username') == null) {
                                await box.put('username', email);
                              } else if (box.get('username') != email) {
                                await box.clear();
                                await box.put('username', email);
                              }
                              setState(() {
                                widget.isBack = true;
                              });
                            }
                            clearFields();
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset('assets/icons/google.svg'),
                              Image.asset('assets/icons/googlelogo.png'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () => AuthService().signInWithApple(),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset('assets/icons/google.svg'),
                              SvgPicture.asset(
                                'assets/icons/apple.svg',
                                width: 25,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: font16pxLightBlack,
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            widget.isBack = !widget.isBack;
                          }),
                          child: Text(
                            !widget.isBack ? ' Login' : ' Register Here',
                            style: font16pxLightPinkBoldUnderline,
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
