/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/16/22, 5:45 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:ui';

import 'package:flutter/material.dart';

double displayWidth(BuildContext context) {

  return  window.physicalSize.width;
}

double displayHeight(BuildContext context) {

  return window.physicalSize.height;
}

double safeAreaHeight(BuildContext context) {

  var padding = MediaQuery.of(context).padding;

  return displayHeight(context) - padding.top - padding.bottom;
}