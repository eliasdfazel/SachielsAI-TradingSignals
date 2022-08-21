/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/21/22, 10:00 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/broker_suggestions/data/broker_data_structure.dart';
import 'package:sachiel/in_application_browser/ui/sachiel_brokers_browser.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';

class BrokersSuggestionsInterface extends StatefulWidget {

  const BrokersSuggestionsInterface({Key? key}) : super(key: key);

  @override
  State<BrokersSuggestionsInterface> createState() => _BrokersSuggestionsInterfaceState();

}
class _BrokersSuggestionsInterfaceState extends State<BrokersSuggestionsInterface> {

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
        .collection("SachielsBrokers")
        .limit(7)
        .get().then((QuerySnapshot querySnapshot) {

          List<BrokersDataStructure> brokersDataStructure = [];

          for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

            brokersDataStructure.add(BrokersDataStructure(queryDocumentSnapshot));

          }

          if (brokersDataStructure.isNotEmpty) {

            prepareBrokersSuggestions(brokersDataStructure);

          }

        },
        onError: (e) => {

        });

  }

  void prepareBrokersSuggestions(List<BrokersDataStructure> brokersDataStructure) {

    List<Widget> aBrokersSuggestions = <Widget>[];

    for (var articlesDataStructureItem in brokersDataStructure) {

      aBrokersSuggestions.add(brokersDataStructureItemView(articlesDataStructureItem));

    }

    setState(() {

      brokerSuggestions = Column(
          children: [

            Padding(
                padding: const EdgeInsets.fromLTRB(19, 0, 0, 17),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringsResources.brokersTitle(),
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
                    height: 301,
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(19, 0, 19, 13),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: scrollController,
                      children: aBrokersSuggestions,
                    )
                )
            ),

          ]
      );

    });

  }

  Widget brokersDataStructureItemView(BrokersDataStructure brokersDataStructure) {
    debugPrint("Broker Suggestion: ${brokersDataStructure.brokerCompany()}");

    return SizedBox(
        height: 100,
        width: 100,
        child: InkWell(
          onTap: () {

            navigateTo(context, SachielBrokersBrowser(brokersDataStructure: brokersDataStructure));

          },
          child: Image.network(
            brokersDataStructure.brokerLogo(),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          )
        )
    );
  }

}