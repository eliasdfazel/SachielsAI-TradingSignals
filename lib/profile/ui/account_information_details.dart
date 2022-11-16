/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/16/22, 8:53 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/dashboard/ui/sections/purchase_plan_picker.dart';
import 'package:sachiel/profile/data/profiles_data_structure.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:sachiel/utils/widgets/gradient_text/constants.dart';
import 'package:sachiel/utils/widgets/gradient_text/gradient.dart';
import 'package:widget_mask/widget_mask.dart';

class AccountInformationDetails extends StatefulWidget {

  const AccountInformationDetails({Key? key}) : super(key: key);

  @override
  State<AccountInformationDetails> createState() => AccountInformationDetailsStates();
}
class AccountInformationDetailsStates extends State<AccountInformationDetails> {

  User? firebaseUser = FirebaseAuth.instance.currentUser;

  String profileName = StringsResources.sachielAI();

  Widget profileImage = const Image(
    image: AssetImage("cyborg_girl.jpg"),
    fit: BoxFit.cover,
    height: 373,
    width: 373,
  );

  TextEditingController twitterInputController = TextEditingController();

  TextEditingController facebookInputController = TextEditingController();

  TextEditingController instagramInputController = TextEditingController();

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

    retrieveAccountInformation();

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
                Align(
                  alignment: Alignment.center,
                  child: Opacity(
                      opacity: 0.1,
                      child: Transform.scale(
                          scale: 1.7,
                          child: const Image(
                            image: AssetImage("logo.png"),
                          )
                      )
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
                        height: calculatePercentage(99, displayHeight()),
                        width: calculatePercentage(99, displayWidth()),
                      ),
                    )
                ),
                /* End - Gradient Background - Golden */

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(0, 137, 0, 37),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [

                      /* Start - Profile Image/Name */
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  /* Start - Profile Image */
                                  Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                          height: 201,
                                          width: 201,
                                          child: Stack(
                                            children: [
                                              WidgetMask(
                                                blendMode: BlendMode.srcATop,
                                                childSaveLayer: true,
                                                mask /* Original Image */: Container(
                                                  decoration: const BoxDecoration(
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            ColorsResources.white,
                                                            ColorsResources.primaryColorLighter,
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
                                  ),
                                  /* End - Profile Image */

                                  /* Start - Profile Name */
                                  Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                          height: 201,
                                          width: 201,
                                          child: Padding(
                                              padding: const EdgeInsets.fromLTRB(19, 0, 0, 0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: GradientText(
                                                  profileName.replaceFirst(" ", "\n"),
                                                  overflow: TextOverflow.fade,
                                                  style: const TextStyle(
                                                      fontSize: 59
                                                  ),
                                                  gradientDirection: GradientDirection.tltbr,
                                                  maxLinesNumber: 2,
                                                  colors: const [
                                                    ColorsResources.primaryColorLighter,
                                                    ColorsResources.white
                                                  ],
                                                ),
                                              )
                                          )
                                      )
                                  )
                                  /* End - Profile Name */

                                ],
                              )
                          )
                      ),
                      /* End - Profile Image/Name */

                      const Divider(
                        height: 31,
                        color: Colors.transparent,
                      ),

                      /* Start - Twitter */
                      Padding(
                        padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                        child: Stack(
                          children: [

                            const SizedBox(
                              height: 113,
                              width: double.infinity,
                              child: Image(
                                image: AssetImage("twitter_input.png"),
                              ),
                            ),

                            SizedBox(
                              height: 113,
                              width: double.infinity,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(119, 0, 19, 0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextField(
                                        controller: twitterInputController,
                                        maxLines: 1,
                                        cursorColor: ColorsResources.primaryColorLighter,
                                        decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0
                                                )
                                            )
                                        ),
                                        style: const TextStyle(
                                            fontSize: 31,
                                            color: ColorsResources.dark,
                                            decoration: TextDecoration.none
                                        ),
                                      )
                                  )
                              ),
                            )

                          ],
                        ),
                      ),
                      /* End - Twitter */

                      const Divider(
                        height: 3,
                        color: Colors.transparent,
                      ),

                      /* Start - Facebook */
                      Padding(
                        padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                        child: Stack(
                          children: [

                            const SizedBox(
                              height: 113,
                              width: double.infinity,
                              child: Image(
                                image: AssetImage("facebook_input.png"),
                              ),
                            ),

                            SizedBox(
                              height: 113,
                              width: double.infinity,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(119, 0, 19, 0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextField(
                                        controller: facebookInputController,
                                        maxLines: 1,
                                        cursorColor: ColorsResources.primaryColorLighter,
                                        decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0
                                                )
                                            )
                                        ),
                                        style: const TextStyle(
                                            fontSize: 31,
                                            color: ColorsResources.dark,
                                            decoration: TextDecoration.none
                                        ),
                                      )
                                  )
                              ),
                            )

                          ],
                        ),
                      ),
                      /* End - Facebook */

                      const Divider(
                        height: 3,
                        color: Colors.transparent,
                      ),

                      /* Start - Facebook */
                      Padding(
                        padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                        child: Stack(
                          children: [

                            const SizedBox(
                              height: 113,
                              width: double.infinity,
                              child: Image(
                                image: AssetImage("instagram_input.png"),
                              ),
                            ),

                            SizedBox(
                              height: 113,
                              width: double.infinity,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(119, 0, 19, 0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextField(
                                        controller: instagramInputController,
                                        maxLines: 1,
                                        cursorColor: ColorsResources.primaryColorLighter,
                                        decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0
                                                )
                                            )
                                        ),
                                        style: const TextStyle(
                                            fontSize: 31,
                                            color: ColorsResources.dark,
                                            decoration: TextDecoration.none
                                        ),
                                      )
                                  )
                              ),
                            )

                          ],
                        ),
                      ),
                      /* End - Facebook */

                      const Divider(
                        height: 7,
                        color: Colors.transparent,
                      ),

                      /* Start - Submit Button */
                      Padding(
                        padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {

                              updateProfileInformation();

                            },
                            child: const Image(
                              image: AssetImage("submit_icon.png"),
                              fit: BoxFit.contain,
                              width: 173,
                            ),
                          )
                        ),
                      ),
                      /* End - Submit Button */

                    ],
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
                                                StringsResources.profileTitle(),
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

  void retrieveAccountInformation() async {

    if (firebaseUser != null) {

      profileName = firebaseUser!.displayName!;

      profileImage = Image.network(
        firebaseUser!.photoURL.toString(),
        fit: BoxFit.cover,
        height: 301,
        width: 301,
      );

      setState(() {

        profileName;

        profileImage;

      });

    }

  }

  void updateProfileInformation() async {

    if(firebaseUser != null) {

      ProfilesDataStructure profilesDataStructure = ProfilesDataStructure(
        firebaseUser!.uid,

        firebaseUser!.displayName!,
        firebaseUser!.photoURL!,

        firebaseUser!.email!,
        firebaseUser!.phoneNumber!,

        twitterInputController.text,
        facebookInputController.text,
        instagramInputController.text,
      );

      FirebaseFirestore.instance
        .doc("Sachiels/Profiles/${firebaseUser!.uid}/Information")
        .update(profilesDataStructure.profilesDocumentData)
        .then((value) => {



        }).onError((error, stackTrace) => {



        });

    }

  }

}