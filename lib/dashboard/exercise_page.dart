import 'package:fitnestx_flutter/components/exercise.dart';
import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List<dynamic> routes = List.empty();

  void saveData(index) {
    setState(() {
      routes[index]["trailingStar"] = Icons.star_rounded;
    });
  }

  @override
  Widget build(BuildContext context) {
    routes = ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Exercises'),
      ),
      body: ListView.builder(
        primary: false,
        itemCount: routes.length,
        itemBuilder: (context, index) {
          routes[index]["trailingStar"] = Icons.star_border_rounded;
          return Exercise(
            routes: routes[index],
            savedFlow: false,
          );
        },
      ),
    );
  }
}
