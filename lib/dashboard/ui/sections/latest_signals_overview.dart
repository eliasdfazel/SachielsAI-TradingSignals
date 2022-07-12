/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/12/22, 2:33 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/ui/system_bars.dart';

class LatestSignalsOverview extends StatefulWidget {

  const LatestSignalsOverview({Key? key}) : super(key: key);

  @override
  State<LatestSignalsOverview> createState() => _LatestSignalsOverviewState();
}
class _LatestSignalsOverviewState extends State<LatestSignalsOverview> {

  String profileName = StringsResources.sachielAI();
  Widget profileImage = const Image(
    image: AssetImage("cyborg_girl.jpg"),
    fit: BoxFit.cover,
  );

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.black, ColorsResources.black);

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return      SizedBox(
      width: 311,
      height: 179,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 73),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: 311,
            height: 179,
            child: ColoredBox(color: Colors.green,),
          ),
          SizedBox(
            width: 311,
            height: 179,
            child: ColoredBox(color: Colors.blueAccent,),
          ),
          SizedBox(
            width: 311,
            height: 179,
            child: ColoredBox(color: Colors.redAccent,),
          )
        ],
      ),
    );
  }

}
