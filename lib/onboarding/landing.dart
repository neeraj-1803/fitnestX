import 'package:fitnestx_flutter/components/button.dart';
import 'package:fitnestx_flutter/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Fitnest",
                      children: [
                        TextSpan(
                          text: "X",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w800,
                            fontSize: 35,
                            color: purpleColor,
                          ),
                        ),
                      ],
                    ),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800,
                      fontSize: 26,
                    ),
                  ),
                  Text(
                    "Everybody can train",
                    style: font16pxLight,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Button(
          btnText: "Get Started",
          onTap: () {
            Navigator.pushNamed(context, '/intropage');
          },
        ),
      ),
    );
  }
}
