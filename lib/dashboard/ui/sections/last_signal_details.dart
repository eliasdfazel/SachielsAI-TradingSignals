/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/27/22, 5:56 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/data/signals_data_structure.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/utils/data/numbers.dart';

class LastSignalDetails extends StatefulWidget {

  const LastSignalDetails({Key? key}) : super(key: key);

  @override
  State<LastSignalDetails> createState() => _LastSignalDetailsState();
}
class _LastSignalDetailsState extends State<LastSignalDetails> {

  ScrollController scrollController = ScrollController();

  List<Widget> lastSignalDetails = [];

  @override
  void initState() {
    super.initState();

    retrieveLastSignalDetails();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 399,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 37, 0, 13),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          children: lastSignalDetails,
        )
      )
    );
  }

  void retrieveLastSignalDetails() async {

    // SignalsDataStructure signalsDataStructure = SignalsDataStructure(documentSnapshot);
    //
    // prepareLastSignalsDetails(signalsDataStructure);

    lastSignalDetails.add(overviewDetailsView());

    lastSignalDetails.add(technicalDetailsView());

    lastSignalDetails.add(shareDetailsView());

    setState(() {

      lastSignalDetails;

    });

  }

  void prepareLastSignalsDetails(SignalsDataStructure signalsDataStructure) {

    // lastSignalDetails.add(overviewDetailsView(signalsDataStructure));
    //
    // lastSignalDetails.add(technicalDetailsView(signalsDataStructure));
    //
    // lastSignalDetails.add(shareDetailsView(signalsDataStructure));

    setState(() {

      lastSignalDetails;

    });

  }

  Widget overviewDetailsView(/*SignalsDataStructure signalsDataStructure*/) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 37, 0),
      child: SizedBox(
        height: 399,
        width: 351,
        child: Stack(
          children: [
            Blur(
                blur: 5,
                blurColor: ColorsResources.premiumLight,
                borderRadius: BorderRadius.circular(19),
                colorOpacity: 0.07,
                alignment: Alignment.center,
                child: const SizedBox(
                  height: 399,
                  width: 351,
                )
            ),
            Positioned(
              top: -99,
              right: 33,
              child: Text(
                "%",
                style: TextStyle(
                  color: ColorsResources.black.withOpacity(0.17),
                  fontSize: 301,
                  fontFamily: "Handwriting"
                ),
              )
            ),
            Positioned(
                bottom: -19,
                left: 3,
                child: Transform.rotate(
                  angle: degreeToRadian(-19.0),
                  child: Text(
                    "\$",
                    style: TextStyle(
                        color: ColorsResources.black.withOpacity(0.17),
                        fontSize: 207,
                        fontFamily: "Handwriting"
                    ),
                  ),
                )
            ),
            Container(
              height: 399,
              width: 351,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(19),
                    topRight: Radius.circular(19),
                    bottomLeft: Radius.circular(19),
                    bottomRight: Radius.circular(19)
                ),
                border: Border(
                    top: BorderSide(
                      color: ColorsResources.black,
                      width: 1.3,
                    ),
                    bottom: BorderSide(
                      color: ColorsResources.black,
                      width: 1.3,
                    ),
                    left: BorderSide(
                      color: ColorsResources.black,
                      width: 1.3,
                    ),
                    right: BorderSide(
                      color: ColorsResources.black,
                      width: 1.3,
                    )
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        /* Start - Trade Command */
                        Column(
                          children: [
                            Text(
                              "SELL",
                              style: TextStyle(
                                  color: ColorsResources.sellColor,
                                  fontSize: 87,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: ColorsResources.black.withOpacity(0.3),
                                        blurRadius: 19,
                                        offset: Offset(0, 5)
                                    )
                                  ]
                              ),
                            ),
                            Text(
                              "BTCUSD",
                              style: TextStyle(
                                  color: ColorsResources.premiumLight,
                                  fontSize: 47,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.3
                              ),
                            )
                          ],
                        ),
                        /* End - Trade Command */

                        /* Start - Trade Accuracy */
                        Padding(
                            padding: EdgeInsets.fromLTRB(9, 0, 0, 0),
                            child: const Text(
                              "93",
                              style: TextStyle(
                                  color: ColorsResources.white,
                                  fontSize: 101,
                                  shadows: [
                                    Shadow(
                                        color: ColorsResources.black,
                                        blurRadius: 13,
                                        offset: Offset(0.0, 3.0)
                                    )
                                  ]
                              ),
                            )
                        )
                        /* End - Trade Accuracy */

                      ],
                    ),
                    Container(
                      width: 351,
                      height: 113,
                      padding: const EdgeInsets.fromLTRB(0, 31, 0, 0),
                      alignment: Alignment.center,
                      child: Text(
                        "7,337.19",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ColorsResources.premiumLight,
                          fontSize: 73,
                          letterSpacing: 1.3,
                          shadows: [
                            Shadow(
                              color: ColorsResources.black.withOpacity(0.5),
                              blurRadius: 11,
                              offset: const Offset(0.0, 3.0)
                            )
                          ]
                        ),
                      ),
                    ),
                    Container(
                      width: 351,
                      height: 59,
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Tue, July 7, 2022 - 17:13:37",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ColorsResources.premiumLight,
                          fontSize: 17,
                        ),
                      ),
                    )
                  ],
                )
              )
            ),
            Positioned(
              bottom: 7,
              right: 11,
              child: InkWell(
                onTap: () {

                  scrollController.jumpTo(379);

                },
                child: const Image(
                  image: AssetImage("next_icon.png"),
                  height: 37,
                  width: 37,
                )
              )
            )
          ]
        )
      )
    );
  }

  Widget technicalDetailsView(/*SignalsDataStructure signalsDataStructure*/) {

    return SizedBox(
      width: 353,
      height: 373,
      child: Container(
        color: Colors.blue,
        child: Text("TEST"),
      ),
    );
  }

  Widget shareDetailsView(/*SignalsDataStructure signalsDataStructure*/) {

    return SizedBox(
      width: 353,
      height: 373,
      child: Container(
        color: Colors.redAccent,
        child: Text("TEST"),
      ),
    );
  }

}
