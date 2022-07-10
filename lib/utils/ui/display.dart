/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/9/22, 6:12 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';

double displayWidth(BuildContext context) {

  return  MediaQuery.of(context).size.width;
}

double displayHeight(BuildContext context) {

  return MediaQuery.of(context).size.height;
}

double safeAreaHeight(BuildContext context) {

  var padding = MediaQuery.of(context).padding;

  return displayHeight(context) - padding.top - padding.bottom;
}