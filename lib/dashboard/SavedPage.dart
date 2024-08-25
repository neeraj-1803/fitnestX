import 'package:fitnestx_flutter/components/exercise.dart';
import 'package:fitnestx_flutter/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Savedpage extends StatefulWidget {
  const Savedpage({super.key});

  @override
  State<Savedpage> createState() => _SavedpageState();
}

class _SavedpageState extends State<Savedpage> {
  var box = Hive.box('exercisedb');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Exercises'),
      ),
      body: box.length == 0
          ? Center(
              child: Text(
                "No Data Saved.",
                style: font16pxLightBlack,
              ),
            )
          : ListView.builder(
              primary: false,
              itemCount: box.length,
              itemBuilder: (context, index) {
                return Exercise(
                  routes: box.get(index),
                );
              },
            ),
    );
  }
}
