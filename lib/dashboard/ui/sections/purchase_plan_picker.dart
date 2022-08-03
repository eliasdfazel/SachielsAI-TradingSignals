/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/3/22, 3:06 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:sachiel/resources/colors_resources.dart';

class PurchasePlanPicker extends StatefulWidget {

  const PurchasePlanPicker({Key? key}) : super(key: key);

  @override
  State<PurchasePlanPicker> createState() => PurchasePlanPickerStates();

}
class PurchasePlanPickerStates extends State<PurchasePlanPicker> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: ColorsResources.primaryColorLighter,
                blurRadius: 51,
                spreadRadius: 0,
                offset: Offset(0, 0)
            )
          ]
      ),
      child: SizedBox(
          height: 59,
          width: 59,
          child: InkWell(
              onTap: () {



              },
              child: const Image(
                image: AssetImage("squircle_logo.png"),
              )
          )
      ),
    );
  }

}