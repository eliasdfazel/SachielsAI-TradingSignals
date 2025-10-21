/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/22/22, 3:07 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigurations {

  static const String sachielPrincipal = "sachielPrincipal";
  static const String aiNowEndpoint = "aiNowEndpoint";

  static const String slideOneContent = "slideOneContent";
  static const String slideTwoContent = "slideTwoContent";
  static const String slideThreeContent = "slideThreeContent";
  static const String sliderTime = "sliderTime";

  Future<FirebaseRemoteConfig> initialize() async {

    final firebaseRemoteConfig = FirebaseRemoteConfig.instance;
    await firebaseRemoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 3),
      minimumFetchInterval: const Duration(days: 3),
    ));

    await firebaseRemoteConfig.fetch();

    return firebaseRemoteConfig;
  }

}