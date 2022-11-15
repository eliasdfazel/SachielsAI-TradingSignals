
/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/15/22, 8:19 AM
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

    return Row(
      children: [

        /* Start - Profile Image */
        Expanded(
          flex: 1,
          child: InkWell(
              onTap: () {

                Share.share("${StringsResources.applicationName()}\n"
                    "${StringsResources.applicationSummary()}\n"
                    "${StringsResources.applicationLink()}");

              },
              child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: SizedBox(
                          height: 59,
                          width: 59,
                          child: Image(
                            image: AssetImage("share_icon_small.png"),
                          )
                      )
                  )
              )
          ),
        )
        /* End - Profile Image */

      ],
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