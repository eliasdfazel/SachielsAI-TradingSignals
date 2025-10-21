
/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/16/22, 8:59 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cached_network_image/cached_network_image.dart';
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

  String profileName = StringsResources.sachielsAI();

  Widget profileImage = const Image(
    image: AssetImage("assets/cyborg_girl.jpg"),
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
        children: [

          /* Start - Share */
          Expanded(
            flex: 3,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(19, 0, 0, 0),
                    child: InkWell(
                        onTap: () {

                          SharePlus.instance.share(ShareParams(text: "${StringsResources.applicationName()}\n"
                              "${StringsResources.applicationSummary()}\n"
                              "${StringsResources.applicationLink()}"));

                        },
                        child: SizedBox(
                            height: 59,
                            width: 59,
                            child: CachedNetworkImage(imageUrl: "https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FAssets%2FSocialMedia%2Fshare_icon_small.png?alt=media")
                        )
                    )
                )
            ),
          ),
          /* End - Share */

          /* Start - Instagram */
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                  child: InkWell(
                      onTap: () {

                        launchUrl(Uri.parse(StringsResources.instagramLink()));

                      },
                      child: SizedBox(
                          height: 59,
                          width: 59,
                          child: CachedNetworkImage(imageUrl: "https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FAssets%2FSocialMedia%2Finstagram_icon.png?alt=media")
                      )
                  )
              )
          ),
          /* End - Instagram */

          /* Start - Facebook */
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                  child: InkWell(
                      onTap: () {

                        launchUrl(Uri.parse(StringsResources.facebookLink()));

                      },
                      child: SizedBox(
                          height: 59,
                          width: 59,
                          child: CachedNetworkImage(imageUrl: "https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FAssets%2FSocialMedia%2Ffacebook_icon.png?alt=media")
                      )
                  )
              )
          ),
          /* End - Facebook */

          /* Start - Twitter */
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 19, 0),
                  child: InkWell(
                      onTap: () {

                        launchUrl(Uri.parse(StringsResources.twitterLink()));

                      },
                      child: SizedBox(
                          height: 59,
                          width: 59,
                          child: CachedNetworkImage(imageUrl: "https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FAssets%2FSocialMedia%2Ftwitter_icon.png?alt=media")
                      )
                  )
              )
          ),
          /* End - Twitter */

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