/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/24/22, 5:32 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sachiel/dashboard/ui/sections/purchase_plan_picker.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:sachiel/utils/ui/system_bars.dart';
import 'package:widget_mask/widget_mask.dart';

import '../../signals/data/signals_data_structure.dart';

class SignalsHistoryInterface extends StatefulWidget {

  const SignalsHistoryInterface({Key? key}) : super(key: key);

  @override
  State<SignalsHistoryInterface> createState() => _SignalsHistoryInterfaceState();

}
class _SignalsHistoryInterfaceState extends State<SignalsHistoryInterface> {

  Widget allSignalsHistory = Container(
    alignment: Alignment.center,
    child: LoadingAnimationWidget.staggeredDotsWave(
      colorOne: ColorsResources.premiumLight,
      colorTwo: ColorsResources.primaryColor,
      size: 73,
    ),
  );

  @override
  void initState() {

    retrieveSignalsHistory();

    super.initState();

    changeColor(ColorsResources.black, ColorsResources.black);

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringsResources.applicationName(),
        color: ColorsResources.primaryColor,
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
          backgroundColor: ColorsResources.black,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
          }),
        ),
        home: Scaffold(
            backgroundColor: ColorsResources.black,
            body: Stack(
              children: [

                /* Start - Gradient Background - Dark */
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17)
                    ),
                    border: Border(
                        top: BorderSide(
                          color: ColorsResources.black,
                          width: 7,
                        ),
                        bottom: BorderSide(
                          color: ColorsResources.black,
                          width: 7,
                        ),
                        left: BorderSide(
                          color: ColorsResources.black,
                          width: 7,
                        ),
                        right: BorderSide(
                          color: ColorsResources.black,
                          width: 7,
                        )
                    ),
                    gradient: LinearGradient(
                        colors: [
                          ColorsResources.premiumDark,
                          ColorsResources.black,
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        transform: GradientRotation(-45),
                        tileMode: TileMode.clamp
                    ),
                  )
                ),
                /* End - Gradient Background - Dark */

                /* Start - Branding Transparent */
                const Align(
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: 0.1,
                    child: Image(
                      image: AssetImage("logo.png"),
                    ),
                  ),
                ),
                /* End - Branding Transparent */

                /* Start - Gradient Background - Golden */
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(17),
                              topRight: Radius.circular(17),
                              bottomLeft: Radius.circular(17),
                              bottomRight: Radius.circular(17)
                          ),
                          gradient: RadialGradient(
                            radius: 1.1,
                            colors: <Color> [
                              ColorsResources.primaryColorLighter.withOpacity(0.51),
                              Colors.transparent,
                            ],
                            center: const Alignment(0.79, -0.87),
                          )
                      ),
                      child: SizedBox(
                        height: calculatePercentage(99, displayHeight(context)),
                        width: calculatePercentage(99, displayWidth(context)),
                      ),
                    )
                ),
                /* End - Gradient Background - Golden */

                allSignalsHistory,

                /* Start - Back */
                Row(
                  children: [

                    /* Start - Back */
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(19, 19, 0, 0),
                            child: SizedBox(
                                height: 59,
                                width: 59,
                                child: InkWell(
                                  onTap: () {

                                    navigatePop(context);

                                  },
                                  child: const Image(
                                    image: AssetImage("back_icon.png"),
                                  ),
                                )
                            )
                        )
                    ),
                    /* End - Back */

                    /* Start - Title */
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(19, 19, 0, 0),
                            child: SizedBox(
                                height: 59,
                                width: 155,
                                child: Stack(
                                  children: [
                                    WidgetMask(
                                      blendMode: BlendMode.srcATop,
                                      childSaveLayer: true,
                                      mask /* Original Image */: Container(
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  ColorsResources.premiumDark,
                                                  ColorsResources.black,
                                                ],
                                                transform: GradientRotation(45)
                                            )
                                        ),
                                      ),
                                      child: const Image(
                                        image: AssetImage("rectircle_shape.png"),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                            padding: const EdgeInsets.all(1.9),
                                            child: WidgetMask(
                                                blendMode: BlendMode.srcATop,
                                                childSaveLayer: true,
                                                mask /* Original Image */: Container(
                                                  decoration: const BoxDecoration(
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            ColorsResources.black,
                                                            ColorsResources.premiumDark,
                                                          ],
                                                          transform: GradientRotation(45)
                                                      )
                                                  ),
                                                ),
                                                child: const Image(
                                                  image: AssetImage("rectircle_shape.png"),
                                                )
                                            )
                                        )
                                    ),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                            child: Text(
                                                StringsResources.historyTitle(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: ColorsResources.premiumLight,
                                                    fontSize: 19
                                                )
                                            )
                                        )
                                    )
                                  ],
                                )
                            )
                        )
                    ),
                    /* End - Title */

                  ],
                ),
                /* End - Back */

                /* Start - Purchase Plan Picker */
                const Positioned(
                    right: 19,
                    top: 19,
                    child: PurchasePlanPicker()
                ),
                /* End - Purchase Plan Picker */

              ],
            )
        )
    );
  }

  void retrieveSignalsHistory() {
    debugPrint("Retrieve Latest Signals Details");

    FirebaseFirestore.instance
        .collection("SachielsSignals")
        .limit(73)
        .orderBy("tradeTimestamp")
        .get().then((QuerySnapshot querySnapshot) {

          List<SignalsDataStructure> signalsDataStructure = [];

          for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

            signalsDataStructure.add(SignalsDataStructure(queryDocumentSnapshot));

          }

          prepareSignalsHistoryItems(signalsDataStructure);

        },
        onError: (e) => {

        });

  }

  void prepareSignalsHistoryItems(List<SignalsDataStructure> signalsDataStructure) {

    List<Widget> signalHistoryItem = [];

    for (SignalsDataStructure signalDataStructureItem in signalsDataStructure) {

      signalHistoryItem.add(signalDataStructureItemView(signalDataStructureItem));

    }

    int gridColumnCount = (displayWidth(context) / 359).round();

    setState(() {

      allSignalsHistory = Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridColumnCount,
            childAspectRatio: 1,
            crossAxisSpacing: 19.0,
            mainAxisSpacing: 19.0,
          ),
          padding: const EdgeInsets.fromLTRB(19, 101, 19, 37),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: signalHistoryItem,
        )
      );

    });

  }

  Widget signalDataStructureItemView(SignalsDataStructure signalsDataStructure) {

    debugPrint("Overview Details: ${signalsDataStructure.signalsDocumentData}");

    var tradeCommandColor = ColorsResources.sellColor;

    if (signalsDataStructure.tradeCommand() == "Buy") {

      tradeCommandColor = ColorsResources.buyColor;

    }

    DateTime tradeTimestamp = DateTime.fromMillisecondsSinceEpoch(int.parse(signalsDataStructure.tradeTimestamp()));

    var tradeTimestampText = tradeTimestamp.toString();

    try {

      tradeTimestampText = "${DateFormat("EEEE").format(tradeTimestamp)}, ${DateFormat("MMMM").format(tradeTimestamp)} ${tradeTimestamp.day}, ${tradeTimestamp.year}"
          " - "
          "${tradeTimestamp.hour}:${tradeTimestamp.minute}:${tradeTimestamp.second}";

    } catch (exception) {}

    return SizedBox(
        height: 373,
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
                    width: 359,
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

              /* Start - Trade Information */
              Container(
                  height: 399,
                  width: 359,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              /* Start - Trade Command */
                              Column(
                                children: [
                                  Text(
                                    signalsDataStructure.tradeCommand().toUpperCase(),
                                    style: TextStyle(
                                        color: tradeCommandColor,
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
                                    signalsDataStructure.tradeMarketPair(),
                                    style: const TextStyle(
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
                                  padding: const EdgeInsets.fromLTRB(9, 0, 0, 0),
                                  child: Text(
                                    signalsDataStructure.tradeAccuracyPercentage().replaceAll("%", ""),
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
                          Container(
                            width: 359,
                            height: 113,
                            padding: const EdgeInsets.fromLTRB(0, 37, 0, 0),
                            alignment: Alignment.center,
                            child: Text(
                              signalsDataStructure.tradeProfitAmount().replaceAll("\$", ""),
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
                          ),
                        ],
                      )
                  )
              ),
              /* End - Trade Information */

              /* Start - Trade Time */
              Positioned(
                left: 13,
                bottom: 7,
                child: Container(
                  width: 359,
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
    );
  }

}