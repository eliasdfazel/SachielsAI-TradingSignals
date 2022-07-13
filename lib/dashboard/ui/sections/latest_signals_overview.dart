/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/12/22, 6:30 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/utils/ui/system_bars.dart';

class LatestSignalsOverview extends StatefulWidget {

  const LatestSignalsOverview({Key? key}) : super(key: key);

  @override
  State<LatestSignalsOverview> createState() => _LatestSignalsOverviewState();
}
class _LatestSignalsOverviewState extends State<LatestSignalsOverview> {

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
        padding: const EdgeInsets.fromLTRB(19, 0, 19, 73),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [

        ],
      ),
    );
  }

}
