
/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/11/22, 8:26 PM
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
                fit: StackFit.expand,
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
                  Container(
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
                            ColorsResources.primaryColorLighter.withOpacity(0.91),
                            Colors.transparent,
                          ],
                          center: const Alignment(0.79, -0.87),
                        )
                    ),
                    child: SizedBox(
                      height: calculatePercentage(79, displayHeight(context)),
                      width: calculatePercentage(73, displayWidth(context)),
                    ),
                  ),
                  const Positioned(
                    right: 19,
                    top: 19,
                    child: SizedBox(
                      height: 59,
                      width: 59,
                      child: Image(
                        image: AssetImage("squircle_logo.png"),
                      ),
                    ),
                  ),
                  ListView(
                    padding: const EdgeInsets.fromLTRB(0, 73, 0, 53),
                    physics: const BouncingScrollPhysics(),
                    children: [



                    ],
                  )
                ],
              )
          )
      )
    );
  }

}
