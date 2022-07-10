
/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/9/22, 6:12 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/ui/system_bars.dart';

class DashboardInterface extends StatefulWidget {

  const DashboardInterface({Key? key}) : super(key: key);

  @override
  State<DashboardInterface> createState() => _DashboardInterfaceState();
}
class _DashboardInterfaceState extends State<DashboardInterface> {

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.dark, ColorsResources.dark);

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
            backgroundColor: ColorsResources.dark,
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            }),
          ),
          home: Scaffold(
              backgroundColor: ColorsResources.dark,
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
                      gradient: LinearGradient(
                          colors: [
                            ColorsResources.primaryColorDarkest,
                            ColorsResources.primaryColorDarkest,
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          transform: GradientRotation(45),
                          tileMode: TileMode.clamp
                      ),
                    ),
                  ),
                  // Rounded Borders
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(17),
                            topRight: Radius.circular(17),
                            bottomLeft: Radius.circular(17),
                            bottomRight: Radius.circular(17)),
                        border: Border(
                            top: BorderSide(
                              color: ColorsResources.dark,
                              width: 7,
                            ),
                            bottom: BorderSide(
                              color: ColorsResources.dark,
                              width: 7,
                            ),
                            left: BorderSide(
                              color: ColorsResources.dark,
                              width: 7,
                            ),
                            right: BorderSide(
                              color: ColorsResources.dark,
                              width: 7,
                            )
                        ),
                        color: Colors.transparent
                    ),
                  ),
                ],
              )
          )
      )
    );
  }

}
