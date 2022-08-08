/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/8/22, 7:57 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class ArticlesDataStructure {

  static const String articleLinkName = "articleLink";

  static const String articleTitleName = "articleTitle";
  static const String articleSummaryName = "articleSummary";

  static const String articleCoverName = "articleCover";

  static const String articleTimestampName = "articleTimestamp";

  Map<String, dynamic> articlesDocumentData = <String, dynamic>{};

  ArticlesDataStructure(DocumentSnapshot signalsDocument) {

    articlesDocumentData = signalsDocument.data() as Map<String, dynamic>;

  }

  String articleLink() {

    return articlesDocumentData[ArticlesDataStructure.articleLinkName];
  }

  String articleTitle() {

    return articlesDocumentData[ArticlesDataStructure.articleTitleName];
  }

  String articleSummary() {

    return articlesDocumentData[ArticlesDataStructure.articleSummaryName];
  }

  String articleCover() {

    return articlesDocumentData[ArticlesDataStructure.articleCoverName];
  }

  String tradeTimestamp() {

    return articlesDocumentData[ArticlesDataStructure.articleTimestampName];
  }

}