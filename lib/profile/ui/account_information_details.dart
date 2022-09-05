/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 9/5/22, 2:30 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sachiel/resources/strings_resources.dart';

class AccountInformationDetails extends StatefulWidget {

  const AccountInformationDetails({Key? key}) : super(key: key);

  @override
  State<AccountInformationDetails> createState() => AccountInformationDetailsStates();
}
class AccountInformationDetailsStates extends State<AccountInformationDetails> {

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

    return Container();
  }

  void retrieveAccountInformation() async {

    if (firebaseUser != null) {

      profileName = firebaseUser!.displayName!;

      profileImage = Image.network(
        firebaseUser!.photoURL.toString(),
        fit: BoxFit.cover,
      );

      setState(() {

        profileName;

        profileImage;

      });

    }

  }

}