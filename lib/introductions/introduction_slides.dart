/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/16/22, 6:41 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:sachiel/remote/remote_configurations.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/io/file_io.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:widget_mask/widget_mask.dart';

class IntroductionSlides extends StatefulWidget {

  FirebaseRemoteConfig? firebaseRemoteConfig;

  IntroductionSlides({Key? key, firebaseRemoteConfig}) : super(key: key);

  @override
  State<IntroductionSlides> createState() => IntroductionSlidesState();

}
class IntroductionSlidesState extends State<IntroductionSlides> {

  LiquidController liquidController = LiquidController();

  Widget allContent = Container();

  double contentHeight = 379;
  double contentWidth = 179;

  @override
  void initState() {
    super.initState();

    retrieveRemoteConfigurations();

  }

  @override
  Widget build(BuildContext context) {

    contentHeight = calculatePercentage(91, displayHeight(context));
    contentWidth = calculatePercentage(91, displayWidth(context));

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
                            height: calculatePercentage(79, displayHeight(context)),
                            width: calculatePercentage(79, displayWidth(context)),
                          ),
                        )
                    ),
                    /* End - Gradient Background - Golden */

                    allContent,

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
                                                    StringsResources.academyInformation(),
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

                  ],
                )
            )
        )
    );
  }

  void retrieveRemoteConfigurations() {

    if (widget.firebaseRemoteConfig != null) {

      createFileOfTexts("SliderTime", ".TXT", widget.firebaseRemoteConfig!.getString(RemoteConfigurations.sliderTime));

      /* Start - Introduction Liquid Slide */
      setState(() {

        allContent = setupSlider();

      });
      /* End - Introduction Liquid Slide */

    } else {

      /* Start - Introduction Liquid Slide */
      setState(() {

        allContent = setupSlider();

      });
      /* End - Introduction Liquid Slide */

    }

  }

  Widget setupSlider() {

    return ClipRRect(
      borderRadius: BorderRadius.circular(17),
      child: LiquidSwipe(
        liquidController: liquidController,
        onPageChangeCallback: (position) {

        },
        currentUpdateTypeCallback: (updateType) {

        },
        fullTransitionValue: 999,
        enableSideReveal: true,
        enableLoop: true,
        ignoreUserGestureWhileAnimating: true,
        slideIconWidget: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: 27,
            color: ColorsResources.light,
            shadows: [
              Shadow(
                  color: ColorsResources.light.withOpacity(0.37),
                  blurRadius: 7,
                  offset: const Offset(3, 0)
              )
            ],
          ),
        ),
        positionSlideIcon: 0.91,
        waveType: WaveType.liquidReveal,
        pages: [

          firstSlideIntroduction(),

          secondSlideIntroduction(),

          thirdSlideIntroduction(),

        ],
      ),
    );
  }

  Widget firstSlideIntroduction() {

    String htmlContent = ".<b>.</b><big>.</big>";

    if (widget.firebaseRemoteConfig != null) {

      htmlContent = widget.firebaseRemoteConfig!.getString(RemoteConfigurations.slideTwoContent);

    } else {

      htmlContent = StringsResources.sliderOneContent();

    }

    return Container(
        color: ColorsResources.dark,
        child: Stack(
          children: [

            /* Start - Branding Transparent */
            const Align(
              alignment: Alignment.center,
              child: Opacity(
                opacity: 0.13,
                child: Image(
                  image: AssetImage("logo.png"),
                ),
              ),
            ),
            /* End - Branding Transparent */

            /* Start - Browser */
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 0, 73, 0),
              child: Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Blur(
                        blur: 13,
                        blurColor: ColorsResources.light,
                        colorOpacity: 0.07,
                        overlay: Padding(
                          padding: const EdgeInsets.fromLTRB(13, 31, 13, 31),

                          child: Html(
                              data: htmlContent,
                              style: {
                                'p': Style(
                                    color: ColorsResources.light
                                )
                              }
                          )
                        ),
                        child: SizedBox(
                          height: contentHeight,
                          width: contentWidth,
                        ),
                      )
                  )
              ),
            )
            /* End - Browser */

          ],
        )
    );
  }

  Widget secondSlideIntroduction() {

    String htmlContent = ".<b>.</b><big>.</big>";

    if (widget.firebaseRemoteConfig != null) {

      htmlContent = widget.firebaseRemoteConfig!.getString(RemoteConfigurations.slideOneContent);

    } else {

      htmlContent = StringsResources.sliderTwoContent();

    }

    return Container(
        color: ColorsResources.premiumDark,
        child: Stack(
          children: [

            /* Start - Branding Transparent */
            const Align(
              alignment: Alignment.center,
              child: Opacity(
                opacity: 0.13,
                child: Image(
                  image: AssetImage("logo.png"),
                ),
              ),
            ),
            /* End - Branding Transparent */

            /* Start - Browser */
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 0, 73, 0),
              child: Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Blur(
                        blur: 13,
                        blurColor: ColorsResources.light,
                        colorOpacity: 0.07,
                        overlay: Padding(
                          padding: const EdgeInsets.fromLTRB(13, 31, 13, 31),
                          child: Html(
                              data: htmlContent,
                              style: {
                                'p': Style(
                                    color: ColorsResources.light
                                )
                              }
                          ),
                        ),
                        child: SizedBox(
                          height: contentHeight,
                          width: contentWidth,
                        ),
                      )
                  )
              ),
            )
            /* End - Browser */

          ],
        )
    );
  }

  Widget thirdSlideIntroduction() {

    String htmlContent = ".<b>.</b><big>.</big>";

    if (widget.firebaseRemoteConfig != null) {

      htmlContent = widget.firebaseRemoteConfig!.getString(RemoteConfigurations.slideThreeContent);

    } else {

      htmlContent = StringsResources.sliderThreeContent();

    }

    return Container(
        color: ColorsResources.primaryColor,
        child: Stack(
          children: [

            /* Start - Branding Transparent */
            const Align(
              alignment: Alignment.center,
              child: Opacity(
                opacity: 0.13,
                child: Image(
                  image: AssetImage("logo.png"),
                ),
              ),
            ),
            /* End - Branding Transparent */

            /* Start - Browser */
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 0, 73, 0),
              child: Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Blur(
                        blur: 13,
                        blurColor: ColorsResources.light,
                        colorOpacity: 0.07,
                        overlay: Padding(
                          padding: const EdgeInsets.fromLTRB(13, 31, 13, 31),
                          child: Html(
                              data: htmlContent,
                              style: {
                                'p': Style(
                                    color: ColorsResources.dark
                                )
                              }
                          ),
                        ),
                        child: SizedBox(
                          height: contentHeight,
                          width: contentWidth,
                        ),
                      )
                  )
              ),
            )
            /* End - Browser */

          ],
        )
    );
  }

}