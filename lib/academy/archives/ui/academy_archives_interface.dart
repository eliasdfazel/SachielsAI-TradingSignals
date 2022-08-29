/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/29/22, 10:07 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/academy/data/articles_data_structure.dart';
import 'package:sachiel/dashboard/ui/sections/purchase_plan_picker.dart';
import 'package:sachiel/in_application_browser/ui/sachiel_academy_browser.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:sachiel/utils/ui/system_bars.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AcademyArchivesInterface extends StatefulWidget {

  const AcademyArchivesInterface({Key? key}) : super(key: key);

  @override
  State<AcademyArchivesInterface> createState() => _AcademyArchivesInterfaceState();

}
class _AcademyArchivesInterfaceState extends State<AcademyArchivesInterface> {

  ScrollController scrollController = ScrollController();

  Widget articlesAcademy = Container();

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.black, ColorsResources.black);

    retrieveAcademyArticles();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringsResources.applicationName(),
        color: ColorsResources.primaryColor,
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
          backgroundColor: ColorsResources.black,
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
                  ),
                ),
                /* End - Gradient Background - Dark */

                /* Start - Branding Transparent */
                const Align(
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: 0.1,
                    child: Image(
                      image: AssetImage("logo.png"),
                    ),
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
                        height: calculatePercentage(99, displayHeight(context)),
                        width: calculatePercentage(99, displayWidth(context)),
                      ),
                    )
                ),
                /* End - Gradient Background - Golden */

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                  child: ListView(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 37),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: [



                      ]
                  )
                ),

                /* Start - Purchase Plan Picker */
                const Positioned(
                    right: 19,
                    top: 19,
                    child: PurchasePlanPicker()
                ),
                /* End - Purchase Plan Picker */

              ],
            )
        )
    );
  }

  void retrieveAcademyArticles() {
    debugPrint("Retrieve Latest Signals Details");

    /* Start - Academy Tutorials */
    FirebaseFirestore.instance
        .collection("/Sachiels/Academy/Tutorials")
        .limit(13)
        .orderBy("articleTimestamp")
        .get().then((QuerySnapshot querySnapshot) {

      List<ArticlesDataStructure> articlesDataStructure = [];

      for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

        articlesDataStructure.add(ArticlesDataStructure(queryDocumentSnapshot, ArticlesDataStructure.tutorialPostType));

      }

      if (articlesDataStructure.isNotEmpty) {



      }

    },
        onError: (e) => {

        });
    /* End - Academy Tutorials */

    /* Start - Academy Articles */
    FirebaseFirestore.instance
        .collection("/Sachiels/Academy/Articles")
        .limit(13)
        .orderBy("articleTimestamp")
        .get().then((QuerySnapshot querySnapshot) {

          List<ArticlesDataStructure> articlesDataStructure = [];

          for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

            articlesDataStructure.add(ArticlesDataStructure(queryDocumentSnapshot, ArticlesDataStructure.articlePostType));

          }

          if (articlesDataStructure.isNotEmpty) {

            prepareAcademyArticles(articlesDataStructure);

          }

        },
        onError: (e) => {

        });
    /* End - Academy Articles */

    /* Start - Academy News */
    FirebaseFirestore.instance
        .collection("/Sachiels/Academy/News")
        .limit(13)
        .orderBy("articleTimestamp")
        .get().then((QuerySnapshot querySnapshot) {

          List<ArticlesDataStructure> articlesDataStructure = [];

          for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

            articlesDataStructure.add(ArticlesDataStructure(queryDocumentSnapshot, ArticlesDataStructure.newsPostType));

          }

          if (articlesDataStructure.isNotEmpty) {



          }

        },
        onError: (e) => {

        });
    /* End - Academy News */

  }

  void prepareAcademyArticles(List<ArticlesDataStructure> articlesDataStructure) {

    List<Widget> aAcademyArticle = <Widget>[];

    for (var articlesDataStructureItem in articlesDataStructure) {

      aAcademyArticle.add(academyArticlesItem(articlesDataStructureItem));

    }

    setState(() {

      articlesAcademy = ListView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 37),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [

            Padding(
                padding: const EdgeInsets.fromLTRB(19, 0, 0, 17),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringsResources.academyTitle(),
                      style: TextStyle(
                          fontSize: 37,
                          letterSpacing: 1.7,
                          color: ColorsResources.premiumLight,
                          shadows: [
                            Shadow(
                                color: ColorsResources.black.withOpacity(0.13),
                                blurRadius: 13,
                                offset: const Offset(0, 7)
                            )
                          ]
                      ),
                    )
                )
            ),

            Padding(
                padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                child: SizedBox(
                    height: 751,
                    child: GridView(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.39,
                        crossAxisSpacing: 19.0,
                        mainAxisSpacing: 19.0,
                      ),
                      padding: const EdgeInsets.fromLTRB(19, 0, 19, 13),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: scrollController,
                      children: aAcademyArticle,
                    )
                )
            ),

          ]
      );

    });

  }

  Widget academyArticlesItem(ArticlesDataStructure articlesDataStructure) {
    debugPrint("Academy Article: ${articlesDataStructure.articleTitle()}");

    return InkWell(
        onTap: () {

          navigateTo(context, SachielAcademyBrowser(articlesDataStructure: articlesDataStructure));

        },
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: ColorsResources.primaryColorLightest.withOpacity(0.09),
                    blurRadius: 11,
                    offset: const Offset(0, 3)
                )
              ]
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17)
                    ),
                    gradient: LinearGradient(
                      colors: [
                        ColorsResources.dark.withOpacity(0.73),
                        ColorsResources.premiumDark,
                      ],
                      transform: const GradientRotation(-45),
                    ),
                  ),
                  child: Stack(
                      children: [

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            /* Start - Article Cover */
                            SizedBox(
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(17),
                                    topRight: Radius.circular(17),
                                    bottomRight: Radius.circular(11),
                                    bottomLeft: Radius.circular(11),
                                  ),
                                  child: Image.network(
                                    articlesDataStructure.articleCover(),
                                    alignment: Alignment.center,
                                    fit: BoxFit.cover,
                                  ),
                                )
                            ),
                            /* End - Article Cover */

                            /* Start - Article Text */
                            SizedBox(
                                height: 130,
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(13, 11, 13, 13),
                                    child: GradientText(
                                      articlesDataStructure.articleTitle(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 17,
                                          decoration: TextDecoration.none,
                                          shadows: [
                                            Shadow(
                                                color: ColorsResources.black.withOpacity(0.57),
                                                blurRadius: 7,
                                                offset: const Offset(0.0, 3.0)
                                            )
                                          ]
                                      ),
                                      colors: const <Color> [
                                        ColorsResources.premiumLight,
                                        ColorsResources.white,
                                      ],
                                    )
                                )
                            )
                            /* End - Article Text */

                          ],
                        ),

                        const Positioned(
                          left: 0,
                          top: 0,
                          child: SizedBox(
                            height: 21,
                            width: 73,
                            child: Blur(
                                blur: 3,
                                blurColor: ColorsResources.premiumDark,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(17),
                                  topRight: Radius.circular(7),
                                  bottomRight: Radius.circular(17),
                                  bottomLeft: Radius.circular(7),
                                ),
                                colorOpacity: 0.07,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 21,
                                  width: 73,
                                )
                            ),
                          ),
                        ),
                        Positioned(
                            left: 0,
                            top: 0,
                            child: SizedBox(
                                height: 21,
                                width: 73,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      articlesDataStructure.initialPostType,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: ColorsResources.light
                                      ),
                                    )
                                )
                            )
                        )

                      ]
                  )
              )
          ),
        )
    );
  }

}