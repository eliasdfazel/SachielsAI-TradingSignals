/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 9/10/22, 4:52 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigurations {

  Future<FirebaseRemoteConfig> initialize() async {

    final firebaseRemoteConfig = FirebaseRemoteConfig.instance;
    await firebaseRemoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 3),
      minimumFetchInterval: const Duration(days: 3),
    ));

    return firebaseRemoteConfig;
  }

}