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

  Future<void> externalSubscriberExpiry() async {

    // compare year with current year
    // compare month with current month
    // compare day with current day

  }

}