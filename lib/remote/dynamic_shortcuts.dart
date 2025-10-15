/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/3/23, 5:42 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/cupertino.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DynamicShortcuts {

  void setup(BuildContext context) async {

    const QuickActions quickActions = QuickActions();

    await quickActions.clearShortcutItems();

    quickActions.initialize((shortcutType) {
      debugPrint("Shortcut Type: $shortcutType");

      if (shortcutType == 'share') {
        debugPrint("Quick Action: Share");

        Future.delayed(const Duration(milliseconds: 1777), () {

          SharePlus.instance.share(ShareParams(
            text: 'Sachiels AI; Trading Signals For Forex, Cryptocurrency, Gold Market https://play.google.com/store/apps/details?id=co.geeksempire.sachiel.signals'
          ));

        });

      } else if (shortcutType == 'x') {
        debugPrint("Quick Action: X");

        launchUrlString("https://x.com/SachielsAI", mode: LaunchMode.externalApplication);

      } else if (shortcutType == 'threads') {
        debugPrint("Quick Action: Threads");

        launchUrlString("https://www.threads.net/@sachielsai", mode: LaunchMode.externalApplication);

      }

    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type: 'share', localizedTitle: 'Share', icon: 'share_icon'),
      const ShortcutItem(type: 'x', localizedTitle: 'X', icon: 'twitter_icon'),
      const ShortcutItem(type: 'threads', localizedTitle: 'Threads', icon: 'threads_icon')
    ]);

  }

}