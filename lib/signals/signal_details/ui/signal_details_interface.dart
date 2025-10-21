/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/16/22, 9:59 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

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
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:url_launcher/url_launcher.dart';
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
      colorOne: ColorsResources.black,
      colorTwo: ColorsResources.black,
      size: 73,
    ),
  );

  Widget signalValidation = Container();

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

    prepareSignalDetails(widget.signalsDataStructure);

    validateSignal();

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorsResources.black,
          body: Stack(
            children: [

              /* Start - Gradient Background - Dark */
              Container(
                decoration: const BoxDecoration(
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
                          image: AssetImage("assets/logo.png"),
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
                                  image: AssetImage("assets/back_icon.png"),
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
                                      image: AssetImage("assets/rectircle_shape.png"),
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
                                                image: AssetImage("assets/rectircle_shape.png"),
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

              Positioned(
                  bottom: 37,
                  right: 19,
                  child: signalValidation
              )

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
            padding: const EdgeInsets.fromLTRB(19, 113, 19, 113),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [

              Align(
                alignment: Alignment.center,
                child: overviewDetailsView(signalsDataStructure),
              ),

              const Divider(
                height: 19,
                color: Colors.transparent,
              ),

              Align(
                alignment: Alignment.center,
                child: technicalDetailsView(signalsDataStructure),
              ),

            ],
          )
        );

      });

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

  void validateSignal() async {

    signalValidation = SizedBox(
      height: 59,
      width: 59,
      child: InkWell(
        onTap: () {

          launchUrl(Uri.parse(StringsResources.marketChartLink(widget.signalsDataStructure.tradeMarketPair())),
              mode: LaunchMode.externalApplication);

        },
        child: const Image(
          image: AssetImage("assets/validated_icon.png"),
        ),
      ),
    );

  }

}