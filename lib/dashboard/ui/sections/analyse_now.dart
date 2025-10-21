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
import 'package:http/http.dart' as https;
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';

Widget analyseNow(buildContext, List<String> allMarketPairs) {

  return Container(
      height: 51,
      padding: const EdgeInsets.only(left: 19, right: 19),
      alignment: Alignment.bottomCenter,
      child: InkWell(
          onTap: () {

            showModalBottomSheet(
                context: buildContext,
                backgroundColor: Colors.transparent,
                elevation: 19.0,
                sheetAnimationStyle: const AnimationStyle(curve: Curves.easeIn, duration: Duration(milliseconds: 753), reverseCurve: Curves.easeOut, reverseDuration: Duration(milliseconds: 999)),
                builder: (BuildContext context) {

                  return Padding(
                    padding: const EdgeInsets.only(left: 19, right: 19),
                    child: Container(
                      height: 333,
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(19), topRight: Radius.circular(19)),
                        color: ColorsResources.black,
                      ),
                      child: ListView.builder(
                          padding: const EdgeInsets.only(left: 37, top: 19, right: 37, bottom: 73),
                          itemCount: StringsResources.marketPairs().length,
                          itemBuilder: (BuildContext context, int index) {

                            return Container(
                                padding: const EdgeInsets.only(top: 19),
                                child: InkWell(
                                    onTap: () async {
                                      debugPrint('Analyse Now: ${allMarketPairs[index]}');

                                      final lookupResponse = await https.get(Uri.parse('https://us-central1-sachiel-s-signals.cloudfunctions.net/aiNow?pinCode=1337&marketPair=${allMarketPairs[index]}'));

                                      if (lookupResponse.statusCode == 200) {}

                                      Navigator.pop(buildContext);

                                    },
                                    child: Container(
                                      height: 59,
                                      decoration: BoxDecoration(
                                          color: ColorsResources.premiumDark.withAlpha(137),
                                          borderRadius: BorderRadius.circular(13)
                                      ),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            allMarketPairs[index],
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: ColorsResources.premiumLight
                                            ),
                                          )
                                      ),
                                    )
                                )
                            );
                          }
                      ),
                    )
                  );
                }
            );

          },
          child: Container(
            padding: const EdgeInsets.only(left: 19, top: 7, right: 19, bottom: 7),
            decoration: BoxDecoration(
                color: ColorsResources.black,
                borderRadius: BorderRadius.circular(13)
            ),
            child: const Align(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('assets/analyse_now_icon.png'),
                )
            ),
          )
      )
  );
}

void _analyseNowProcess(String marketPair) {

}