/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/21/22, 1:35 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/store/ui/sachiel_digital_store.dart';
import 'package:sachiel/utils/io/file_io.dart';

class DigitalStoreUtils {

  Future<String> purchasedTier() async {

    String purchasingTier = "";

    bool alreadyPurchased = await fileExist(StringsResources.filePurchasingPlan);

    if (alreadyPurchased) {

      String purchasingPlanDirectory = (await readFileOfTexts(StringsResources.filePurchasingPlan))!!;

      if (purchasingPlanDirectory == SachielsDigitalStore.previewTier) {

        purchasingPlanDirectory = SachielsDigitalStore.palladiumTier;

      }

      int lengthOfText = purchasingPlanDirectory.length;

      purchasingPlanDirectory = "${purchasingPlanDirectory.substring(0, 1).toUpperCase()}${purchasingPlanDirectory.substring(1, lengthOfText)}";

      purchasingTier = purchasingPlanDirectory.replaceAll(".sachiel", "");

    }

    return purchasingTier;
  }

  Future validateSubscriptions() async {

    bool alreadyPurchased = await fileExist(StringsResources.filePurchasingPlan);

    if (alreadyPurchased) {

      InAppPurchase.instance.purchaseStream.listen((purchaseDetailsList) {

        for (var purchaseDetails in purchaseDetailsList) {

          if (purchaseDetails.status == PurchaseStatus.pending) {


          } else {

            if (purchaseDetails.status == PurchaseStatus.error
                || purchaseDetails.status == PurchaseStatus.canceled) {

              deletePrivateFile(StringsResources.filePurchasingPlan);

            } else if (purchaseDetails.status == PurchaseStatus.purchased
                || purchaseDetails.status == PurchaseStatus.restored) {

              createFileOfTexts(StringsResources.filePurchasingPlan, purchaseDetails.productID);

              switch (purchaseDetails.productID) {
                case SachielsDigitalStore.previewTier: {

                  deletePrivateFile(StringsResources.filePurchasingPlan);

                  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
                  firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.platinumTopic);
                  firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.goldTopic);
                  firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.palladiumTopic);

                  break;
                }
                case SachielsDigitalStore.platinumTier: {

                  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
                  firebaseMessaging.subscribeToTopic(SachielsDigitalStore.platinumTopic);

                  firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.goldTopic);
                  firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.palladiumTopic);

                  break;
                }
                case SachielsDigitalStore.goldTier: {

                  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
                  firebaseMessaging.subscribeToTopic(SachielsDigitalStore.goldTopic);

                  firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.platinumTopic);
                  firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.palladiumTopic);

                  break;
                }
                case SachielsDigitalStore.palladiumTier: {

                  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
                  firebaseMessaging.subscribeToTopic(SachielsDigitalStore.palladiumTopic);

                  firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.platinumTopic);
                  firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.goldTopic);

                  break;
                }
                default: {

                  deletePrivateFile(StringsResources.filePurchasingPlan);

                  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
                  firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.platinumTopic);
                  firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.goldTopic);
                  firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.palladiumTopic);

                  break;
                }
              }

            }

            if (purchaseDetails.pendingCompletePurchase) {



            }

          }

        }

      }, onDone: () {

      }, onError: (error) {

      });

      await InAppPurchase.instance.restorePurchases();

    }

  }

  /// Formatted Text for Expiry Date MM-DD-YYYY
  Future<bool> subscriberExpired() async {

    bool expired = false;

    bool fileExists = await fileExist(StringsResources.filePurchasingTime);

    if (fileExists) {

      int nowTime = DateTime.now().millisecondsSinceEpoch;

      String expiryDate = (await readFileOfTexts(StringsResources.filePurchasingTime))!;

      int savedMonth = int.parse(expiryDate.split("-")[0]);
      int savedDay = int.parse(expiryDate.split("-")[1]);
      int savedYear = int.parse(expiryDate.split("-")[2]);

      int expiryTime = DateTime(savedYear, savedMonth, savedDay).millisecondsSinceEpoch;

      expired = nowTime > expiryTime;

    }

    return expired;
  }

}