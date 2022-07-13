/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/12/22, 5:25 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class SignalsDataStructure {

  Map<String, dynamic> signalsDocumentData = <String, dynamic>{};

  SignalsDataStructure(DocumentSnapshot signalsDocument) {

    signalsDocumentData = signalsDocument.data() as Map<String, dynamic>;

  }

  /// Buy Or Sell Command
  String tradeCommand() {

    return signalsDocumentData[""];
}

}