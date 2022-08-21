
/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/21/22, 9:39 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/dashboard/ui/sections/academy_summary.dart';
import 'package:sachiel/dashboard/ui/sections/account_information_overview.dart';
import 'package:sachiel/dashboard/ui/sections/broker_suggestions.dart';
import 'package:sachiel/dashboard/ui/sections/last_signal_details.dart';
import 'package:sachiel/dashboard/ui/sections/latest_signals_overview.dart';
import 'package:sachiel/dashboard/ui/sections/purchase_plan_picker.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:sachiel/utils/ui/system_bars.dart';

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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

  StatefulWidget accountInformationOverview = const AccountInformationOverview();

  StatefulWidget lastSignalDetails = const LastSignalDetails();

  StatefulWidget latestSignalsOverview = const LatestSignalsOverview();

  StatefulWidget academySummaryInterface = const AcademySummaryInterface();

  StatefulWidget brokerSuggestionsInterface = const BrokerSuggestionsInterface();

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

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 37),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: [

                        /* Start - Account Information Overview */
                        accountInformationOverview,
                        /* End - Account Information Overview */

                        /* Start - The Last Signal Details */
                        lastSignalDetails,
                        /* End - The Last Signal Details */

                        /* Start - The Latest Signals Overview */
                        latestSignalsOverview,
                        /* End - The Latest Signals Overview */

                        /* Start - Academy Summary */
                        academySummaryInterface,
                        /* End - Academy Summary */

                        /* Start - Brokers Suggestions */
                        brokerSuggestionsInterface,
                        /* End - Brokers Suggestions */

                      ],
                    ),
                  ),

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
