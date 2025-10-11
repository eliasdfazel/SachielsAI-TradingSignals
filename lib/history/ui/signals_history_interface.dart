/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/18/22, 4:16 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sachiel/dashboard/ui/sections/purchase_plan_picker.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/store/utils/digital_store_utils.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:widget_mask/widget_mask.dart';

import '../../signals/data/signals_data_structure.dart';

class SignalsHistoryInterface extends StatefulWidget {

  const SignalsHistoryInterface({Key? key}) : super(key: key);

  @override
  State<SignalsHistoryInterface> createState() => _SignalsHistoryInterfaceState();

}
class _SignalsHistoryInterfaceState extends State<SignalsHistoryInterface> with TickerProviderStateMixin {

  DigitalStoreUtils digitalStoreUtils = DigitalStoreUtils();

  List<SignalsDataStructure> signalsDataStructure = [];

  Widget allSignalsHistory = Container(
    alignment: Alignment.center,
    child: LoadingAnimationWidget.staggeredDotsWave(
      colorOne: ColorsResources.premiumLight,
      colorTwo: ColorsResources.primaryColor,
      size: 73,
    ),
  );

  List<Widget> allMarketsTypes = [];

  bool filterVisibility = false;

  BuildContext? popupContext;

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    navigatePop(context);

    return true;
  }

  @override
  void dispose() {

    BackButtonInterceptor.remove(aInterceptor);

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    retrieveSignalsHistory();

    BackButtonInterceptor.add(aInterceptor);

    prepareMarketsTypes();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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

            /* Start - Purchase Plan Picker */
            Positioned(
              right: 19,
              bottom: 37,
              child: Visibility(
                  visible: filterVisibility,
                  child: SizedBox(
                      height: 59,
                      width: 59,
                      child: InkWell(
                          onTap: () {

                            setupAdvancedFilter();

                          },
                          child: const Image(
                            image: AssetImage("assets/filter_icon.png"),
                          )
                      )
                  )
              ),
            ),
            /* End - Purchase Plan Picker */

          ],
        )
    );
  }

  void retrieveSignalsHistory() async {
    debugPrint("Retrieve Latest Signals Details");

    String purchasingTier = await digitalStoreUtils.purchasedTier();

    if (purchasingTier.isNotEmpty) {

      FirebaseFirestore.instance
          .collection("/Sachiels"
          "/Signals"
          "/$purchasingTier")
          .limit(73)
          .orderBy("tradeTimestamp")
          .get().then((QuerySnapshot querySnapshot) {

            for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

              signalsDataStructure.add(SignalsDataStructure(queryDocumentSnapshot));

            }

            prepareSignalsHistoryItems(signalsDataStructure);

            setState(() {

              filterVisibility = true;

            });

          },
          onError: (e) => {

          });

    }

  }

  void prepareSignalsHistoryItems(List<SignalsDataStructure> signalsDataStructure) {

    List<Widget> signalHistoryItem = [];

    for (SignalsDataStructure signalDataStructureItem in signalsDataStructure) {

      signalHistoryItem.add(signalDataStructureItemView(signalDataStructureItem));

    }

    int gridColumnCount = (displayLogicalWidth(context) / 359).round();

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
          padding: const EdgeInsets.fromLTRB(19, 101, 19, 119),
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
    double tradeCommandFontSize = 87;

    if (signalsDataStructure.tradeCommand() == "Buy") {

      tradeCommandColor = ColorsResources.buyColor;
      tradeCommandFontSize = 97;

    }

    DateTime tradeTimestamp = DateTime.fromMillisecondsSinceEpoch(int.parse(signalsDataStructure.tradeTimestamp()));

    var tradeTimestampText = tradeTimestamp.toString();

    try {

      tradeTimestampText = "${DateFormat("EEEE").format(tradeTimestamp)}, ${DateFormat("MMMM").format(tradeTimestamp)} ${tradeTimestamp.day}, ${tradeTimestamp.year}"
          " - "
          "${tradeTimestamp.hour}:${tradeTimestamp.minute}:${tradeTimestamp.second}";

    } catch (exception) {}

    return Center(
      child: SizedBox(
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
                                                color: ColorsResources.black.withOpacity(0.3),
                                                blurRadius: 19,
                                                offset: const Offset(0, 5)
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
                              alignment: Alignment.centerLeft,
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
      )
    );
  }

  void prepareMarketsTypes() async {

    StringsResources.marketsTypes().forEach((element) {

      allMarketsTypes.add(Padding(
        padding: const EdgeInsets.fromLTRB(0, 7, 0, 3),
        child: SizedBox(
          height: 53,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(19),
            child: Material(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              child: InkWell(
                  splashColor: ColorsResources.lightestYellow.withOpacity(0.3),
                  splashFactory: InkRipple.splashFactory,
                  onTap: () {

                    processFilteringSignals(element);

                    if (popupContext != null) {

                      Future.delayed(const Duration(milliseconds: 379), () {

                        Navigator.pop(popupContext!);

                      });

                    }

                  },
                  onLongPress: () {

                    resetSignalsHistory();

                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                        gradient: const LinearGradient(
                            colors: [
                              ColorsResources.dark,
                              ColorsResources.black,
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            transform: GradientRotation(45),
                            tileMode: TileMode.clamp
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                element,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: ColorsResources.premiumLight,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal
                                ),
                              )
                          )
                      )
                  )
              )
            )
          )
        )
      ));

    });

  }

  void setupAdvancedFilter() {

    if (allMarketsTypes.isNotEmpty) {

      AnimationController animationController = BottomSheet.createAnimationController(this);
      animationController.duration = const Duration(milliseconds: 199);
      animationController.reverseDuration = const Duration(milliseconds: 199);

      showModalBottomSheet(
          context: context,
          enableDrag: true,
          isDismissible: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(19))
          ),
          elevation: 0,
          transitionAnimationController: animationController,
          barrierColor: ColorsResources.black.withOpacity(0.51),
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {

            popupContext = context;

            return Container(
                height: 357,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(13, 0, 13, 19),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  gradient: const LinearGradient(
                      colors: [
                        ColorsResources.dark,
                        ColorsResources.black,
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      transform: GradientRotation(45),
                      tileMode: TileMode.clamp
                  ),
                ),
                child: ListView(
                    padding: const EdgeInsets.fromLTRB(13, 3, 13, 7),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: allMarketsTypes
                )
            );
          }
      );

    }

  }

  void processFilteringSignals(String filterMarketType) {

    List<SignalsDataStructure> filteredSignalsDataStructure = [];

    for (SignalsDataStructure aSignalsDataStructure in signalsDataStructure) {

      if (aSignalsDataStructure.tradeMarketType() == filterMarketType) {

        filteredSignalsDataStructure.add(aSignalsDataStructure);

      }

    }

    if (filteredSignalsDataStructure.isNotEmpty) {

      prepareSignalsHistoryItems(filteredSignalsDataStructure);

    } else {

      Fluttertoast.showToast(
          msg: StringsResources.errorNoSignalText(filterMarketType),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorsResources.dark,
          textColor: ColorsResources.light,
          fontSize: 13.0
      );

    }

  }

  void resetSignalsHistory() {

    List<SignalsDataStructure> filteredSignalsDataStructure = [];

    for (SignalsDataStructure aSignalsDataStructure in signalsDataStructure) {

      filteredSignalsDataStructure.add(aSignalsDataStructure);

    }

    prepareSignalsHistoryItems(filteredSignalsDataStructure);

  }

}