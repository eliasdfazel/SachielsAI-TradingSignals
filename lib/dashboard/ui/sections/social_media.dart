
/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/15/22, 8:57 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/profile/ui/account_information_details.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedia extends StatefulWidget {

  const SocialMedia({Key? key}) : super(key: key);

  @override
  State<SocialMedia> createState() => SocialMediaStates();

}
class SocialMediaStates extends State<SocialMedia> {

  User? firebaseUser = FirebaseAuth.instance.currentUser;

  String profileName = StringsResources.sachielAI();

  Widget profileImage = const Image(
    image: AssetImage("cyborg_girl.jpg"),
    fit: BoxFit.cover,
  );

  @override
  void initState() {
    super.initState();

    retrieveAccountInformation();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 59,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          /* Start - Share */
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: InkWell(
                      onTap: () {

                        Share.share("${StringsResources.applicationName()}\n"
                            "${StringsResources.applicationSummary()}\n"
                            "${StringsResources.applicationLink()}");

                      },
                      child: SizedBox(
                          height: 59,
                          width: 59,
                          child: Image.network("https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FAssets%2FSocialMedia%2Fshare_icon_small.png?alt=media")
                      )
                  )
              )
          ),
          /* End - Share */

          /* Start - Twitter */
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: InkWell(
                      onTap: () {

                        launchUrl(Uri.parse(StringsResources.twitterLink()));

                      },
                      child: SizedBox(
                          height: 59,
                          width: 59,
                          child: Image.network("https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FAssets%2FSocialMedia%2Ftwitter_icon.png?alt=media")
                      )
                  )
              )
          ),
          /* End - Twitter */

          /* Start - Facebook */
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: InkWell(
                      onTap: () {

                        launchUrl(Uri.parse(StringsResources.facebookLink()));

                      },
                      child: SizedBox(
                          height: 59,
                          width: 59,
                          child: Image.network("https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FAssets%2FSocialMedia%2Ffacebook_icon.png?alt=media")
                      )
                  )
              )
          ),
          /* End - Facebook */

          /* Start - Instagram */
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: InkWell(
                      onTap: () {

                        launchUrl(Uri.parse(StringsResources.instagramLink()));

                      },
                      child: SizedBox(
                          height: 59,
                          width: 59,
                          child: Image.network("https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FAssets%2FSocialMedia%2Finstagram_icon.png?alt=media")
                      )
                  )
              )
          )
          /* End - Instagram */

        ],
      ),
    );
  }

  void retrieveAccountInformation() async {

    if (firebaseUser != null) {

      profileName = firebaseUser!.displayName!;

      profileImage = Image.network(
        firebaseUser!.photoURL.toString(),
        fit: BoxFit.cover,
      );

      Future.delayed(const Duration(milliseconds: 137), () {

        setState(() {

          profileName;

          profileImage;

        });

      });

    }

  }

  void openAccountInformation() {

    navigateTo(context, const AccountInformationDetails());

  }

}