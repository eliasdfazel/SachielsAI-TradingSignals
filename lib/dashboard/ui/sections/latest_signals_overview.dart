/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/5/22, 2:24 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/data/signals_data_structure.dart';
import 'package:sachiel/resources/colors_resources.dart';

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
      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
      child: SizedBox(
          height: 173,
          width: double.infinity,
          child: latestSignalsDetails
      )
    );
  }

  void retrieveLatestSignalDetails() {
    debugPrint("Retrieve Latest Signals Details");

    FirebaseFirestore.instance
        .collection("SachielsSignals")
        // .limit(7)
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

      latestSignalsDetails = ListView(
        padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        children: aLatestSignal,
      );

    });

  }

  Widget signalDataStructureItemView(SignalsDataStructure signalsDataStructure) {
    debugPrint("Latest Signals Details Data: ${signalsDataStructure.tradeCommand()} ${signalsDataStructure.tradeMarketPair()}");

    return SizedBox(
        height: 173,
        width: 119,
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
                  color: ColorsResources.primaryColorLightest.withOpacity(0.13),
                  blurRadius: 19,
                  offset: const Offset(0, 0)
                )
              ]
          ),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.loose,
            children: [

              /* Start - Percentage */
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  "%",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 173,
                      fontFamily: "Handwriting"
                  ),
                )
              )
              /* End - Percentage */

            ],
          ),
        )
    );
  }

}
