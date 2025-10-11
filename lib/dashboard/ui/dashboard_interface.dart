/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 12/6/22, 6:59 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sachiel/dashboard/ui/sections/account_information_overview.dart';
import 'package:sachiel/dashboard/ui/sections/ai_status.dart';
import 'package:sachiel/dashboard/ui/sections/last_signal_details.dart';
import 'package:sachiel/dashboard/ui/sections/latest_signals_overview.dart';
import 'package:sachiel/dashboard/ui/sections/purchase_plan_picker.dart';
import 'package:sachiel/dashboard/ui/sections/social_media.dart';
import 'package:sachiel/introductions/introduction_slides.dart';
import 'package:sachiel/remote/dynamic_shortcuts.dart';
import 'package:sachiel/remote/remote_configurations.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/store/ui/sachiel_digital_store.dart';
import 'package:sachiel/store/utils/digital_store_utils.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/io/file_io.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/ui/display.dart';

class DashboardInterface extends StatefulWidget {

  const DashboardInterface({Key? key}) : super(key: key);

  @override
  State<DashboardInterface> createState() => _DashboardInterfaceState();

}
class _DashboardInterfaceState extends State<DashboardInterface> {

  DigitalStoreUtils digitalStoreUtils = DigitalStoreUtils();

  RemoteConfigurations remoteConfigurations = RemoteConfigurations();

  AccountInformationOverview accountInformationOverview = const AccountInformationOverview();

  StatusAi statusAi = const StatusAi();

  LastSignalDetails lastSignalDetails = const LastSignalDetails();

  LatestSignalsOverview latestSignalsOverview = const LatestSignalsOverview();

  DynamicShortcuts dynamicShortcuts = DynamicShortcuts();

  Widget sliderInvocation = Container();

  Widget updatePlaceholder = Container();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    sliderCheckpoint();

    digitalStoreUtils.validateSubscriptions();

    principalsProcess();

    externalSubscriberCheckpoint();

    Permission.notification.status.then((permissionStatus) {

      if (permissionStatus.isDenied) {

        Permission.notification.request();

      }

    });

  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(milliseconds: 777), () {

      dynamicShortcuts.setup(context);

    });

    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorsResources.black,
          body: Stack(
            children: [

              /* Start - Gradient Background - Dark */
              Container(
                decoration: const BoxDecoration(
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
                          image: AssetImage("assets/logo.png"),
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 37),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [

                    /* Start - Account Information Overview */
                    accountInformationOverview,
                    /* End - Account Information Overview */

                    /* Start - Sachiel AI Status */
                    statusAi,
                    /* End - Sachiel AI Status */

                    /* Start - The Last Signal Details */
                    lastSignalDetails,
                    /* End - The Last Signal Details */

                    /* Start - The Latest Signals Overview */
                    latestSignalsOverview,
                    /* End - The Latest Signals Overview */

                    /* Start - Social Media */
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 37, 0, 0),
                      child: SocialMedia(),
                    )
                    /* End - Social Media */

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

              sliderInvocation,

              updatePlaceholder

            ],
          )
      )
    );
  }

  void sliderCheckpoint() {

    remoteConfigurations.initialize().then((firebaseRemoteConfigurations) {

      firebaseRemoteConfigurations.activate().then((value) async {

        int oldSliderTime = int.parse(await readFileOfTexts(StringsResources.fileSliderTime));

        int newSliderTime = firebaseRemoteConfigurations.getInt(RemoteConfigurations.sliderTime);

        if (newSliderTime > oldSliderTime) {

          setState(() {

            sliderInvocation = Positioned(
              left: 19,
              bottom: 31,
              child: SizedBox(
                  height: 59,
                  width: 59,
                  child: InkWell(
                      onTap: () async {

                        navigateTo(context, IntroductionSlides(firebaseRemoteConfig: firebaseRemoteConfigurations));

                      },
                      child: const Image(
                        image: AssetImage("assets/golden_information_icon.png"),
                      )
                  )
              ),
            );

          });

        }

      });

    });

  }

  void principalsProcess() {

    remoteConfigurations.initialize().then((firebaseRemoteConfigurations) {

      firebaseRemoteConfigurations.activate().then((value) async {

        String sachielPrincipal = firebaseRemoteConfigurations.getString(RemoteConfigurations.sachielPrincipal);

        if (sachielPrincipal.contains(FirebaseAuth.instance.currentUser!.email.toString())) {

          FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

          firebaseMessaging.subscribeToTopic(SachielsDigitalStore.platinumTopic);
          firebaseMessaging.subscribeToTopic(SachielsDigitalStore.goldTopic);
          firebaseMessaging.subscribeToTopic(SachielsDigitalStore.palladiumTopic);

          firebaseMessaging.subscribeToTopic(SachielsDigitalStore.previewTopic);
          firebaseMessaging.subscribeToTopic(SachielsDigitalStore.privilegedTopic);

        }

      });

    });

  }

  void externalSubscriberCheckpoint() async {

    bool subscriberExpired = await digitalStoreUtils.subscriberExpired();

    if (subscriberExpired) {

      Fluttertoast.showToast(
          msg: StringsResources.subscriptionExpired(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorsResources.dark,
          textColor: ColorsResources.light,
          fontSize: 13.0
      );

      navigateTo(context, SachielsDigitalStore(topPadding: statusBarHeight(context)));

    } else {

      FirebaseFirestore.instance
          .doc("/Sachiels/Subscribers/Externals/${FirebaseAuth.instance.currentUser!.email!.toLowerCase()}")
          .get().then((DocumentSnapshot documentSnapshot) {

        if (documentSnapshot.exists) {

          FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
          firebaseMessaging.subscribeToTopic(documentSnapshot.get("purchasedPlan"));

        }

      }, onError: (e) => {

      });

    }

  }

}
