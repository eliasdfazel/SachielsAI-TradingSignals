/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 12/6/22, 7:22 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:blur/blur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sachiel/dashboard/ui/dashboard_interface.dart';
import 'package:sachiel/in_application_store/ui/sachiel_digital_store.dart';
import 'package:sachiel/introductions/introduction_slides.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/authentication/authentication_process.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/io/file_io.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:sachiel/utils/ui/system_bars.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:widget_mask/widget_mask.dart';

class EntryConfigurations extends StatefulWidget {

  bool internetConnection = false;

  EntryConfigurations({Key? key, required this.internetConnection}) : super(key: key);

  @override
  State<EntryConfigurations> createState() => _EntryConfigurationsState();
}
class _EntryConfigurationsState extends State<EntryConfigurations> implements  AuthenticationsCallback {

  FirebaseRemoteConfig? firebaseRemoteConfig;

  AuthenticationsProcess authenticationsProcess = AuthenticationsProcess();

  FirebaseAuth firebaseAuthentication = FirebaseAuth.instance;

  TextEditingController phoneNumberController = TextEditingController();

  Widget phoneNumberAuthentication = Container();

  String? warningNoticePhoneNumber;

  bool entranceVisibility = false;

  String titlePlaceholder = StringsResources.phoneNumber();
  String hintPlaceholder = StringsResources.phoneNumberHint();

  String noticeMessage = StringsResources.termService();
  String noticeAction = StringsResources.read();

  String generatedVerificationId = "";

  @override
  void initState() {
    super.initState();

    firebaseAuthentication.currentUser?.reload();

    changeColor(ColorsResources.black, ColorsResources.black);

  }

  @override
  Widget build(BuildContext context) {

    if (widget.internetConnection) {

      if (firebaseAuthentication.currentUser == null) {
        debugPrint("Google Not Authenticated");

        Future.delayed(const Duration(milliseconds: 1357), () async {
          debugPrint("Google Authenticating...");

          Future.delayed(const Duration(milliseconds: 111), () {

            FlutterNativeSplash.remove();

          });

          UserCredential userCredential = await authenticationsProcess.startGoogleAuthentication();

          if (userCredential.user!.phoneNumber == null) {
            debugPrint("Phone Number Not Authenticated");

            phoneNumberCheckpoint();

          } else {

            navigationCheckpoint();

          }

        });

      }

      if (firebaseAuthentication.currentUser != null) {

        if (firebaseAuthentication.currentUser!.phoneNumber == null) {
          debugPrint("Phone Number Not Authenticated > NULL");

          phoneNumberCheckpoint();

        } else if (firebaseAuthentication.currentUser!.phoneNumber!.isEmpty) {
          debugPrint("Phone Number Not Authenticated > EMPTY");

          phoneNumberCheckpoint();

        } else {
          debugPrint("Authenticated");

          navigationCheckpoint();

        }

      }

    } else {

      FlutterNativeSplash.remove();

      noticeMessage = StringsResources.noInternetConnection();
      noticeAction = StringsResources.ok();

    }

    return SafeArea(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringsResources.applicationName(),
            color: ColorsResources.primaryColor,
            theme: ThemeData(
              fontFamily: 'Ubuntu',
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
                TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
              }),
            ),
            home: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: ColorsResources.black,
                body: Stack(
                    children: [

                      Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(17),
                                  topRight: Radius.circular(17),
                                  bottomLeft: Radius.circular(17),
                                  bottomRight: Radius.circular(17)
                              ),
                              color: ColorsResources.black,
                              image: DecorationImage(
                                  image: AssetImage("assets/entry_background.jpg"),
                                  fit: BoxFit.cover
                              )
                          )
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 31, 0, 13),
                              child: Image(
                                image: AssetImage("assets/logo.png"),
                                height: 259,
                                fit: BoxFit.fitHeight,
                              ),
                            ),

                            phoneNumberAuthentication,

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 13, 0, 73),
                                child: SizedBox(
                                  height: 239,
                                  width: 239,
                                  child: WidgetMask(
                                    blendMode: BlendMode.srcATop,
                                    childSaveLayer: true,
                                    mask /* Original Image */: Material(
                                        shadowColor: Colors.transparent,
                                        color: Colors.transparent,
                                        child: InkWell(
                                            splashColor: ColorsResources.lightestYellow.withOpacity(0.3),
                                            splashFactory: InkRipple.splashFactory,
                                            onTap: () {

                                              if (phoneNumberController.text.isNotEmpty) {

                                                if (titlePlaceholder == StringsResources.enterCode()) {

                                                  String smsCode = phoneNumberController.text;

                                                  PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: generatedVerificationId, smsCode: smsCode);

                                                  FirebaseAuth.instance.currentUser?.updatePhoneNumber(phoneAuthCredential).then((value) => {

                                                    navigationCheckpoint()

                                                  });

                                                } else {

                                                  authenticationsProcess.startPhoneNumberAuthentication(phoneNumberController.text, this);

                                                }

                                                setState(() {

                                                  warningNoticePhoneNumber = null;

                                                });

                                              } else {

                                                setState(() {

                                                  warningNoticePhoneNumber = StringsResources.warningEmptyText();

                                                });

                                              }

                                            },
                                            child: Visibility(
                                                visible: entranceVisibility,
                                                child: const Image(
                                                  image: AssetImage("assets/entrance_next.png"),
                                                  height: 239,
                                                  fit: BoxFit.fitHeight,
                                                )
                                            )
                                        )
                                    ),
                                    child: const Image(
                                      image: AssetImage("assets/entrance_next.png"),
                                    )
                                  )
                                )
                            )

                          ]
                        )
                      ),

                      Positioned(
                        bottom: 19,
                        right: 19,
                        left: 19,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(19),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: ColorsResources.primaryColor.withOpacity(0.31),
                                        width: 3,
                                        strokeAlign: BorderSide.strokeAlignInside
                                    )
                                ),
                                gradient: LinearGradient(
                                    colors: [
                                      ColorsResources.black.withOpacity(0.73),
                                      ColorsResources.primaryColor.withOpacity(0.73)
                                    ],
                                    stops: const [0.47, 1.0],
                                    transform: GradientRotation(degreeToRadian(90))
                                )
                            ),
                            child: SizedBox(
                                height: 53,
                                width: double.maxFinite,
                                child: Row(

                                    children: [

                                      Expanded(
                                        flex: 7,
                                        child: SizedBox(
                                          height: 53,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    noticeMessage,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: ColorsResources.premiumLight,
                                                      fontSize: 13,
                                                      overflow: TextOverflow.ellipsis,
                                                      shadows: [
                                                        Shadow(
                                                          color: ColorsResources.primaryColor.withOpacity(0.37),
                                                          blurRadius: 7,
                                                          offset: const Offset(0, 5)
                                                        )
                                                      ]
                                                    )
                                                )
                                            )
                                          )
                                        )
                                      ),

                                      Expanded(
                                          flex: 3,
                                          child: SizedBox(
                                              height: 53,
                                              child: Center(
                                                child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                                                    child: Container(
                                                        height: 31,
                                                        width: double.maxFinite,
                                                        decoration: BoxDecoration(
                                                            color: ColorsResources.black,
                                                            borderRadius: BorderRadius.circular(11),
                                                            border: Border.all(
                                                                color: ColorsResources.primaryColor,
                                                                width: 1.73,
                                                                strokeAlign: BorderSide.strokeAlignOutside
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: ColorsResources.primaryColor.withOpacity(0.73),
                                                                blurRadius: 13,
                                                              )
                                                            ]
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(11),
                                                          child: Material(
                                                              shadowColor: Colors.transparent,
                                                              color: Colors.transparent,
                                                              child: InkWell(
                                                                  splashColor: ColorsResources.lightestYellow.withOpacity(0.31),
                                                                  splashFactory: InkRipple.splashFactory,
                                                                  onTap: () {

                                                                    Future.delayed(const Duration(milliseconds: 333), () {

                                                                      if (noticeAction == StringsResources.read()) {

                                                                        launchUrlString("https://geeksempire.co/sachiel-ai-trading-signals/term-of-services/", mode: LaunchMode.externalApplication);

                                                                      } else {

                                                                        AppSettings.openWIFISettings();

                                                                      }

                                                                    });

                                                                  },
                                                                  child: Center(
                                                                      child: Text(
                                                                          noticeAction,
                                                                          style: const TextStyle(
                                                                              color: ColorsResources.premiumLight,
                                                                              fontSize: 12
                                                                          )
                                                                      )
                                                                  )
                                                              )
                                                          )
                                                        )
                                                    )
                                                )
                                              )
                                          )
                                      )

                                    ]

                                )
                            ),
                          )
                        )
                      )

                    ]
                )
            )
        )
    );
  }

  @override
  void authenticationWithPhoneCompleted() {
    debugPrint("Authentication With Phone Number Completed");

    navigationCheckpoint();

  }

  @override
  void authenticationCodeSent(String verificationId) {

    setState(() {

      generatedVerificationId = verificationId;

      phoneNumberController.clear();

      titlePlaceholder = StringsResources.enterCode();

      hintPlaceholder = StringsResources.enterCodeHint();

    });

  }

  void phoneNumberCheckpoint() {

      if (firebaseAuthentication.currentUser!.phoneNumber == null) {
        debugPrint("Phone Number Not Authenticated > NULL");

        Future.delayed(const Duration(milliseconds: 111), () {

          FlutterNativeSplash.remove();

        });

        setState(() {

          entranceVisibility = true;

          phoneNumberAuthentication = SizedBox(
              height: 113,
              width: 373,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 37,
                      width: 137,
                      child: Stack(
                          children: [
                            Blur(
                              blur: 5,
                              blurColor: ColorsResources.dark,
                              colorOpacity: 0.1,
                              borderRadius: BorderRadius.circular(9),
                              child: const SizedBox(
                                height: 37,
                                width: 137,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(9),
                                      topRight: Radius.circular(9),
                                      bottomLeft: Radius.circular(9),
                                      bottomRight: Radius.circular(9)
                                  ),
                                  border: Border.all(
                                    color: ColorsResources.black,
                                    width: 2,
                                  ),
                                  color: ColorsResources.dark.withOpacity(0.37)
                              ),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    titlePlaceholder,
                                    style: const TextStyle(
                                        color: ColorsResources.premiumLight,
                                        fontSize: 17
                                    ),
                                  )
                              ),
                            )
                          ]
                      )
                  ),
                  SizedBox(
                      height: 73,
                      width: 373,
                      child: Stack(
                          children: [
                            Blur(
                              blur: 7,
                              blurColor: ColorsResources.dark,
                              colorOpacity: 0.1,
                              borderRadius: BorderRadius.circular(17),
                              child: const SizedBox(
                                height: 72,
                                width: 373,
                              ),
                            ),
                            TextField(
                              controller: phoneNumberController,
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.ltr,
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 1,
                              cursorColor: ColorsResources.primaryColor,
                              autofocus: false,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                  color: ColorsResources.light,
                                  fontSize: 37.0,
                                  shadows: [
                                    Shadow(
                                        color: ColorsResources.primaryColorLighter.withOpacity(0.71),
                                        blurRadius: 17,
                                        offset: const Offset(0.0, 3.0)
                                    )
                                  ]
                              ),
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(17),
                                        topRight: Radius.circular(17),
                                        bottomLeft: Radius.circular(17),
                                        bottomRight: Radius.circular(17)
                                    ),
                                    gapPadding: 5
                                ),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(17),
                                        topRight: Radius.circular(17),
                                        bottomLeft: Radius.circular(17),
                                        bottomRight: Radius.circular(17)
                                    ),
                                    gapPadding: 5
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(17),
                                        topRight: Radius.circular(17),
                                        bottomLeft: Radius.circular(17),
                                        bottomRight: Radius.circular(17)
                                    ),
                                    gapPadding: 5
                                ),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 3.0),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(17),
                                        topRight: Radius.circular(17),
                                        bottomLeft: Radius.circular(17),
                                        bottomRight: Radius.circular(17)
                                    ),
                                    gapPadding: 5
                                ),
                                errorText: warningNoticePhoneNumber,
                                contentPadding: const EdgeInsets.fromLTRB(19, 21, 19, 21),
                                hintText: hintPlaceholder,
                              ),
                              onSubmitted: (phoneNumber) {

                                if (phoneNumberController.text.isNotEmpty) {

                                  if (titlePlaceholder == StringsResources.enterCode()) {

                                    String smsCode = phoneNumberController.text;

                                    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: generatedVerificationId, smsCode: smsCode);

                                    FirebaseAuth.instance.currentUser?.updatePhoneNumber(phoneAuthCredential).then((value) => {

                                      navigationCheckpoint()

                                    });

                                  } else {

                                    authenticationsProcess.startPhoneNumberAuthentication(phoneNumberController.text, this);

                                  }

                                  setState(() {

                                    warningNoticePhoneNumber = null;

                                  });

                                } else {

                                  setState(() {

                                    warningNoticePhoneNumber = StringsResources.warningEmptyText();

                                  });

                                }

                              },
                            )
                          ]
                      )
                  )
                ],
              )
          );

        });

      } else if (firebaseAuthentication.currentUser!.phoneNumber!.isEmpty) {

        debugPrint("Phone Number Not Authenticated > EMPTY");

        Future.delayed(const Duration(milliseconds: 111), () {

          FlutterNativeSplash.remove();

        });

        setState(() {

          entranceVisibility = true;

          phoneNumberAuthentication = SizedBox(
              height: 113,
              width: 373,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 37,
                      width: 137,
                      child: Stack(
                          children: [
                            Blur(
                              blur: 5,
                              blurColor: ColorsResources.dark,
                              colorOpacity: 0.1,
                              borderRadius: BorderRadius.circular(9),
                              child: const SizedBox(
                                height: 37,
                                width: 137,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(9),
                                      topRight: Radius.circular(9),
                                      bottomLeft: Radius.circular(9),
                                      bottomRight: Radius.circular(9)
                                  ),
                                  border: Border.all(
                                    color: ColorsResources.black,
                                    width: 2,
                                  ),
                                  color: ColorsResources.dark.withOpacity(0.37)
                              ),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    titlePlaceholder,
                                    style: const TextStyle(
                                        color: ColorsResources.premiumLight,
                                        fontSize: 17
                                    ),
                                  )
                              ),
                            )
                          ]
                      )
                  ),
                  SizedBox(
                      height: 73,
                      width: 373,
                      child: Stack(
                          children: [
                            Blur(
                              blur: 7,
                              blurColor: ColorsResources.dark,
                              colorOpacity: 0.1,
                              borderRadius: BorderRadius.circular(17),
                              child: const SizedBox(
                                height: 72,
                                width: 373,
                              ),
                            ),
                            TextField(
                              controller: phoneNumberController,
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.ltr,
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 1,
                              cursorColor: ColorsResources.primaryColor,
                              autofocus: false,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                  color: ColorsResources.light,
                                  fontSize: 37.0,
                                  shadows: [
                                    Shadow(
                                        color: ColorsResources.primaryColorLighter.withOpacity(0.71),
                                        blurRadius: 17,
                                        offset: const Offset(0.0, 3.0)
                                    )
                                  ]
                              ),
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(17),
                                        topRight: Radius.circular(17),
                                        bottomLeft: Radius.circular(17),
                                        bottomRight: Radius.circular(17)
                                    ),
                                    gapPadding: 5
                                ),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(17),
                                        topRight: Radius.circular(17),
                                        bottomLeft: Radius.circular(17),
                                        bottomRight: Radius.circular(17)
                                    ),
                                    gapPadding: 5
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(17),
                                        topRight: Radius.circular(17),
                                        bottomLeft: Radius.circular(17),
                                        bottomRight: Radius.circular(17)
                                    ),
                                    gapPadding: 5
                                ),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 3.0),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(17),
                                        topRight: Radius.circular(17),
                                        bottomLeft: Radius.circular(17),
                                        bottomRight: Radius.circular(17)
                                    ),
                                    gapPadding: 5
                                ),
                                errorText: warningNoticePhoneNumber,
                                contentPadding: const EdgeInsets.fromLTRB(19, 21, 19, 21),
                                hintText: hintPlaceholder,
                              ),
                              onSubmitted: (phoneNumber) {

                                if (phoneNumberController.text.isNotEmpty) {

                                  if (titlePlaceholder == StringsResources.enterCode()) {

                                    String smsCode = phoneNumberController.text;

                                    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: generatedVerificationId, smsCode: smsCode);

                                    FirebaseAuth.instance.currentUser?.updatePhoneNumber(phoneAuthCredential).then((value) => {

                                      navigationCheckpoint()

                                    });

                                  } else {

                                    authenticationsProcess.startPhoneNumberAuthentication(phoneNumberController.text, this);

                                  }

                                  setState(() {

                                    warningNoticePhoneNumber = null;

                                  });

                                } else {

                                  setState(() {

                                    warningNoticePhoneNumber = StringsResources.warningEmptyText();

                                  });

                                }

                              },
                            )
                          ]
                      )
                  )
                ],
              )
          );

        });

      } else {
        debugPrint("Authentication With Phone Number Completed");

        navigationCheckpoint();

      }

  }

  /*
   * Request Notification Permission for iOS
   */
  void requestNotificationPermission() async {

    if (Platform.isIOS) {

      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

      NotificationSettings notificationSettings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      debugPrint("Notification Permission: ${notificationSettings.authorizationStatus}");

    }

  }

  void navigationCheckpoint() {

    Future.delayed(const Duration(milliseconds: 379), () {

      fileExist(StringsResources.filePurchasingPlan).then((alreadyPurchased) => {
        debugPrint("Already Purchased: ${alreadyPurchased}"),

        if (alreadyPurchased) {

          fileExist(StringsResources.fileSliderTime).then((sliderInitialized) => {

            if (sliderInitialized) {

              navigateToWithPop(context, const DashboardInterface())

            } else {

              navigateTo(context, IntroductionSlides())

            }

          })

        } else {

          if (kDebugMode) {

            createFileOfTexts(StringsResources.fileNameSliderTime, "TXT", DateTime.now().millisecondsSinceEpoch.toString()).then((value) => {

              createFileOfTexts(StringsResources.fileNamePurchasingPlan, "TXT", "Palladium").then((value) => {

                navigateToWithPop(context, const DashboardInterface())

              })

            })

          } else {

            navigateTo(context, SachielsDigitalStore(topPadding: statusBarHeight(context)))

          }

        }

      });

    });

  }

}