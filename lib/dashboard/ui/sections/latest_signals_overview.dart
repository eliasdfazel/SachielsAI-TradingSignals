/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/6/22, 11:35 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/data/signals_data_structure.dart';
import 'package:sachiel/history/ui/signals_history_interface.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/signal_details/ui/signal_details_interface.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';

class LatestSignalsOverview extends StatefulWidget {

  const LatestSignalsOverview({Key? key}) : super(key: key);

  @override
  State<LatestSignalsOverview> createState() => _LatestSignalsOverviewState();

}
class _LatestSignalsOverviewState extends State<LatestSignalsOverview> {

  ScrollController scrollController = ScrollController();

  Widget latestSignalsDetails = Container();

  @override
  void initState() {
    super.initState();

    retrieveLatestSignalDetails();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
      child: latestSignalsDetails
    );
  }

  void retrieveLatestSignalDetails() {
    debugPrint("Retrieve Latest Signals Details");

    FirebaseFirestore.instance
        .collection("SachielsSignals")
        .limit(13)
        .orderBy("tradeTimestamp")
        .get().then((QuerySnapshot querySnapshot) {

          List<SignalsDataStructure> signalsDataStructure = [];

          for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

            signalsDataStructure.add(SignalsDataStructure(queryDocumentSnapshot));

          }

          prepareLatestSignalsDetails(signalsDataStructure);

        },
        onError: (e) => {

        });

  }

  void prepareLatestSignalsDetails(List<SignalsDataStructure> signalsDataStructure) {

    List<Widget> aLatestSignal = <Widget>[];

    for (var signalDataStructureItem in signalsDataStructure) {

      aLatestSignal.add(signalDataStructureItemView(signalDataStructureItem));

    }

    setState(() {

      latestSignalsDetails = Column(
          children: [

            SizedBox(
                height: 173,
                width: double.infinity,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: scrollController,
                  children: aLatestSignal,
                )
            ),

            Padding(
                padding: const EdgeInsets.fromLTRB(0, 7, 19, 0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {

                          navigateTo(context, const SignalsHistoryInterface());

                        },
                        child: const Image(
                          image: AssetImage("show_history_icon.png"),
                          width: 173,
                        )
                    )
                )
            )

          ]
      );

    });

  }

  Widget signalDataStructureItemView(SignalsDataStructure signalsDataStructure) {
    debugPrint("Latest Signals Details Data: ${signalsDataStructure.tradeCommand()} ${signalsDataStructure.tradeMarketPair()}");

    var tradeCommandColor = ColorsResources.sellColor;

    if (signalsDataStructure.tradeCommand() == "Buy") {

      tradeCommandColor = ColorsResources.buyColor;

    }

    return InkWell(
      onTap: () {

        navigateTo(context, SignalsDetailsInterface(signalsDataStructure: signalsDataStructure));

      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(17),
                  topRight: Radius.circular(17),
                  bottomLeft: Radius.circular(17),
                  bottomRight: Radius.circular(17)
              ),
              border: const Border(
                  top: BorderSide(
                    color: ColorsResources.primaryColorDarker,
                    width: 1.3,
                  ),
                  bottom: BorderSide(
                    color: ColorsResources.primaryColorDarker,
                    width: 1.3,
                  ),
                  left: BorderSide(
                    color: ColorsResources.primaryColorDarker,
                    width: 1.3,
                  ),
                  right: BorderSide(
                    color: ColorsResources.primaryColorDarker,
                    width: 1.3,
                  )
              ),
              color: ColorsResources.premiumDark,
              boxShadow: [
                BoxShadow(
                    color: ColorsResources.primaryColorLightest.withOpacity(0.11),
                    blurRadius: 19,
                    offset: const Offset(0, 0)
                )
              ]
          ),
          height: 173,
          width: 119,
          child: Stack(
            fit: StackFit.expand,
            children: [

              /* Start - Percentage */
              Positioned(
                  top: -140,
                  left: -23,
                  child: Text(
                      "%",
                      style: TextStyle(
                          color: ColorsResources.black.withOpacity(0.07),
                          fontSize: 351,
                          fontFamily: "Handwriting"
                      )
                  )
              ),
              /* End - Percentage */

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /* Start - Trade Command */
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                      alignment: Alignment.center,
                      child: Text(
                        signalsDataStructure.tradeCommand().toUpperCase(),
                        style: TextStyle(
                            fontSize: 43,
                            fontWeight: FontWeight.bold,
                            color: tradeCommandColor
                        ),
                      )
                  ),
                  /* End - Trade Command */

                  /* Start - Trade Market Pair */
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                      alignment: Alignment.center,
                      child: Text(
                        signalsDataStructure.tradeMarketPair().toUpperCase(),
                        style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: ColorsResources.light
                        ),
                      )
                  ),
                  /* End - Trade Market Pair */

                  /* Start - Trade Accuracy */
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                      alignment: Alignment.center,
                      child: Text(
                        signalsDataStructure.tradeAccuracyPercentage().replaceAll("%", ""),
                        style: TextStyle(
                            fontSize: 63,
                            fontWeight: FontWeight.bold,
                            color: ColorsResources.premiumLight,
                            shadows: [
                              Shadow(
                                  color: ColorsResources.black.withOpacity(0.19),
                                  blurRadius: 13,
                                  offset: const Offset(0, 3)
                              )
                            ]
                        ),
                      )
                  ),
                  /* End - Trade Accuracy */

                ],
              ),

            ],
          )
      )
    );
  }

}
