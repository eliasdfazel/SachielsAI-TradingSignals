
import 'package:flutter/material.dart';
import 'package:status_bar_control/status_bar_control.dart';

void changeColor(Color statusBarColor, Color navigationBarColor) async {

  await StatusBarControl.setColor(statusBarColor, animated: true);

  await StatusBarControl.setNavigationBarColor(navigationBarColor, animated: true);

}