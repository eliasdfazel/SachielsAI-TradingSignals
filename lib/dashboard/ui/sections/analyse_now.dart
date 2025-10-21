/*
 * Copyright © 2025 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/21/25, 9:53 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';

Widget analyseNow(buildContext) {

  // http://us-central1-sachiel-s-signals.cloudfunctions.net/aiNow?pinCode=1337&marketPair=EURUSD

  return Align(
    alignment: Alignment.bottomCenter,
    child: SizedBox(
      height: 59,
      child: InkWell(
        onTap: () {

          // show bottom sheet
          // on bottom sheet select call analyse now
          showModalBottomSheet(
              context: buildContext,
              backgroundColor: ColorsResources.black.withAlpha(173),
              elevation: 19.0,
              sheetAnimationStyle: const AnimationStyle(curve: Curves.easeIn, duration: Duration(milliseconds: 753), reverseCurve: Curves.easeOut, reverseDuration: Duration(milliseconds: 357)),
              builder: (BuildContext context) {

                return Container(
                  height: 333,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 19),
                  child: ListView.builder(
                      itemCount: StringsResources.marketPairs().length,
                      itemBuilder: (BuildContext context, int index) {

                        return Container(

                          child: InkWell(
                            onTap: () {

                              print(StringsResources.marketPairs()[index]);

                            },
                            child: Text(
                                StringsResources.marketPairs()[index],
                              style: TextStyle(
                                color: ColorsResources.premiumLight
                              ),
                            ),
                          )
                        );
                      }
                  ),
                );
              }
          );

        },
        child: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/rectircle_shape.png'),
                fit: BoxFit.contain
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              StringsResources.analyseNow(),
              style: const TextStyle(
                color: ColorsResources.premiumLight,
                fontSize: 15
              ),
            )
          ),
        )
      )
    )
  );
}

void _analyseNowProcess(String marketPair) {

}