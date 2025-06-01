/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 12/6/22, 6:59 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:async';
import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sachiel/dashboard/ui/dashboard_interface.dart';
import 'package:sachiel/remote/remote_configurations.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/store/data/plans_data_structure.dart';
import 'package:sachiel/store/utils/android/subscription_changes.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/io/file_io.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:sachiel/utils/ui/system_bars.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_mask/widget_mask.dart';

class SachielsDigitalStore extends StatefulWidget {

  double topPadding = 0;

  SachielsDigitalStore({Key? key, required this.topPadding}) : super(key: key);

  static const String previewTier = "preview.sachiel";
  static const String previewTopic = "Preview";

  static const String platinumTier = "platinum.sachiel";
  static const String platinumTopic = "Platinum";

  static const String goldTier = "gold.sachiel";
  static const String goldTopic = "Gold";

  static const String palladiumTier = "palladium.sachiel";
  static const String palladiumTopic = "Palladium";

  static const String privilegedTopic = "Privileged";

  @override
  State<SachielsDigitalStore> createState() => _SachielsDigitalStoreState();

}
class _SachielsDigitalStoreState extends State<SachielsDigitalStore> {

  RemoteConfigurations remoteConfigurations = RemoteConfigurations();

  StreamSubscription<List<PurchaseDetails>>? streamSubscription;

  Widget allPurchasingPlans = Container(
    alignment: Alignment.center,
    child: LoadingAnimationWidget.staggeredDotsWave(
      colorOne: ColorsResources.premiumLight,
      colorTwo: ColorsResources.primaryColor,
      size: 73,
    )
  );

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    navigatePop(context);
    navigateTo(context, const DashboardInterface());

    return true;
  }

  bool animationVisibility = false;

  @override
  void dispose() {

    BackButtonInterceptor.remove(aInterceptor);

    streamSubscription?.cancel();

    super.dispose();
  }

  @override
  void initState() {

    BackButtonInterceptor.add(aInterceptor);

    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;

    streamSubscription = purchaseUpdated.listen((purchaseDetailsList) {

      purchaseUpdatedListener(purchaseDetailsList);

    }, onDone: () {

      streamSubscription?.cancel();

    }, onError: (error) {

    }) as StreamSubscription<List<PurchaseDetails>>?;

    retrievePurchasingPlans();

    super.initState();

    changeColor(ColorsResources.black, ColorsResources.black);

    prototypeProcess();

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.fromLTRB(0, widget.topPadding, 0, 0),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: StringsResources.applicationName(),
          color: ColorsResources.primaryColor,
          theme: ThemeData(
            fontFamily: 'Ubuntu',
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            }),
          ),
          home: Scaffold(
              backgroundColor: ColorsResources.black,
              body: Stack(
                children: [

                  /* Start - Gradient Background - Dark */
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(17),
                            topRight: Radius.circular(17),
                            bottomLeft: Radius.circular(17),
                            bottomRight: Radius.circular(17)
                        ),
                        border: Border(
                            top: BorderSide(
                              color: ColorsResources.black,
                              width: 7,
                            ),
                            bottom: BorderSide(
                              color: ColorsResources.black,
                              width: 7,
                            ),
                            left: BorderSide(
                              color: ColorsResources.black,
                              width: 7,
                            ),
                            right: BorderSide(
                              color: ColorsResources.black,
                              width: 7,
                            )
                        ),
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
                      )
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

                  allPurchasingPlans,

                  /* Start - Back */
                  Row(
                    children: [

                      /* Start - Back */
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(19, 19, 0, 0),
                              child: SizedBox(
                                  height: 59,
                                  width: 59,
                                  child: InkWell(
                                    onTap: () {

                                      navigatePop(context);

                                    },
                                    child: const Image(
                                      image: AssetImage("assets/back_icon.png"),
                                    ),
                                  )
                              )
                          )
                      ),
                      /* End - Back */

                      /* Start - Title */
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(19, 19, 0, 0),
                              child: SizedBox(
                                  height: 59,
                                  width: 155,
                                  child: Stack(
                                    children: [
                                      WidgetMask(
                                        blendMode: BlendMode.srcATop,
                                        childSaveLayer: true,
                                        mask /* Original Image */: Container(
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                    ColorsResources.premiumDark,
                                                    ColorsResources.black,
                                                  ],
                                                  transform: GradientRotation(45)
                                              )
                                          ),
                                        ),
                                        child: const Image(
                                          image: AssetImage("assets/rectircle_shape.png"),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: const EdgeInsets.all(1.9),
                                              child: WidgetMask(
                                                  blendMode: BlendMode.srcATop,
                                                  childSaveLayer: true,
                                                  mask /* Original Image */: Container(
                                                    decoration: const BoxDecoration(
                                                        gradient: LinearGradient(
                                                            colors: [
                                                              ColorsResources.black,
                                                              ColorsResources.premiumDark,
                                                            ],
                                                            transform: GradientRotation(45)
                                                        )
                                                    ),
                                                  ),
                                                  child: const Image(
                                                    image: AssetImage("assets/rectircle_shape.png"),
                                                  )
                                              )
                                          )
                                      ),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                              padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                              child: Text(
                                                  StringsResources.storeTitle(),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: ColorsResources.premiumLight,
                                                      fontSize: 19
                                                  )
                                              )
                                          )
                                      )
                                    ],
                                  )
                              )
                          )
                      ),
                      /* End - Title */

                    ],
                  ),
                  /* End - Back */

                  /* Start - Purchase Information (Try Restore If Nothing Purchased, Redirect to Link) */
                  Positioned(
                      right: 19,
                      top: 19,
                      child: Container(
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: ColorsResources.primaryColorLighter,
                                  blurRadius: 51,
                                  spreadRadius: 0,
                                  offset: Offset(0, 0)
                              )
                            ]
                        ),
                        child: SizedBox(
                            height: 59,
                            width: 59,
                            child: InkWell(
                                onTap: () async {

                                  fileExist(StringsResources.filePurchasingPlan).then((alreadyPurchased) => {

                                    if (alreadyPurchased) {

                                      // navigateTo(context, const DashboardInterface())

                                    } else {

                                      launchUrl(Uri.parse("https://GeeksEmpire.co/Sachiels/PurchasingPlans"), mode: LaunchMode.externalApplication)

                                  }

                                  });

                                },
                                child: const Image(
                                  image: AssetImage("assets/golden_information_icon.png"),
                                )
                            )
                        ),
                      )
                  ),
                  /* End - Purchase Information (Try Restore If Nothing Purchased, Redirect to Link) */

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Visibility(
                        visible: animationVisibility,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 153),
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            colorOne: ColorsResources.premiumLight,
                            colorTwo: ColorsResources.primaryColor,
                            size: 53,
                          )
                        )
                    )
                  )

                ],
              )
          )
      )
    );
  }

  void retrievePurchasingPlans() async {
    debugPrint("Retrieve Latest Signals Details");

    User firebaseUser = FirebaseAuth.instance.currentUser!;

    FirebaseFirestore.instance
        .doc("/Sachiels/Subscribers/Externals/${firebaseUser.email!.toLowerCase()}")
        .get().then((DocumentSnapshot documentSnapshot) {

          if (documentSnapshot.exists) {

            processExternalSubscriber(
                documentSnapshot.get("emailAddress"),
                documentSnapshot.get("purchasedPlan"),
                documentSnapshot.get("expiryTime")
            );

          } else {

            FirebaseFirestore.instance
                .collection("/Sachiels/Signals/Plans")
                .orderBy("purchasingPlanPrice")
                .get().then((QuerySnapshot querySnapshot) async {

                  List<PlansDataStructure> plansDataStructure = [];

                  for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

                    PlansDataStructure planDataStructure = PlansDataStructure(queryDocumentSnapshot);

                    final ProductDetailsResponse productDetailsResponse = await InAppPurchase.instance.queryProductDetails({planDataStructure.purchasingPlanProductId()});

                    planDataStructure.purchasingPrice = productDetailsResponse.productDetails.first.price;

                    plansDataStructure.add(planDataStructure);

                  }

                  if (plansDataStructure.isNotEmpty) {

                    prepareStoreItems(plansDataStructure);

                  }

                },
                onError: (e) => {

                });

          }

        }, onError: (e) => {

        });

  }

  void prepareStoreItems(List<PlansDataStructure> plansDataStructure) async {

    bool alreadyPurchased = await fileExist(StringsResources.filePurchasingPlan);

    String purchasedPlan = "";

    if (alreadyPurchased) {

      purchasedPlan = await readFileOfTexts(StringsResources.fileNamePurchasingPlan, "TXT");

    }

    if (purchasedPlan.toLowerCase() != SachielsDigitalStore.previewTier) {

      plansDataStructure.removeWhere((element) => element.purchasingPlanProductId() == SachielsDigitalStore.previewTier);

    }

    List<Widget> storeItems = [];

    for (PlansDataStructure planDataStructureItem in plansDataStructure) {

      storeItems.add(plansDataStructureItemView(planDataStructureItem));

    }

    setState(() {

      allPurchasingPlans = Padding(
        padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(19, 0, 0, 0),
          physics: const PageScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: storeItems,
        )
      );

    });

  }

  Widget plansDataStructureItemView(PlansDataStructure plansDataStructure) {
    debugPrint("Plan Details: ${plansDataStructure.plansDocumentData}");

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 91, 37, 19),
      child: SizedBox(
        height: double.maxFinite,
        width: 353,
        child: InkWell(
            onTap: () async {

              switch (plansDataStructure.purchasingPlanProductId()) {
                case SachielsDigitalStore.previewTier: {

                  setState(() {
                    animationVisibility = true;
                  });

                  final ProductDetailsResponse productDetailsResponse  = await InAppPurchase.instance.queryProductDetails({SachielsDigitalStore.previewTier});

                  PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetailsResponse.productDetails.first);

                  await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);

                  break;
                }
                case SachielsDigitalStore.platinumTier: {

                  setState(() {
                    animationVisibility = true;
                  });

                  final ProductDetailsResponse productDetailsResponse  = await InAppPurchase.instance.queryProductDetails({SachielsDigitalStore.platinumTier});

                  bool alreadyPurchased = await fileExist(StringsResources.filePurchasingPlan);

                  if (Platform.isAndroid && alreadyPurchased) {

                    Future.delayed(const Duration(milliseconds: 0), () async {

                      await streamSubscription?.cancel();

                      AndroidSubscriptionChanges()
                          .changeSubscription();

                    });

                  } else {

                    ProductDetails productDetails = productDetailsResponse.productDetails.first;

                    if (productDetailsResponse.productDetails.length > 1) {

                      productDetails = productDetailsResponse.productDetails[1];

                    }

                    PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);

                    await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam, );

                  }

                  break;
                }
                case SachielsDigitalStore.goldTier: {

                  setState(() {
                    animationVisibility = true;
                  });

                  final ProductDetailsResponse productDetailsResponse  = await InAppPurchase.instance.queryProductDetails({SachielsDigitalStore.goldTier});

                  bool alreadyPurchased = await fileExist(StringsResources.filePurchasingPlan);

                  if (Platform.isAndroid && alreadyPurchased) {

                    Future.delayed(const Duration(milliseconds: 0), () async {

                      await streamSubscription?.cancel();

                      AndroidSubscriptionChanges()
                          .changeSubscription();

                    });

                  } else {

                    ProductDetails productDetails = productDetailsResponse.productDetails.first;

                    if (productDetailsResponse.productDetails.length > 1) {

                      productDetails = productDetailsResponse.productDetails[1];

                    }

                    PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);

                    await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);

                  }

                  break;
                }
                case SachielsDigitalStore.palladiumTier: {

                  setState(() {
                    animationVisibility = true;
                  });

                  final ProductDetailsResponse productDetailsResponse  = await InAppPurchase.instance.queryProductDetails({SachielsDigitalStore.palladiumTier});

                  bool alreadyPurchased = await fileExist(StringsResources.filePurchasingPlan);

                  if (Platform.isAndroid && alreadyPurchased) {

                    Future.delayed(const Duration(milliseconds: 0), () async {

                      await streamSubscription?.cancel();

                      AndroidSubscriptionChanges()
                          .changeSubscription();

                    });

                  } else {

                    ProductDetails productDetails = productDetailsResponse.productDetails.first;

                    if (productDetailsResponse.productDetails.length > 1) {

                      productDetails = productDetailsResponse.productDetails[1];

                    }

                    PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);

                    await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);

                  }

                  break;
                }
              }

            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(17),
                  child: Image.network(
                    plansDataStructure.purchasingPlanSnapshot(),
                    height: 353,
                    width: 353,
                    fit: BoxFit.contain,
                  )
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                  child: Html(
                      data: "${plansDataStructure.purchasingPlanPrice()} - ${plansDataStructure.purchasingPlanDescription()}"
                  )
                ),

                const Image(
                  image: AssetImage("assets/purchasing_icon.png"),
                  height: 73,
                  width: 353,
                  fit: BoxFit.contain,
                )

              ],
            )
        )
      )
    );
  }

  void purchaseUpdatedListener(List<PurchaseDetails> purchaseDetailsList) async {

    for (var purchaseDetails in purchaseDetailsList) {

      if (purchaseDetails.status == PurchaseStatus.pending) {


      } else {

        if (purchaseDetails.status == PurchaseStatus.error) {



        } else if (purchaseDetails.status == PurchaseStatus.purchased
            || purchaseDetails.status == PurchaseStatus.restored) {

          switch (purchaseDetails.productID) {
            case SachielsDigitalStore.previewTier: {

              FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
              await firebaseMessaging.subscribeToTopic(SachielsDigitalStore.previewTopic);

              await firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.platinumTopic);
              await firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.goldTopic);
              await firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.palladiumTopic);

              setState(() {
                animationVisibility = false;
              });

              break;
            }
            case SachielsDigitalStore.platinumTier: {

              FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
              await firebaseMessaging.subscribeToTopic(SachielsDigitalStore.platinumTopic);

              await firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.goldTopic);
              await firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.palladiumTopic);

              await firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.previewTopic);

              setState(() {
                animationVisibility = false;
              });

              break;
            }
            case SachielsDigitalStore.goldTier: {

              FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
              await firebaseMessaging.subscribeToTopic(SachielsDigitalStore.goldTopic);

              await firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.platinumTopic);
              await firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.palladiumTopic);

              await firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.previewTopic);

              setState(() {
                animationVisibility = false;
              });

              break;
            }
            case SachielsDigitalStore.palladiumTier: {

              FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
              await firebaseMessaging.subscribeToTopic(SachielsDigitalStore.palladiumTopic);

              await firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.platinumTopic);
              await firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.goldTopic);

              await firebaseMessaging.unsubscribeFromTopic(SachielsDigitalStore.previewTopic);

              setState(() {
                animationVisibility = false;
              });

              break;
            }
          }

          createFileOfTexts(StringsResources.fileNamePurchasingPlan, "TXT", purchaseDetails.productID);

        }

        if (purchaseDetails.pendingCompletePurchase) {

          await InAppPurchase.instance.completePurchase(purchaseDetails);

          createFileOfTexts(StringsResources.fileNamePurchasingPlan, "TXT", purchaseDetails.productID);

          if (widget.topPadding == 0) {

            navigatePop(context);

          } else {

            navigateTo(context, const DashboardInterface());

          }

        }

      }

    }

  }

  /// Formatted Text for Expiry Date MM-DD-YYYY
  void processExternalSubscriber(String emailAddress, String purchasedPlan, String expiryTime) {

    createFileOfTexts(StringsResources.fileNamePurchasingTime, "TXT", expiryTime);

    createFileOfTexts(StringsResources.fileNamePurchasingPlan, "TXT", purchasedPlan).then((value) => {

      Future.delayed(const Duration(milliseconds: 137), () async {

        FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
        await firebaseMessaging.subscribeToTopic(purchasedPlan);

        // navigateToWithPop(context, const DashboardInterface());

    })

    });

  }

  void prototypeProcess() {

    remoteConfigurations.initialize().then((firebaseRemoteConfigurations) {

      firebaseRemoteConfigurations.activate().then((value) async {

        String sachielPrincipal = firebaseRemoteConfigurations.getString(RemoteConfigurations.sachielPrincipal);

        if (sachielPrincipal.contains(FirebaseAuth.instance.currentUser!.email.toString())) {

          FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
          firebaseMessaging.subscribeToTopic(SachielsDigitalStore.platinumTopic);
          firebaseMessaging.subscribeToTopic(SachielsDigitalStore.goldTopic);
          firebaseMessaging.subscribeToTopic(SachielsDigitalStore.palladiumTopic);

          firebaseMessaging.subscribeToTopic(SachielsDigitalStore.privilegedTopic);

          createFileOfTexts(StringsResources.fileNamePurchasingPlan, "TXT", "Palladium").then((value) => {

            navigateToWithPop(context, const DashboardInterface())

          });

        }

      });

    });

  }

}