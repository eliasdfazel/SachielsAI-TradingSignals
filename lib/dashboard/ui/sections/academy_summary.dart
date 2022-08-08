/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/8/22, 7:43 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/signals/data/signals_data_structure.dart';
import 'package:sachiel/utils/ui/display.dart';

class AcademySummaryInterface extends StatefulWidget {

  const AcademySummaryInterface({Key? key}) : super(key: key);

  @override
  State<AcademySummaryInterface> createState() => _AcademySummaryInterfaceState();

}
class _AcademySummaryInterfaceState extends State<AcademySummaryInterface> {

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
        padding: const EdgeInsets.fromLTRB(0, 31, 0, 0),
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
      aLatestSignal.add(signalDataStructureItemView(signalDataStructureItem));
      aLatestSignal.add(signalDataStructureItemView(signalDataStructureItem));
      aLatestSignal.add(signalDataStructureItemView(signalDataStructureItem));

    }

    int gridColumnCount = (displayWidth(context) / 173).round();

    setState(() {

      latestSignalsDetails = Column(
          children: [

            Padding(
                padding: const EdgeInsets.fromLTRB(19, 0, 0, 17),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringsResources.academyTitle(),
                      style: TextStyle(
                        fontSize: 51,
                        letterSpacing: 1.7,
                        color: ColorsResources.premiumLight,
                        shadows: [
                          Shadow(
                            color: ColorsResources.black.withOpacity(0.13),
                            blurRadius: 13,
                            offset: const Offset(0, 7)
                          )
                        ]
                      ),
                    )
                )
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
              child: SizedBox(
                  height: 513,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridColumnCount,
                      childAspectRatio: 1.39,
                      crossAxisSpacing: 19.0,
                      mainAxisSpacing: 19.0,
                    ),
                    padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: scrollController,
                    children: aLatestSignal,
                  )
              )
            ),

            Padding(
                padding: const EdgeInsets.fromLTRB(0, 21, 19, 0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {

                          // navigateTo(context, const SignalsHistoryInterface());

                        },
                        child: const Image(
                          image: AssetImage("archive_icon.png"),
                          width: 173,
                        )
                    )
                )
            ),

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

    return Container(
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
            color: ColorsResources.blue,
            boxShadow: [
              BoxShadow(
                  color: ColorsResources.primaryColorLightest.withOpacity(0.11),
                  blurRadius: 19,
                  offset: const Offset(0, 0)
              )
            ]
        ),
    );
  }

}