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

class BrokersDataStructure {

  static const String brokerLinkName = "brokerLink";

  static const String brokerCompanyName = "brokerCompany";
  static const String brokerLogoName = "brokerLogo";

  Map<String, dynamic> brokersDocumentData = <String, dynamic>{};

  BrokersDataStructure(DocumentSnapshot signalsDocument) {

    brokersDocumentData = signalsDocument.data() as Map<String, dynamic>;

  }

  String brokerLink() {

    return brokersDocumentData[BrokersDataStructure.brokerLinkName];
  }

  String brokerCompany() {

    return brokersDocumentData[BrokersDataStructure.brokerCompanyName];
  }

  String brokerLogo() {

    return brokersDocumentData[BrokersDataStructure.brokerLogoName];
  }

}