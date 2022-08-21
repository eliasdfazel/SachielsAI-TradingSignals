/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/21/22, 6:37 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/broker_suggestions/data/broker_data_structureademy_browser.dart';
import 'package:sachiel/in_application_browser/ui/sachiel_brokers_browser.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class BrokerSuggestionsInterface extends StatefulWidget {

  const BrokerSuggestionsInterface({Key? key}) : super(key: key);

  @override
  State<BrokerSuggestionsInterface> createState() => _BrokerSuggestionsInterfaceState();

}
class _BrokerSuggestionsInterfaceState extends State<BrokerSuggestionsInterface> {

  ScrollController scrollController = ScrollController();

  Widget brokerSuggestions = Container();

  @override
  void initState() {
    super.initState();

    retrieveBrokerSuggestions();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 31, 0, 0),
        child: brokerSuggestions
    );
  }

  void retrieveBrokerSuggestions() {
    debugPrint("Retrieve Brokers Suggestions");

    FirebaseFirestore.instance
        .collection("SachielsBrokersSuggestions")
        .limit(13)
        .orderBy("articleTimestamp")
        .get().then((QuerySnapshot querySnapshot) {

      List<BrokersDataStructure> brokersDataStructure = [];

      for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

        brokersDataStructure.add(BrokersDataStructure(queryDocumentSnapshot));

      }

      prepareAcademyArticles(brokersDataStructure);

    },
        onError: (e) => {

        });

  }

  void prepareAcademyArticles(List<BrokersDataStructure> brokersDataStructure) {

    List<Widget> aLatestSignal = <Widget>[];

    for (var articlesDataStructureItem in brokersDataStructure) {

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

    setState(() {

      brokerSuggestions = Column(
          children: [

            Padding(
                padding: const EdgeInsets.fromLTRB(19, 0, 0, 17),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringsResources.brokerSuggestionsTitle(),
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

  Widget signalDataStructureItemView(BrokersDataStructure brokersDataStructure) {
    debugPrint("Broker Suggestion: ${brokersDataStructure.brokerCompany()}");

    return InkWell(
        onTap: () {

          navigateTo(context, SachielBrokersBrowser(brokersDataStructure: brokersDataStructure));

        },
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: ColorsResources.primaryColorLightest.withOpacity(0.11),
                    blurRadius: 7,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    /* Start - Article Cover */
                    SizedBox(
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(17),
                          child: Image.network(
                            brokersDataStructure.brokerLogo(),
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
                              brokersDataStructure.brokerCompany(),
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
              )
          ),
        )
    );
  }

}