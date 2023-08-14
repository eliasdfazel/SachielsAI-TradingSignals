/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/24/22, 7:34 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:sachiel/entry_configurations.dart';
import 'package:sachiel/firebase_options.dart';
import 'package:sachiel/in_application_store/ui/sachiel_digital_store.dart';
import 'package:sachiel/remote/remote_configurations.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/data/texts.dart';
import 'package:sachiel/utils/io/file_io.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage remoteMessage) async {
  debugPrint("Sachiels Signal Received: ${remoteMessage.data}");
}

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  var firebaseInitialized = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var appCheckProvider = AndroidProvider.playIntegrity;

  if (kDebugMode) {
    appCheckProvider = AndroidProvider.debug;
  }

  await FirebaseAppCheck.instance.activate(
    androidProvider: appCheckProvider,
  );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  fileExist(StringsResources.filePurchasingPlan).then((fileExist) => {

    if (fileExist) {

      readFileOfTexts(StringsResources.fileNamePurchasingPlan, "TXT").then((purchasedPlan) => {

        Future.delayed(Duration.zero, () {
          debugPrint("Purchased Plan: ${capitalizeFirstCharacter(purchasedPlan.split(".").first)}");

          FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

          if (purchasedPlan == SachielsDigitalStore.previewTier) {

            firebaseMessaging.subscribeToTopic(capitalizeFirstCharacter(purchasedPlan.split(".").first));

            firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.platinumTopic);
            firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.goldTopic);
            firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.palladiumTopic);

          } else {

            firebaseMessaging.subscribeToTopic(capitalizeFirstCharacter(purchasedPlan.split(".").first));

          }

        })

      })

    }

  });

  final connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile
      || connectivityResult == ConnectivityResult.wifi
      || connectivityResult == ConnectivityResult.vpn
      || connectivityResult == ConnectivityResult.ethernet) {

    try {

      final internetLookup = await InternetAddress.lookup('example.com');

      bool connectionResult = (internetLookup.isNotEmpty && internetLookup[0].rawAddress.isNotEmpty);

      prototypeProcess();

      await FirebaseAuth.instance.currentUser?.reload();

      runApp(
          Phoenix(
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: EntryConfigurations(internetConnection: connectionResult)
              )
          )
      );

    } on SocketException catch (exception) {
      debugPrint(exception.message);


    }

  } else {



  }

}

void prototypeProcess() {

  RemoteConfigurations remoteConfigurations = RemoteConfigurations();

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