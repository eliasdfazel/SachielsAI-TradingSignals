/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 12/6/22, 6:59 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:blur/blur.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:sachiel/dashboard/ui/dashboard_interface.dart';
import 'package:sachiel/in_application_store/ui/sachiel_digital_store.dart';
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

  double contentHeight = double.infinity;
  double contentWidth = double.infinity;

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

    BackButtonInterceptor.add(aInterceptor);

    retrieveRemoteConfigurations();

  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(milliseconds: 777), () {

      FlutterNativeSplash.remove();

    });

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
                            height: calculatePercentage(79, displayHeight()),
                            width: calculatePercentage(79, displayWidth()),
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

      createFileOfTexts(StringsResources.fileSliderTime, "TXT", widget.firebaseRemoteConfig!.getString(RemoteConfigurations.sliderTime));

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

    List<Widget> sliderContent = [

      firstSlideIntroduction(),

      secondSlideIntroduction(),

      thirdSlideIntroduction(),

    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(17),
      child: LiquidSwipe(
        liquidController: liquidController,
        onPageChangeCallback: (position) {

          if (position == sliderContent.length) {



          } else {



          }

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
        pages: sliderContent
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
                opacity: 0.31,
                child: Image(
                  image: AssetImage("assets/logo.png"),
                ),
              ),
            ),
            /* End - Branding Transparent */

            /* Start - Browser */
            Padding(
              padding: const EdgeInsets.fromLTRB(19, 113, 73, 113),
              child: Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Blur(
                        blur: 7,
                        blurColor: ColorsResources.light,
                        colorOpacity: 0.13,
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
                opacity: 0.31,
                child: Image(
                  image: AssetImage("assets/logo.png"),
                ),
              ),
            ),
            /* End - Branding Transparent */

            /* Start - Browser */
            Padding(
              padding: const EdgeInsets.fromLTRB(19, 113, 73, 113),
              child: Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Blur(
                        blur: 7,
                        blurColor: ColorsResources.light,
                        colorOpacity: 0.13,
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
                opacity: 0.31,
                child: Image(
                  image: AssetImage("assets/logo.png"),
                ),
              ),
            ),
            /* End - Branding Transparent */

            /* Start - Browser */
            Padding(
              padding: const EdgeInsets.fromLTRB(19, 113, 73, 113),
              child: Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Blur(
                        blur: 7,
                        blurColor: ColorsResources.light,
                        colorOpacity: 0.13,
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
            ),
            /* End - Browser */

            /* Start - Skip */
            Positioned(
              bottom: 53,
              left: 19,
              child: SizedBox(
                width: 171,
                child: InkWell(
                  onTap: () {

                    createFileOfTexts(StringsResources.fileNameSliderTime, "TXT", DateTime.now().millisecondsSinceEpoch.toString()).then((value) => {

                      fileExist(StringsResources.filePurchasingPlan).then((alreadyPurchased) => {

                        if (alreadyPurchased) {

                          navigateTo(context, const DashboardInterface())

                        } else {

                          navigateTo(context, SachielsDigitalStore(topPadding: 0))

                        }

                      })

                    });

                  },
                  child: const Image(
                    image: AssetImage("assets/continue_icon.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
            /* End - Skip */

          ],
        )
    );
  }

}