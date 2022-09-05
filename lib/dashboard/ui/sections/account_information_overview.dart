/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 9/5/22, 2:30 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/profile/ui/account_information_details.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:widget_mask/widget_mask.dart';

class AccountInformationOverview extends StatefulWidget {

  const AccountInformationOverview({Key? key}) : super(key: key);

  @override
  State<AccountInformationOverview> createState() => AccountInformationOverviewStates();

}
class AccountInformationOverviewStates extends State<AccountInformationOverview> {

  User? firebaseUser = FirebaseAuth.instance.currentUser;

  String profileName = StringsResources.sachielAI();

  Widget profileImage = const Image(
    image: AssetImage("cyborg_girl.jpg"),
    fit: BoxFit.cover,
  );

  @override
  void initState() {
    super.initState();

    retrieveAccountInformation();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        /* Start - Profile Image */
        InkWell(
          onTap: () {

            openAccountInformation();

          },
          child: Align(
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
          )
        ),
        /* End - Profile Image */

        /* Start - Profile Name */
        InkWell(
          onTap: () {

            openAccountInformation();

          },
          child:  Align(
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
                                      )
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
                                      )
                                  )
                              )
                          )
                        ],
                      )
                  )
              )
          )
        )
        /* End - Profile Name */

      ],
    );
  }

  void retrieveAccountInformation() async {

    if (firebaseUser != null) {

      profileName = firebaseUser!.displayName!;

      profileImage = Image.network(
        firebaseUser!.photoURL.toString(),
        fit: BoxFit.cover,
      );

      Future.delayed(const Duration(milliseconds: 137), () {

        setState(() {

          profileName;

          profileImage;

        });

      });

    }

  }

  void openAccountInformation() {

    navigateTo(context, const AccountInformationDetails());

  }

}