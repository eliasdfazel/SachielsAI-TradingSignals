/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 9/6/22, 3:55 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/academy/archives/ui/academy_archives_interface.dart';
import 'package:sachiel/academy/data/articles_data_structure.dart';
import 'package:sachiel/in_application_browser/ui/sachiel_academy_browser.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/widgets/gradient_text/gradient.dart';

class AcademySummaryInterface extends StatefulWidget {

  const AcademySummaryInterface({Key? key}) : super(key: key);

  @override
  State<AcademySummaryInterface> createState() => _AcademySummaryInterfaceState();

}
class _AcademySummaryInterfaceState extends State<AcademySummaryInterface> {

  ScrollController scrollController = ScrollController();

  Widget articlesAcademy = Container();

  @override
  void initState() {
    super.initState();

    retrieveAcademyArticles();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 31, 0, 0),
        child: articlesAcademy
    );
  }

  void retrieveAcademyArticles() {
    debugPrint("Retrieve Latest Signals Details");

    FirebaseFirestore.instance
        .collection("/Sachiels/Academy/Articles")
        .limit(3)
        .orderBy("articleTimestamp")
        .get().then((QuerySnapshot querySnapshot) {

          List<ArticlesDataStructure> articlesDataStructure = [];

          for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

            articlesDataStructure.add(ArticlesDataStructure(queryDocumentSnapshot, ArticlesDataStructure.articlePostType));

          }

          FirebaseFirestore.instance
              .collection("/Sachiels/Academy/Tutorials")
              .limit(3)
              .orderBy("articleTimestamp")
              .get().then((QuerySnapshot querySnapshot) {

                for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

                  articlesDataStructure.add(ArticlesDataStructure(queryDocumentSnapshot, ArticlesDataStructure.tutorialPostType));

                }

                if (articlesDataStructure.isNotEmpty) {

                  prepareAcademyArticles(articlesDataStructure);

                }

              },
              onError: (e) => {

              });

        },
        onError: (e) => {

        });

  }

  void prepareAcademyArticles(List<ArticlesDataStructure> articlesDataStructure) {

    List<Widget> aAcademyArticle = <Widget>[];

    for (var articlesDataStructureItem in articlesDataStructure) {

      aAcademyArticle.add(signalDataStructureItemView(articlesDataStructureItem));

    }

    setState(() {

      articlesAcademy = Column(
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
                      crossAxisCount: 2,
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

            Padding(
                padding: const EdgeInsets.fromLTRB(0, 21, 19, 0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {

                          navigateTo(context, const AcademyArchivesInterface());

                        },
                        child: const Image(
                          image: AssetImage("assets/archive_icon.png"),
                          width: 173,
                        )
                    )
                )
            ),

          ]
      );

    });

  }

  Widget signalDataStructureItemView(ArticlesDataStructure articlesDataStructure) {
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
                          child: Container(
                              padding: const EdgeInsets.fromLTRB(13, 11, 13, 13),
                              child: GradientText(
                                articlesDataStructure.articleTitle(),
                                textAlign: TextAlign.start,
                                maxLinesNumber: 5,
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
                                color: ColorsResources.premiumLight
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