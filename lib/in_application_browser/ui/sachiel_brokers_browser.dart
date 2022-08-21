/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/21/22, 8:45 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sachiel/broker_suggestions/data/broker_data_structure.dart';
import 'package:sachiel/dashboard/ui/sections/purchase_plan_picker.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:sachiel/utils/ui/system_bars.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:widget_mask/widget_mask.dart';

class SachielBrokersBrowser extends StatefulWidget {

  BrokersDataStructure brokersDataStructure;

  SachielBrokersBrowser({Key? key, required this.brokersDataStructure}) : super(key: key);

  @override
  State<SachielBrokersBrowser> createState() => _SachielBrokersBrowserState();

}
class _SachielBrokersBrowserState extends State<SachielBrokersBrowser> {

  bool loadingAnimationVisibility = true;

  String websiteAddress = "";

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.black, ColorsResources.black);

    websiteAddress = "${widget.brokersDataStructure.brokerLink()}?utm_source=sachielssignals&utm_medium=sachielssignals";

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
                ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: WebView(
                      initialUrl: websiteAddress,
                      javascriptMode: JavascriptMode.unrestricted,
                      backgroundColor: ColorsResources.dark,
                      onPageFinished: (_) {

                        setState(() {

                          loadingAnimationVisibility = false;

                        });

                      },
                    )
                ),
                /* End - Browser */

                Align(
                  alignment: Alignment.center,
                  child: Visibility(
                      visible: loadingAnimationVisibility,
                      child: Container(
                        height: 399,
                        width: 351,
                        alignment: Alignment.center,
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          colorOne: ColorsResources.premiumLight,
                          colorTwo: ColorsResources.primaryColor,
                          size: 73,
                        )
                      )
                  )
                ),

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
                                                StringsResources.brokersTitle(),
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

              ],
            )
        )
    );
  }



}
