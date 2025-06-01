/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/19/23, 6:18 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:sachiel/store/ui/sachiel_digital_store.dart';

class AndroidSubscriptionChanges {

  StreamSubscription<List<PurchaseDetails>>? restorePurchaseStream;

  Future changeSubscription() async {

    restorePurchaseStream = InAppPurchase.instance.purchaseStream.listen((purchaseDetailsList) {

      if (purchaseDetailsList.isNotEmpty) {

        for (var purchaseDetails in purchaseDetailsList) {
          debugPrint("Purchase Details ${purchaseDetails.purchaseID}; ${purchaseDetails.status}");

          if (purchaseDetails.status == PurchaseStatus.pending) {


          } else {

            if (purchaseDetails.status == PurchaseStatus.error
                || purchaseDetails.status == PurchaseStatus.canceled) {

            } else if (purchaseDetails.status == PurchaseStatus.purchased
                || purchaseDetails.status == PurchaseStatus.restored) {
              debugPrint("Android Purchases Restored: ${purchaseDetails.purchaseID}");

              switch (purchaseDetails.productID) {
                case SachielsDigitalStore.platinumTier: {

                  Future.delayed(Duration.zero, () async {

                    final ProductDetailsResponse productDetailsResponse  = await InAppPurchase.instance.queryProductDetails({SachielsDigitalStore.platinumTier});

                    PurchaseParam purchaseParameters = GooglePlayPurchaseParam(
                        productDetails: productDetailsResponse.productDetails.first,
                        changeSubscriptionParam: ChangeSubscriptionParam(
                            oldPurchaseDetails: purchaseDetails as GooglePlayPurchaseDetails,
                            prorationMode: ProrationMode.immediateWithTimeProration));

                    InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParameters);

                  });

                  break;
                }
                case SachielsDigitalStore.goldTier: {

                  Future.delayed(Duration.zero, () async {

                    final ProductDetailsResponse productDetailsResponse  = await InAppPurchase.instance.queryProductDetails({SachielsDigitalStore.goldTier});

                    PurchaseParam purchaseParameters = GooglePlayPurchaseParam(
                        productDetails: productDetailsResponse.productDetails.first,
                        changeSubscriptionParam: ChangeSubscriptionParam(
                            oldPurchaseDetails: purchaseDetails as GooglePlayPurchaseDetails,
                            prorationMode: ProrationMode.immediateWithTimeProration));

                    InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParameters);

                  });

                  break;
                }
                case SachielsDigitalStore.palladiumTier: {

                  Future.delayed(Duration.zero, () async {

                    final ProductDetailsResponse productDetailsResponse  = await InAppPurchase.instance.queryProductDetails({SachielsDigitalStore.palladiumTier});

                    PurchaseParam purchaseParameters = GooglePlayPurchaseParam(
                        productDetails: productDetailsResponse.productDetails.first,
                        changeSubscriptionParam: ChangeSubscriptionParam(
                            oldPurchaseDetails: purchaseDetails as GooglePlayPurchaseDetails,
                            prorationMode: ProrationMode.immediateWithTimeProration));

                    InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParameters);

                  });

                  break;
                }
                default: {



                  break;
                }
              }

            }

            if (purchaseDetails.pendingCompletePurchase) {



            }

          }

        }

      } else {



      }


    }, onDone: () {

    }, onError: (error) {

    });

    await InAppPurchase.instance.restorePurchases();

  }

}