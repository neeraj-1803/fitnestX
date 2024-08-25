// ignore_for_file: must_be_immutable

import 'package:basics/string_basics.dart';
import 'package:fitnestx_flutter/helper/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

class Exercise extends StatefulWidget {
  var routes;
  // final void Function()? setData;
  Exercise({
    super.key,
    required this.routes,
  });

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  bool _isExpanded = false;
  var box = Hive.box('exercisedb');

  @override
  Widget build(BuildContext context) {
    final List instruction = widget.routes["instructions"];

    updateToDb() async {
      Map<String, dynamic> data = {...widget.routes};
      data.remove('trailingStar');
      bool del = false;
      for (int i = 0; i < box.length; i++) {
        if (mapEquals(box.get(i), data)) {
          del = box.containsKey(i);
          await box.delete(i);
        }
      }
      if (box.length == 0 && !del) {
        await box.add(data);
      } else if (!del) {
        await box.add(data);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: 25.0,
        left: 25.0,
        right: 25.0,
      ),
      child: ExpansionTile(
        collapsedBackgroundColor: purpleColor,
        minTileHeight: 120,
        tilePadding: const EdgeInsets.all(0),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        shape: const RoundedRectangleBorder(
          side: BorderSide.none,
        ),
        title: Text(
          widget.routes["name"].toString().capitalize(),
          style: blackBold16px,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.network(
            widget.routes["gifUrl"],
            height: 60,
            width: 70,
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  setState(() {
                    widget.routes["trailingStar"] == Icons.star_rounded
                        ? widget.routes["trailingStar"] =
                            Icons.star_outline_rounded
                        : widget.routes["trailingStar"] = Icons.star_rounded;
                  });
                  await updateToDb();
                },
                child: Icon(widget.routes["trailingStar"]),
              ),
              AnimatedRotation(
                turns: _isExpanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 250),
                child: SvgPicture.asset(
                  'assets/icons/down.svg',
                  height: 15,
                ),
              ),
            ],
          ),
        ),
        onExpansionChanged: (value) {
          setState(() {
            _isExpanded = value;
          });
        },
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.routes["gifUrl"]),
              ExpansionTile(
                tilePadding: const EdgeInsets.all(0),
                collapsedShape: const RoundedRectangleBorder(
                  side: BorderSide.none,
                ),
                shape: const RoundedRectangleBorder(
                  side: BorderSide.none,
                ),
                title: Text(
                  "How to do it",
                  style: font16pxLightBlack,
                ),
                children: instruction.map((elem) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\u2022 ',
                        style: blackBold16px,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          elem.toString(),
                          style: greyFont,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              const Divider(),
            ],
          ),
        ],
      ),
    );
  }
}
