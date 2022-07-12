
/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/12/22, 2:11 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:sachiel/utils/ui/system_bars.dart';
import 'package:widget_mask/widget_mask.dart';

void main() async {

  runApp(
      const MaterialApp(
          home: DashboardInterface()
      )
  );

}

class DashboardInterface extends StatefulWidget {

  const DashboardInterface({Key? key}) : super(key: key);

  @override
  State<DashboardInterface> createState() => _DashboardInterfaceState();
}
class _DashboardInterfaceState extends State<DashboardInterface> {

  String profileName = StringsResources.sachielAI();
  Widget profileImage = const Image(
    image: AssetImage("cyborg_girl.jpg"),
    fit: BoxFit.cover,
  );

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.black, ColorsResources.black);

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: MaterialApp(
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
              body:Stack(
                children: [
                  // Gradient Background
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(17),
                          topRight: Radius.circular(17),
                          bottomLeft: Radius.circular(17),
                          bottomRight: Radius.circular(17)
                      ),
                      color: ColorsResources.black,
                    ),
                  ),
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
                        height: calculatePercentage(79, displayHeight(context)),
                        width: calculatePercentage(79, displayWidth(context)),
                      ),
                    )
                  ),
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
                      child: const SizedBox(
                          height: 59,
                          width: 59,
                          child: InkWell(
                              child: Image(
                                image: AssetImage("squircle_logo.png"),
                              )
                          )
                      ),
                    )
                  ),
                  ListView(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 73),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      /* Start - Account Information */
                      Row(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(19, 19, 0, 0),
                                  child: SizedBox(
                                      height: 59,
                                      width: 59,
                                      child: Stack(
                                        children: [
                                          WidgetMask(
                                            blendMode: BlendMode.srcATop,
                                            childSaveLayer: true,
                                            mask /* Original Image */: Container(
                                              decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        ColorsResources.premiumLight,
                                                        ColorsResources.primaryColorLightest,
                                                      ],
                                                      transform: GradientRotation(45)
                                                  )
                                              ),
                                            ),
                                            child: const Image(
                                              image: AssetImage("squircle_shape.png"),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.all(1.7),
                                              child: WidgetMask(
                                                blendMode: BlendMode.srcATop,
                                                childSaveLayer: true,
                                                mask /* Original Image */: profileImage,
                                                child: const Image(
                                                  image: AssetImage("squircle_shape.png"),
                                                ),
                                              )
                                          )
                                        ],
                                      )
                                  )
                              )
                          ),
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
                                                        ColorsResources.premiumLight,
                                                        ColorsResources.primaryColorLightest,
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
                                                              ColorsResources.premiumDarkLighter,
                                                              ColorsResources.premiumLight,
                                                            ],
                                                            transform: GradientRotation(45)
                                                        )
                                                    ),
                                                  ),
                                                  child: const Image(
                                                    image: AssetImage("rectircle_shape.png"),
                                                  ),
                                                )
                                            )
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                              child: Text(
                                                profileName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: ColorsResources.premiumDark,
                                                    fontSize: 19
                                                ),
                                              ),
                                            )
                                          )
                                        ],
                                      )
                                  )
                              )
                          ),
                        ],
                      ),
                      /* End - Account Information */



                    ],
                  )
                ],
              )
          )
      )
    );
  }

}
