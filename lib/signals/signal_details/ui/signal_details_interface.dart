/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/16/22, 8:53 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';
import 'dart:typed_data';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sachiel/dashboard/ui/sections/purchase_plan_picker.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/signals/data/signals_data_structure.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/io/file_io.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:sachiel/utils/ui/system_bars.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widget_mask/widget_mask.dart';

class SignalsDetailsInterface extends StatefulWidget {

  SignalsDataStructure signalsDataStructure;

  SignalsDetailsInterface({Key? key, required this.signalsDataStructure}) : super(key: key);

  @override
  State<SignalsDetailsInterface> createState() => _SignalsDetailsInterfaceState();

}
class _SignalsDetailsInterfaceState extends State<SignalsDetailsInterface> {

  Widget signalDetailsPlaceholder = Container(
    alignment: Alignment.center,
    child: LoadingAnimationWidget.staggeredDotsWave(
      colorOne: ColorsResources.premiumLight,
      colorTwo: ColorsResources.primaryColor,
      size: 73,
    ),
  );

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    navigatePop(context);

    return true;
  }

  @override
  void dispose() {
    super.dispose();

    BackButtonInterceptor.remove(aInterceptor);

  }

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(aInterceptor);

    changeColor(ColorsResources.black, ColorsResources.black);

    prepareSignalDetails(widget.signalsDataStructure);

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
                  ),
                ),
                /* End - Gradient Background - Dark */

                /* Start - Branding Transparent */
                Align(
                  alignment: Alignment.center,
                  child: Opacity(
                      opacity: 0.1,
                      child: Transform.scale(
                          scale: 1.7,
                          child: const Image(
                            image: AssetImage("logo.png"),
                          )
                      )
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
                        height: calculatePercentage(99, displayHeight()),
                        width: calculatePercentage(99, displayWidth()),
                      ),
                    )
                ),
                /* End - Gradient Background - Golden */

                /* Start - Content */
                signalDetailsPlaceholder,
                /* End - Content */

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
                                                StringsResources.detailsTitle(),
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

  void prepareSignalDetails(SignalsDataStructure signalsDataStructure) {

    Future.delayed(const Duration(milliseconds: 333), () {

      setState(() {

        signalDetailsPlaceholder = Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(19, 113, 19, 37),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [

              overviewDetailsView(signalsDataStructure),

              const Divider(
                height: 13,
              ),

              technicalDetailsView(signalsDataStructure),

              const Divider(
                height: 13,
              ),

              shareDetailsView(signalsDataStructure)

            ],
          )
        );

      });

    });

  }

  Widget overviewDetailsSnapshot(SignalsDataStructure signalsDataStructure) {
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

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: SizedBox(
            height: 399,
            width: 351,
            child: Stack(
                children: [
                  Positioned(
                      top: -99,
                      right: 33,
                      child: Text(
                        "%",
                        style: TextStyle(
                            color: ColorsResources.black.withOpacity(0.73),
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
                              color: ColorsResources.black.withOpacity(0.73),
                              fontSize: 239,
                              fontFamily: "Handwriting"
                          ),
                        ),
                      )
                  ),
                  Container(
                      height: 399,
                      width: 351,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(19),
                              topRight: Radius.circular(19),
                              bottomLeft: Radius.circular(19),
                              bottomRight: Radius.circular(19)
                          ),
                          border: const Border(
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
                          color: ColorsResources.premiumDark.withOpacity(0.79)
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
                                        style: TextStyle(
                                            color: ColorsResources.white,
                                            fontSize: 101,
                                            shadows: [
                                              Shadow(
                                                  color: ColorsResources.black.withOpacity(0.79),
                                                  blurRadius: 13,
                                                  offset: const Offset(0.0, 3.0)
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
                                height: 119,
                                padding: const EdgeInsets.fromLTRB(0, 37, 0, 0),
                                alignment: Alignment.center,
                                child: Text(
                                  signalsDataStructure.tradeProfitAmount().replaceAll("\$", ""),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: ColorsResources.premiumLight,
                                      fontSize: 79,
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

  Widget overviewDetailsView(SignalsDataStructure signalsDataStructure) {
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

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: SizedBox(
            height: 351,
            width: 359,
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
                                padding: const EdgeInsets.fromLTRB(0, 31, 0, 0),
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

  Widget technicalDetailsView(SignalsDataStructure signalsDataStructure) {

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

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: SizedBox(
            height: 351,
            width: 359,
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
                                            image: AssetImage("point_icon.png"),
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
                                            image: AssetImage("point_icon.png"),
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
                                            image: AssetImage("point_icon.png"),
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
                                            image: const AssetImage("point_icon.png"),
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
                                            image: const AssetImage("point_icon.png"),
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
                                            image: const AssetImage("point_icon.png"),
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
                      width: 359,
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

  Widget shareDetailsView(SignalsDataStructure signalsDataStructure) {

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: SizedBox(
            height: 351,
            width: 359,
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

                  ClipRRect(
                    borderRadius: BorderRadius.circular(19),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () {
                          debugPrint("Sharing Signal Details");

                          ScreenshotController screenshotController = ScreenshotController();

                          screenshotController.captureFromWidget(overviewDetailsSnapshot(signalsDataStructure)).then((Uint8List? capturedImage) {

                            if (capturedImage != null) {
                              debugPrint("Sharing Signal Details Snapshot");

                              shareSignalSnapshot(signalsDataStructure, capturedImage);

                            }

                          }).catchError((onError) {
                            debugPrint(onError);

                          });

                        },
                        child: Container(
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
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(0, 27, 0, 0),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Image(
                                  image: AssetImage("share_icon.png"),
                                  height: 233,
                                  width: 233,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 31,
                    left: 13,
                    right: 13,
                    child: Text(
                      StringsResources.shareSachiel(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorsResources.light,
                          fontSize: 23,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 1.7,
                          shadows: [
                            Shadow(
                                color: ColorsResources.goldenColor.withOpacity(0.31),
                                blurRadius: 7,
                                offset: const Offset(0, 3)
                            )
                          ]
                      ),
                    ),
                  )

                ]
            )
        )
    );
  }

  void shareSignalSnapshot(SignalsDataStructure signalsDataStructure, Uint8List capturedImage) async {

    File snapshotFile = await createFileOfBytes("SachielsSignals", "PNG", capturedImage);

    Share.shareFiles([snapshotFile.path], text: "Trading Signal Powered By #SachielAI @sachielssignals"
        "\n"
        "${signalsDataStructure.tradeCommand()} ${signalsDataStructure.tradeMarketPair()}"
        "\n\n\n"
        "#GeeksEmpire"
        "\n"
        "#TradingSignals");

  }

}