/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/19/22, 6:14 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:sachiel/dashboard/ui/sections/purchase_plan_picker.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:sachiel/utils/ui/system_bars.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:widget_mask/widget_mask.dart';

class DashboardInterface extends StatefulWidget {

  String websiteAddress;

  DashboardInterface({Key? key, required this.websiteAddress}) : super(key: key);

  @override
  State<DashboardInterface> createState() => _SachielBrowserState();

}
class _SachielBrowserState extends State<DashboardInterface> {

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

                    /* Start - Browser */
                    WebView(
                      initialUrl: widget.websiteAddress,
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                    /* End - Browser */

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
                                                child: Marquee(
                                                  text: widget.websiteAddress,
                                                  style: const TextStyle(
                                                    color: ColorsResources.premiumLight,
                                                    fontSize: 19,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  scrollAxis: Axis.horizontal,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  blankSpace: 0.0,
                                                  velocity: 19.0,
                                                  fadingEdgeStartFraction: 0.13,
                                                  fadingEdgeEndFraction: 0.13,
                                                  startAfter: const Duration(milliseconds: 777),
                                                  numberOfRounds: 3,
                                                  pauseAfterRound: const Duration(milliseconds: 500),
                                                  showFadingOnlyWhenScrolling: true,
                                                  startPadding: 13.0,
                                                  accelerationDuration: const Duration(milliseconds: 500),
                                                  accelerationCurve: Curves.linear,
                                                  decelerationDuration: const Duration(milliseconds: 500),
                                                  decelerationCurve: Curves.easeOut,
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
        )
    );
  }

}
