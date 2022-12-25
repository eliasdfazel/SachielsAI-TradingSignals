/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/12/22, 6:34 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class AIStatusDataStructure {

  static const String statusMessagesName = "statusMessage";
  static const String statusAuthorName = "statusAuthor";

  Map<String, dynamic> aIStatusDataStructure = <String, dynamic>{};

  AIStatusDataStructure(DocumentSnapshot aiStatusDocument) {

    aIStatusDataStructure = aiStatusDocument.data() as Map<String, dynamic>;

  }

  String statusMessage() {

    return aIStatusDataStructure[AIStatusDataStructure.statusMessagesName];
  }

  String statusAuthor() {

    return aIStatusDataStructure[AIStatusDataStructure.statusAuthorName];
  }

}