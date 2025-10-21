/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/18/22, 4:16 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/signals/data/signals_data_structure.dart';
import 'package:sachiel/store/ui/sachiel_digital_store.dart';
import 'package:sachiel/store/utils/digital_store_utils.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';

class LastSignalDetails extends StatefulWidget {

  const LastSignalDetails({Key? key}) : super(key: key);

  @override
  State<LastSignalDetails> createState() => _LastSignalDetailsState();

}
class _LastSignalDetailsState extends State<LastSignalDetails> {

  DigitalStoreUtils digitalStoreUtils = DigitalStoreUtils();

  ScrollController scrollController = ScrollController();

  Widget lastSignalDetails = Container(
    height: 399,
    width: 351,
    alignment: Alignment.center,
    child: LoadingAnimationWidget.staggeredDotsWave(
      colorOne: ColorsResources.premiumLight,
      colorTwo: ColorsResources.primaryColor,
      size: 73,
    ),
  );

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
        padding: const EdgeInsets.fromLTRB(7, 37, 7, 0),
        child: lastSignalDetails
      )
    );
  }

  void retrieveLastSignalDetails() async {
    debugPrint("Retrieve Last Signal Details");

    String purchasingTier = await digitalStoreUtils.purchasedTier();

    if (purchasingTier.isNotEmpty) {

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("/Sachiels"
          "/Signals"
          "/$purchasingTier")
          .limit(1)
          .orderBy("tradeTimestamp", descending: true)
          .get();

      if (querySnapshot.docs.isEmpty) {

        if (purchasingTier == SachielsDigitalStore.palladiumTier) {

          querySnapshot = await FirebaseFirestore.instance
              .collection("/Sachiels"
              "/Signals"
              "/${SachielsDigitalStore.goldTier}")
              .limit(1)
              .orderBy("tradeTimestamp", descending: true)
              .get();

          if (querySnapshot.docs.isEmpty) {

            querySnapshot = await FirebaseFirestore.instance
                .collection("/Sachiels"
                "/Signals"
                "/${SachielsDigitalStore.platinumTier}")
                .limit(1)
                .orderBy("tradeTimestamp", descending: true)
                .get();

          }

        } else {

          querySnapshot = await FirebaseFirestore.instance
              .collection("/Sachiels"
              "/Signals"
              "/${SachielsDigitalStore.platinumTier}")
              .limit(1)
              .orderBy("tradeTimestamp", descending: true)
              .get();

        }

      }

      SignalsDataStructure signalsDataStructure = SignalsDataStructure(querySnapshot.docs.first);

      prepareLastSignalsDetails(signalsDataStructure);

    } else {

      navigateToWithPop(context, SachielsDigitalStore());

    }

  }

  void prepareLastSignalsDetails(SignalsDataStructure signalsDataStructure) {

    setState(() {

      lastSignalDetails = ListView(
        padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,

        controller: scrollController,
        children: [

          overviewDetailsView(signalsDataStructure),

          Container(
            width: 31,
          ),

          technicalDetailsView(signalsDataStructure),

        ],
      );

    });

  }

  Widget overviewDetailsView(SignalsDataStructure signalsDataStructure) {
    debugPrint("Overview Details: ${signalsDataStructure.signalsDocumentData}");

    var tradeCommandColor = ColorsResources.sellColor;
    double tradeCommandFontSize = 87;

    if (signalsDataStructure.tradeCommand() == "Buy") {

      tradeCommandColor = ColorsResources.buyColor;
      tradeCommandFontSize = 97;

    }

    DateTime tradeTimestamp = DateTime.fromMillisecondsSinceEpoch(signalsDataStructure.tradeTimestamp());

    var tradeTimestampText = tradeTimestamp.toString();

    try {

      tradeTimestampText = "${DateFormat("EE").format(tradeTimestamp)}, ${DateFormat("MMMM").format(tradeTimestamp)} ${tradeTimestamp.day}, ${tradeTimestamp.year}"
          " | "
          "${tradeTimestamp.hour}:${tradeTimestamp.minute}:${tradeTimestamp.second}";

    } catch (exception) {}

    return SizedBox(
        height: 399,
        width: 351,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: Stack(
              children: [

                Blur(
                    blur: 7,
                    blurColor: ColorsResources.black,
                    borderRadius: BorderRadius.circular(19),
                    colorOpacity: 0.19,
                    alignment: Alignment.center,
                    child: const SizedBox(
                      height: 399,
                      width: 351,
                    )
                ),

                Container(
                    alignment: Alignment.topRight,
                    child: const Opacity(
                        opacity: 0.19,
                        child: Image(
                          image: AssetImage("assets/percent_sign.png"),
                          height: 179,
                        )
                    )
                ),

                Container(
                    alignment: Alignment.bottomLeft,
                    child: const Opacity(
                        opacity: 0.19,
                        child: Image(
                          image: AssetImage("assets/dollar_sign.png"),
                          height: 199,
                        )
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                /* Start - Trade Command */
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                        signalsDataStructure.tradeCommand().toUpperCase(),
                                        style: TextStyle(
                                            color: tradeCommandColor,
                                            fontSize: tradeCommandFontSize,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              Shadow(
                                                  color: ColorsResources.black.withAlpha(130),
                                                  blurRadius: 19,
                                                  offset: const Offset(0, 5)
                                              )
                                            ]
                                        )
                                    ),

                                    Text(
                                        signalsDataStructure.tradeMarketPair(),
                                        style: const TextStyle(
                                            color: ColorsResources.premiumLight,
                                            fontSize: 47,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.3
                                        )
                                    )

                                  ],
                                ),
                                /* End - Trade Command */

                                /* Start - Trade Accuracy */
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(9, 0, 0, 0),
                                    child: Text(
                                      double.parse(signalsDataStructure.tradeAccuracyPercentage().replaceAll("%", "")).round().toString(),
                                      style: const TextStyle(
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

                            const Spacer(),

                            Text(
                              signalsDataStructure.tradeProfitAmount(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: ColorsResources.premiumLight,
                                  fontSize: 73,
                                  letterSpacing: 1.3,
                                  shadows: [
                                    Shadow(
                                        color: ColorsResources.black.withOpacity(0.5),
                                        blurRadius: 13,
                                        offset: const Offset(0.0, 3.0)
                                    )
                                  ]
                              ),
                            ),

                            Container(
                              width: 351,
                              height: 59,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                tradeTimestampText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: ColorsResources.premiumLight,
                                  fontSize: 17,
                                ),
                              ),
                            ),

                          ],
                        )
                    )
                ),

                /* Start - Next Slide */
                Positioned(
                    bottom: 7,
                    right: 11,
                    child: InkWell(
                        onTap: () {

                          scrollController.animateTo(387, duration: const Duration(milliseconds: 313), curve: Curves.easeOut);

                        },
                        child: const Image(
                          image: AssetImage("assets/next_icon.png"),
                          height: 37,
                          width: 37,
                        )
                    )
                )
                /* End - Next Slide */

              ]
          )
        )
    );
  }

  Widget technicalDetailsView(SignalsDataStructure signalsDataStructure) {

    var tradeCommandColor = ColorsResources.sellColor;

    if (signalsDataStructure.tradeCommand() == "Buy") {

      tradeCommandColor = ColorsResources.buyColor;

    }

    DateTime tradeTimestamp = DateTime.fromMillisecondsSinceEpoch(signalsDataStructure.tradeTimestamp());

    var tradeTimestampText = tradeTimestamp.toString();

    try {

      tradeTimestampText = "${DateFormat("EE").format(tradeTimestamp)}, ${DateFormat("MMMM").format(tradeTimestamp)} ${tradeTimestamp.day}, ${tradeTimestamp.year}"
          " - "
          "${tradeTimestamp.hour}:${tradeTimestamp.minute}:${tradeTimestamp.second}";

    } catch (exception) {}

    return SizedBox(
        height: 399,
        width: 351,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: Stack(
              children: [
                Blur(
                    blur: 3,
                    blurColor: ColorsResources.premiumLight,
                    borderRadius: BorderRadius.circular(19),
                    colorOpacity: 0.07,
                    alignment: Alignment.center,
                    child: const SizedBox(
                      height: 399,
                      width: 351,
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

                            /* Start - Trade Command */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${signalsDataStructure.tradeCommand().toUpperCase()}" " ",
                                    style: TextStyle(
                                        color: tradeCommandColor,
                                        fontSize: 47,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                              color: ColorsResources.black.withOpacity(0.3),
                                              blurRadius: 19,
                                              offset: const Offset(0, 5)
                                          )
                                        ]
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    " " "${signalsDataStructure.tradeMarketPair().toUpperCase()}",
                                    style: const TextStyle(
                                        color: ColorsResources.premiumLight,
                                        fontSize: 47,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5
                                    ),
                                  ),
                                )
                              ],
                            ),
                            /* End - Trade Command */

                            const Divider(
                              height: 11,
                            ),

                            Container(
                              width: 351,
                              height: 31,
                              padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          StringsResources.accuracyText(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: ColorsResources.premiumLight.withOpacity(0.91),
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      )
                                  ),
                                  const Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Image(
                                          image: AssetImage("assets/point_icon.png"),
                                          height: 19,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          signalsDataStructure.tradeAccuracyPercentage(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: ColorsResources.premiumLight.withOpacity(0.91),
                                              fontWeight: FontWeight.normal,
                                              shadows: [
                                                Shadow(
                                                    color: ColorsResources.black.withOpacity(0.59),
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 3)
                                                )
                                              ]
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 351,
                              height: 31,
                              padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          StringsResources.lotSizeText(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: ColorsResources.premiumLight.withOpacity(0.91),
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      )
                                  ),
                                  const Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Image(
                                          image: AssetImage("assets/point_icon.png"),
                                          height: 19,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          signalsDataStructure.tradeLotSize(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: ColorsResources.premiumLight.withOpacity(0.91),
                                              fontWeight: FontWeight.normal,
                                              shadows: [
                                                Shadow(
                                                    color: ColorsResources.black.withOpacity(0.59),
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 3)
                                                )
                                              ]
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 351,
                              height: 31,
                              padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          StringsResources.earningsText(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: ColorsResources.premiumLight.withOpacity(0.91),
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      )
                                  ),
                                  const Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Image(
                                          image: AssetImage("assets/point_icon.png"),
                                          height: 19,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "~" " " "${signalsDataStructure.tradeProfitAmount()}",
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: ColorsResources.premiumLight.withOpacity(0.91),
                                              fontWeight: FontWeight.normal,
                                              shadows: [
                                                Shadow(
                                                    color: ColorsResources.black.withOpacity(0.59),
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 3)
                                                )
                                              ]
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),

                            const Divider(
                              height: 15,
                            ),

                            Container(
                              width: 351,
                              height: 31,
                              padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          StringsResources.entryPriceText(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: ColorsResources.entryPriceColor.withOpacity(0.91),
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Image(
                                          image: const AssetImage("assets/point_icon.png"),
                                          color: ColorsResources.entryPriceColor.withOpacity(0.91),
                                          height: 19,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          signalsDataStructure.tradeEntryPrice(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: ColorsResources.entryPriceColor.withOpacity(0.91),
                                              fontWeight: FontWeight.normal,
                                              shadows: [
                                                Shadow(
                                                    color: ColorsResources.black.withOpacity(0.59),
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 3)
                                                )
                                              ]
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 351,
                              height: 31,
                              padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          StringsResources.takeProfitText(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: ColorsResources.takeProfitColor.withOpacity(0.91),
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Image(
                                          image: const AssetImage("assets/point_icon.png"),
                                          color: ColorsResources.takeProfitColor.withOpacity(0.91),
                                          height: 19,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          signalsDataStructure.tradeTakeProfit(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: ColorsResources.takeProfitColor.withOpacity(0.91),
                                              fontWeight: FontWeight.normal,
                                              shadows: [
                                                Shadow(
                                                    color: ColorsResources.black.withOpacity(0.59),
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 3)
                                                )
                                              ]
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 351,
                              height: 31,
                              padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          StringsResources.stopLossText(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: ColorsResources.stopLossColor.withOpacity(0.91),
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Image(
                                          image: const AssetImage("assets/point_icon.png"),
                                          color: ColorsResources.stopLossColor.withOpacity(0.91),
                                          height: 19,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          signalsDataStructure.tradeStopLoss(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: ColorsResources.stopLossColor.withOpacity(0.91),
                                              fontWeight: FontWeight.normal,
                                              shadows: [
                                                Shadow(
                                                    color: ColorsResources.black.withOpacity(0.59),
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 3)
                                                )
                                              ]
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),

                          ],
                        )
                    )
                ),

                /* Start - Trade Timeframe */
                Positioned(
                  left: 13,
                  bottom: 27,
                  child: Container(
                    width: 351,
                    height: 39,
                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      signalsDataStructure.tradeTimeframe(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: ColorsResources.premiumLight,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
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
                ),
                /* End - Trade Timeframe */

                /* Start - Trade Time */
                Positioned(
                  left: 13,
                  bottom: 7,
                  child: Container(
                    width: 351,
                    height: 59,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      tradeTimestampText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ColorsResources.premiumLight,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                /* End - Trade Time */

              ]
          )
        )
    );
  }

}
