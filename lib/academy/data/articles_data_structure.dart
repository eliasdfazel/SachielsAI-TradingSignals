/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/24/22, 9:13 AM
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

  String initialPostType = "Article";
  static const articlePostType = "Article";
  static const newsPostType = "News";
  static const tutorialPostType = "Tutorial";

  Map<String, dynamic> articlesDocumentData = <String, dynamic>{};

  ArticlesDataStructure(DocumentSnapshot signalsDocument, String postType) {

    articlesDocumentData = signalsDocument.data() as Map<String, dynamic>;

    initialPostType = postType;

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