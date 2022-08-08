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

class SignalsDataStructure {

  static const String tradeCommandName = "tradeCommand";
  static const String tradeMarketPairName = "tradeMarketPair";

  static const String tradeAccuracyPercentageName = "tradeAccuracyPercentage";

  static const String tradeEntryPriceName = "tradeEntryPrice";
  static const String tradeTakeProfitName = "tradeTakeProfit";
  static const String tradeStopLossName = "tradeStopLoss";

  static const String tradeLotSizeName = "tradeLotSize";
  static const String tradeProfitAmountName = "tradeProfitAmount";

  static const String tradeTimeframeName = "tradeTimeframe";

  static const String tradeTimestampName = "tradeTimestamp";

  Map<String, dynamic> signalsDocumentData = <String, dynamic>{};

  SignalsDataStructure(DocumentSnapshot signalsDocument) {

    signalsDocumentData = signalsDocument.data() as Map<String, dynamic>;

  }

  /// Buy Or Sell Command
  String tradeCommand() {

    return signalsDocumentData[SignalsDataStructure.tradeCommandName];
  }
  /// Trade Market Pair/Name (For Example, XAUUSD or Crude Oil or GOOGL)
  String tradeMarketPair() {

    return signalsDocumentData[SignalsDataStructure.tradeMarketPairName];
  }

  /// Trade Accuracy In Percentage
  String tradeAccuracyPercentage() {

    return signalsDocumentData[SignalsDataStructure.tradeAccuracyPercentageName];
  }

  /// Trade Entry Price
  String tradeEntryPrice() {

    return signalsDocumentData[SignalsDataStructure.tradeEntryPriceName];
  }
  /// Trade Take Profit Price
  String tradeTakeProfit() {

    return signalsDocumentData[SignalsDataStructure.tradeTakeProfitName];
  }
  /// Trade Stop Loss Price
  String tradeStopLoss() {

    return signalsDocumentData[SignalsDataStructure.tradeStopLossName];
  }

  /// Trade Lot Size Unit (Recommended)
  String tradeLotSize() {

    return signalsDocumentData[SignalsDataStructure.tradeLotSizeName];
  }

  /// Trade Profit Amount In Dollar
  String tradeProfitAmount() {

    return signalsDocumentData[SignalsDataStructure.tradeProfitAmountName];
  }

  /// Trade Timeframe (Interval - 1 Hour, 4 Hours, Daily & etc)
  String tradeTimeframe() {

    return signalsDocumentData[SignalsDataStructure.tradeTimeframeName];
  }

  /// Trade Timestamp
  String tradeTimestamp() {

    return signalsDocumentData[SignalsDataStructure.tradeTimestampName];
  }

}