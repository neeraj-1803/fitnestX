import 'package:basics/string_basics.dart';
import 'package:fitnestx_flutter/components/exercise.dart';
import 'package:fitnestx_flutter/helper/constants.dart';
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

  void onTapFilter(equip) {
    List<dynamic> route = (routes[0]["isEquipment"] == false)
        ? routes
            .where((elem) => elem["equipment"].toString() == equip.toString())
            .toList()
        : routes
            .where((elem) => elem["bodyPart"].toString() == equip.toString())
            .toList();
    Navigator.pop(context);
    Navigator.of(context).pushNamed("/exercisepage", arguments: route);
  }

  @override
  Widget build(BuildContext context) {
    routes = ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    Set filterList = (routes[0]["isEquipment"] == false)
        ? routes.map(
            (e) {
              return e["equipment"];
            },
          ).toSet()
        : routes.map(
            (e) {
              return e["bodyPart"];
            },
          ).toSet();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Exercises'),
      ),
      floatingActionButton: (filterList.length > 1)
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: filterList.map((element) {
                                return SizedBox(
                                  height: 50,
                                  child: GestureDetector(
                                    onTap: () {
                                      return onTapFilter(element);
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Spacer(),
                                        Text(
                                          element.toString().capitalize(),
                                          style: font16pxLightBlack,
                                        ),
                                        const Spacer(),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Divider(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.filter_alt),
            )
          : null,
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
