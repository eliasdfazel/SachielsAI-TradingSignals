/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/21/22, 1:20 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/store/ui/sachiel_digital_store.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';

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

                navigateTo(context, SachielsDigitalStore(topPadding: 0));

              },
              child: const Image(
                image: AssetImage("assets/squircle_logo.png"),
              )
          )
      ),
    );
  }

}