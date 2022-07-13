/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/12/22, 6:24 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:sachiel/data/signals_data_structure.dart';

class LastSignalDetails extends StatefulWidget {

  const LastSignalDetails({Key? key}) : super(key: key);

  @override
  State<LastSignalDetails> createState() => _LastSignalDetailsState();
}
class _LastSignalDetailsState extends State<LastSignalDetails> {

  List<Widget> lastSignalDetails = [];

  @override
  void initState() {
    super.initState();

    retrieveLastSignalDetails();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 311,
      height: 179,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(19, 0, 19, 73),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: lastSignalDetails,
      ),
    );
  }

  void retrieveLastSignalDetails() async {



  }

  void prepareLastSignalsDetails(SignalsDataStructure signalsDataStructure) {

    setState(() {

      lastSignalDetails;

    });

  }

  Widget overviewDetailsView(SignalsDataStructure signalsDataStructure) {

    return Container(

    );
  }

  Widget technicalDetailsView(SignalsDataStructure signalsDataStructure) {

    return Container(

    );
  }

  Widget shareDetailsView(SignalsDataStructure signalsDataStructure) {

    return Container(

    );
  }

}
