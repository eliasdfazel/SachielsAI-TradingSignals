/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/21/22, 1:35 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:sachiel/in_application_store/ui/sachiel_digital_store.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/io/file_io.dart';

class DigitalStoreUtils {

  Future<String> purchasedTier() async {

    String purchasingTier = "";

    bool alreadyPurchased = await fileExist(StringsResources.filePurchasingPlan);

    if (alreadyPurchased) {

      String purchasingPlanDirectory = await readFileOfTexts(StringsResources.fileNamePurchasingPlan, "TXT");

      if (purchasingPlanDirectory == SachielsDigitalStore.previewTier) {

        purchasingPlanDirectory = SachielsDigitalStore.palladiumTier;

      }

      int lengthOfText = purchasingPlanDirectory.length;

      purchasingPlanDirectory = "${purchasingPlanDirectory.substring(0, 1).toUpperCase()}${purchasingPlanDirectory.substring(1, lengthOfText)}";

      purchasingTier = purchasingPlanDirectory.replaceAll(".sachiel", "");

    }

    return purchasingTier;
  }

  /// Formatted Text for Expiry Date MM-DD-YYYY
  Future<bool> subscriberExpired() async {

    bool expired = false;

    bool fileExists = await fileExist("${StringsResources.fileNamePurchasingTime}.TXT");

    if (fileExists) {

      DateTime nowTime = DateTime.now();

      String expiryTime = await readFileOfTexts(StringsResources.fileNamePurchasingTime, "TXT");

      int nowMonth = nowTime.month;
      int nowDay = nowTime.day;
      int nowYear = nowTime.year;

      int savedMonth = int.parse(expiryTime.split("-")[0]);
      int savedDay = int.parse(expiryTime.split("-")[1]);
      int savedYear = int.parse(expiryTime.split("-")[2]);

      expired = (nowYear + nowMonth + nowDay) > (savedYear + savedMonth + savedDay);

    }

    return expired;
  }

}