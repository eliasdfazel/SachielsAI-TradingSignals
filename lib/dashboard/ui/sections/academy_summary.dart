/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/8/22, 8:12 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/academy/data/articles_data_structure.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/ui/display.dart';

class AcademySummaryInterface extends StatefulWidget {

  const AcademySummaryInterface({Key? key}) : super(key: key);

  @override
  State<AcademySummaryInterface> createState() => _AcademySummaryInterfaceState();

}
class _AcademySummaryInterfaceState extends State<AcademySummaryInterface> {

  ScrollController scrollController = ScrollController();

  Widget latestSignalsDetails = Container();

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
        child: latestSignalsDetails
    );
  }

  void retrieveAcademyArticles() {
    debugPrint("Retrieve Latest Signals Details");

    FirebaseFirestore.instance
        .collection("SachielsAcademy")
        .limit(10)
        //.orderBy("articleTimestamp")
        .get().then((QuerySnapshot querySnapshot) {

          List<ArticlesDataStructure> articlesDataStructure = [];

          for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

            articlesDataStructure.add(ArticlesDataStructure(queryDocumentSnapshot));

          }

          prepareAcademyArticles(articlesDataStructure);

        },
        onError: (e) => {

        });

  }

  void prepareAcademyArticles(List<ArticlesDataStructure> articlesDataStructure) {

    List<Widget> aLatestSignal = <Widget>[];

    for (var articlesDataStructureItem in articlesDataStructure) {

      aLatestSignal.add(signalDataStructureItemView(articlesDataStructureItem));
      aLatestSignal.add(signalDataStructureItemView(articlesDataStructureItem));
      aLatestSignal.add(signalDataStructureItemView(articlesDataStructureItem));
      aLatestSignal.add(signalDataStructureItemView(articlesDataStructureItem));
      aLatestSignal.add(signalDataStructureItemView(articlesDataStructureItem));
      aLatestSignal.add(signalDataStructureItemView(articlesDataStructureItem));
      aLatestSignal.add(signalDataStructureItemView(articlesDataStructureItem));
      aLatestSignal.add(signalDataStructureItemView(articlesDataStructureItem));
      aLatestSignal.add(signalDataStructureItemView(articlesDataStructureItem));
      aLatestSignal.add(signalDataStructureItemView(articlesDataStructureItem));

    }

    int gridColumnCount = (displayWidth(context) / 173).round();

    setState(() {

      latestSignalsDetails = Column(
          children: [

            Padding(
                padding: const EdgeInsets.fromLTRB(19, 0, 0, 17),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringsResources.academyTitle(),
                      style: TextStyle(
                        fontSize: 51,
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
                  height: 513,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridColumnCount,
                      childAspectRatio: 1.39,
                      crossAxisSpacing: 19.0,
                      mainAxisSpacing: 19.0,
                    ),
                    padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: scrollController,
                    children: aLatestSignal,
                  )
              )
            ),

            Padding(
                padding: const EdgeInsets.fromLTRB(0, 21, 19, 0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {

                          // navigateTo(context, const SignalsHistoryInterface());

                        },
                        child: const Image(
                          image: AssetImage("archive_icon.png"),
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

    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(17),
                topRight: Radius.circular(17),
                bottomLeft: Radius.circular(17),
                bottomRight: Radius.circular(17)
            ),
            border: const Border(
                top: BorderSide(
                  color: ColorsResources.primaryColorDarker,
                  width: 1.3,
                ),
                bottom: BorderSide(
                  color: ColorsResources.primaryColorDarker,
                  width: 1.3,
                ),
                left: BorderSide(
                  color: ColorsResources.primaryColorDarker,
                  width: 1.3,
                ),
                right: BorderSide(
                  color: ColorsResources.primaryColorDarker,
                  width: 1.3,
                )
            ),
            color: ColorsResources.blue,
            boxShadow: [
              BoxShadow(
                  color: ColorsResources.primaryColorLightest.withOpacity(0.11),
                  blurRadius: 19,
                  offset: const Offset(0, 0)
              )
            ]
        ),
    );
  }

}