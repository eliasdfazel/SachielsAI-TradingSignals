/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/21/22, 1:35 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/io/file_io.dart';

class DigitalStoreUtils {

  Future<String> purchasedTier() async {

    String purchasingTier = "";

    bool alreadyPurchased = await fileExist(StringsResources.filePurchasingPlan);

    if (alreadyPurchased) {

      String purchasingPlanDirectory = await readFileOfTexts(StringsResources.fileNamePurchasingPlan, "TXT");

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

      int nowYear = nowTime.year;
      int savedYear = int.parse(expiryTime.split("-")[2]);



      int nowMonth = nowTime.month;
      int savedMonth = int.parse(expiryTime.split("-")[0]);



      int nowDay = nowTime.day;
      int savedDay = int.parse(expiryTime.split("-")[1]);

    }

    return expired;
  }

}