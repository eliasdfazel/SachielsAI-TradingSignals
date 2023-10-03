/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/3/23, 5:42 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/rendering.dart';
import 'package:quick_actions/quick_actions.dart';

class DynamicShortcuts {

  void setup() async {

    const QuickActions quickActions = QuickActions();

    quickActions.initialize((shortcutType) {

      if (shortcutType == 'share') {
        debugPrint("Quick Action: History");

      } else if (shortcutType == 'History') {
        debugPrint("Quick Action: History");

      } else if (shortcutType == 'twitter') {
        debugPrint("Quick Action: Twitter");

      } else if (shortcutType == 'threads') {
        debugPrint("Quick Action: Threads");

      }

    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type: 'share', localizedTitle: 'Share', icon: 'share_icon'),
      const ShortcutItem(type: 'history', localizedTitle: 'History'),
      const ShortcutItem(type: 'twitter', localizedTitle: 'X', icon: 'twitter_icon'),
      const ShortcutItem(type: 'threads', localizedTitle: 'Threads', icon: 'threads_icon')
    ]);

  }

}