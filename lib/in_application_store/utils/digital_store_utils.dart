/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/18/22, 4:00 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/io/file_io.dart';

class DigitalStoreUtils {

  Future<String> purchasedTier() async {

    String purchasingPlanDirectory = await readFileOfTexts(StringsResources.fileNamePurchasingPlan, ".TXT");

    int lengthOfText = purchasingPlanDirectory.length;

    purchasingPlanDirectory = "${purchasingPlanDirectory.substring(0, 1).toUpperCase()}${purchasingPlanDirectory.substring(1, lengthOfText)}";

    return purchasingPlanDirectory.replaceAll(".tier", "");
  }

}