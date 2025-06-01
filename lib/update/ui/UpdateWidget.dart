
/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/27/24, 12:18 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_mask/widget_mask.dart';

Widget updateWidget(String applicationLink) {

  return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                ColorsResources.primaryColorDarkest.withOpacity(0.73),
                ColorsResources.primaryColorDarker.withOpacity(0.73)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          )
      ),
    child: Stack(
      children: [

        /* Start - Blurry Background */
        Blur(
          blur: 31.0,
          blurColor: ColorsResources.primaryColorDarkest.withOpacity(0.1),
          colorOpacity: 0.19,
          child: const SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
          ),
        ),
        /* End - Blurry Background */
        /* End - Decoration */

        SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Material(
                shadowColor: Colors.transparent,
                color: Colors.transparent,
                child: InkWell(
                    splashColor: ColorsResources.primaryColor.withOpacity(0.73),
                    splashFactory: InkRipple.splashFactory,
                    onTap: () {

                      Future.delayed(const Duration(milliseconds: 555), () {

                        launchUrl(Uri.parse(applicationLink), mode: LaunchMode.externalApplication);

                      });

                    },
                    child: Center(
                        child: SizedBox(
                            height: 399,
                            width: double.maxFinite,
                            child: Stack(
                              children: [

                                /* Start - Play */
                                WidgetMask(
                                    blendMode: BlendMode.srcATop,
                                    childSaveLayer: true,
                                    mask: Material(
                                        shadowColor: Colors.transparent,
                                        color: Colors.transparent,
                                        child: InkWell(
                                            splashColor: ColorsResources.primaryColor,
                                            splashFactory: InkRipple.splashFactory,
                                            onTap: () {

                                              Future.delayed(const Duration(milliseconds: 555), () {

                                                launchUrl(Uri.parse(applicationLink), mode: LaunchMode.externalApplication);

                                              });

                                            },
                                            child: const Image(
                                              image: AssetImage("assets/update.png"),
                                              height: 313,
                                              width: double.maxFinite,
                                              fit: BoxFit.contain,
                                            )
                                        )
                                    ),
                                    child: const Image(
                                      image: AssetImage("assets/update.png"),
                                      height: 313,
                                      width: double.maxFinite,
                                      fit: BoxFit.contain,
                                    )
                                ),
                                /* End - Play */

                              ],
                            )
                        )
                    )
                )
            )
        )

      ]
    )
  );

}