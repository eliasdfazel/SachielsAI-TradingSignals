/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 9/2/22, 8:42 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sachiel/in_application_store/data/plans_data_structure.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:sachiel/utils/ui/system_bars.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_mask/widget_mask.dart';

class SachielsDigitalStore extends StatefulWidget {

  const SachielsDigitalStore({Key? key}) : super(key: key);

  @override
  State<SachielsDigitalStore> createState() => _SachielsDigitalStoreState();

}
class _SachielsDigitalStoreState extends State<SachielsDigitalStore> {

  Widget allPurchasingPlans = Container(
    alignment: Alignment.center,
    child: LoadingAnimationWidget.staggeredDotsWave(
      colorOne: ColorsResources.premiumLight,
      colorTwo: ColorsResources.primaryColor,
      size: 73,
    ),
  );

  @override
  void initState() {

    retrievePurchasingPlans();

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

                allPurchasingPlans,

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
                                                StringsResources.storeTitle(),
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
                Positioned(
                    right: 19,
                    top: 19,
                    child: Container(
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: ColorsResources.primaryColorLighter,
                                blurRadius: 51,
                                spreadRadius: 0,
                                offset: Offset(0, 0)
                            )
                          ]
                      ),
                      child: SizedBox(
                          height: 59,
                          width: 59,
                          child: InkWell(
                              onTap: () async {

                                launchUrl(Uri.parse("https://GeeksEmpire.co/Sachiels/PurchasingPlans"));

                              },
                              child: const Image(
                                image: AssetImage("golden_information_icon.png"),
                              )
                          )
                      ),
                    )
                ),
                /* End - Purchase Plan Picker */

              ],
            )
        )
    );
  }

  void retrievePurchasingPlans() {
    debugPrint("Retrieve Latest Signals Details");

    FirebaseFirestore.instance
        .collection("/Sachiels/Purchasing/Plans")
        .orderBy("purchasingPlanPrice")
        .get().then((QuerySnapshot querySnapshot) {

          List<PlansDataStructure> plansDataStructure = [];

          for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

            plansDataStructure.add(PlansDataStructure(queryDocumentSnapshot));

          }

          if (plansDataStructure.isNotEmpty) {

            prepareSignalsHistoryItems(plansDataStructure);

          }

        },
        onError: (e) => {

        });

  }

  void prepareSignalsHistoryItems(List<PlansDataStructure> plansDataStructure) {

    List<Widget> signalHistoryItem = [];

    for (PlansDataStructure planDataStructureItem in plansDataStructure) {

      signalHistoryItem.add(plansDataStructureItemView(planDataStructureItem));

    }

    setState(() {

      allPurchasingPlans = Padding(
        padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(19, 0, 0, 0),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: signalHistoryItem,
        )
      );

    });

  }

  Widget plansDataStructureItemView(PlansDataStructure plansDataStructure) {
    debugPrint("Plan Details: ${plansDataStructure.plansDocumentData}");

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 37, 31, 0),
      child: SizedBox(
        height: 593,
        width: 373,
        child: InkWell(
            onTap: () {



            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(17),
                  child: Image.network(
                    plansDataStructure.purchasingPlanSnapshot(),
                    height: 373,
                    width: 373,
                    fit: BoxFit.contain,
                  )
                ),

                const Image(
                  image: AssetImage("purchasing_icon.png"),
                  height: 73,
                  width: 373,
                  fit: BoxFit.contain,
                )

              ],
            )
        ),
      )
    );
  }

}