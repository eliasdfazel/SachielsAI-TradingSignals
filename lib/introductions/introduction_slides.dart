/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/5/22, 1:32 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:sachiel/dashboard/ui/dashboard_interface.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/ui/display.dart';

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  runApp(
      const MaterialApp(
          home: IntroductionSlides()
      )
  );

}

class IntroductionSlides extends StatefulWidget {

  const IntroductionSlides({Key? key}) : super(key: key);

  @override
  State<IntroductionSlides> createState() => IntroductionSlidesState();

}
class IntroductionSlidesState extends State<IntroductionSlides> {

  LiquidController liquidController = LiquidController();

  @override
  void initState() {
    super.initState();
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

                    /* Start - Introduction Liquid Slide */
                    ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: LiquidSwipe(
                        liquidController: liquidController,
                        onPageChangeCallback: (position) {

                        },
                        fullTransitionValue: 777,
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
                        positionSlideIcon: 0.5,
                        waveType: WaveType.liquidReveal,
                        pages: [

                          firstSlideIntroduction(),

                          secondSlideIntroduction(),

                          thirdSlideIntroduction(),

                        ],
                      ),
                    ),
                    /* End - Introduction Liquid Slide */

                  ],
                )
            )
        )
    );
  }

  Widget firstSlideIntroduction() {

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

        ],
      )
    );
  }

  Widget secondSlideIntroduction() {

    return Container(
      color: ColorsResources.premiumDark,
        child: Stack(
          children: [

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

          ],
        )
    );
  }

  Widget thirdSlideIntroduction() {

    return Container(
      color: ColorsResources.primaryColor,
        child: Stack(
          children: [

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

            /* Start - Introduction Skip */
            Positioned(
              bottom: 19,
              right: 31,
              child: InkWell(
                  onTap: () {

                    navigateTo(context, const DashboardInterface());

                  },
                  child: SizedBox(
                    width: 199,
                    child: Image(
                      image: AssetImage("continue_icon.png"),
                      fit: BoxFit.cover,
                    ),
                  )
              ),
            )
            /* End - Introduction Skip */

          ],
        )
    );
  }

}