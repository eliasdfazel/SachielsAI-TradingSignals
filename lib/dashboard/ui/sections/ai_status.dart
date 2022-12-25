/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/18/22, 4:16 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/ai_status/data/ai_status_data_structure.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:url_launcher/url_launcher.dart';

class StatusAi extends StatefulWidget {

  const StatusAi({Key? key}) : super(key: key);

  @override
  State<StatusAi> createState() => _StatusAiState();

}
class _StatusAiState extends State<StatusAi> {

  Widget aiStatus = Container();

  @override
  void initState() {
    super.initState();

    retrieveAllAiStatus();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 91,
      width: double.infinity,
      child: InkWell(
        onTap: () {

          launchUrl(Uri.parse("https://twitter.com/SachielsSignals"), mode: LaunchMode.externalApplication);

        },
        child: Padding(
            padding: const EdgeInsets.fromLTRB(19, 37, 7, 0),
            child: aiStatus
        )
      )
    );
  }

  void retrieveAllAiStatus() {

    FirebaseFirestore.instance
        .collection("/Sachiels/AI/Status/")
        .orderBy("statusTimestamp", descending: true)
        .get().then((querySnapshot) => {

          prepareStatusAi(querySnapshot)

        }).onError((error, stackTrace) => {



        });

  }

  void prepareStatusAi(QuerySnapshot querySnapshot) async {

    if (querySnapshot.docs.isNotEmpty) {

      List<Widget> aiStatusWidgets = [];

      for (var element in querySnapshot.docs) {

        aiStatusWidgets.add(statusItem(AIStatusDataStructure(element)));

      }

      setState(() {

        aiStatus = SizedBox(
            height: 53,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(
                    height: 53,
                    width: 53,
                    child: Image(
                      image: AssetImage("ai_status.png"),
                      height: 53,
                      width: 53,
                    )
                ),

                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: aiStatusWidgets,
                  )
                )

              ],
            )
        );

      });

    }

  }

  Widget statusItem(AIStatusDataStructure aiStatusDataStructure) {
    debugPrint("AI Status: ${aiStatusDataStructure.statusMessage()}");

    return Padding(
      padding: const EdgeInsets.only(left: 13),
      child: SizedBox(
        height: 53,
        width: 173,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            gradient: LinearGradient(
              colors: [
                ColorsResources.premiumDark,
                ColorsResources.black.withOpacity(0.51)
              ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: const [0.0, 1.0],
                transform: const GradientRotation(45),
                tileMode: TileMode.clamp
            )
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 19, right: 19),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    aiStatusDataStructure.statusMessage(),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      color: ColorsResources.premiumLight,
                      fontSize: 13,
                      letterSpacing: 0.3
                    )
                )
            )
          )
        )
      ),
    );
  }

}
