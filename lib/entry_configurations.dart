/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/9/22, 6:12 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/authentication/google_authentication.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:sachiel/utils/ui/system_bars.dart';

class EntryConfigurations extends StatefulWidget {

  const EntryConfigurations({Key? key}) : super(key: key);

  @override
  State<EntryConfigurations> createState() => _EntryConfigurationsState();
}
class _EntryConfigurationsState extends State<EntryConfigurations> {

  GoogleAuthentication googleAuthentication = GoogleAuthentication();

  FirebaseAuth firebaseAuthentication = FirebaseAuth.instance;

  Widget phoneNumberAuthentication = Container();

  @override
  void initState() {
    super.initState();

    firebaseAuthentication.currentUser?.reload();

    changeColor(ColorsResources.black, ColorsResources.black);

  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(milliseconds: 1357), () {

      FlutterNativeSplash.remove();

    });

    if (firebaseAuthentication.currentUser == null) {

      Future.delayed(const Duration(milliseconds: 1357), () async {

        UserCredential userCredential = await googleAuthentication.startProcess();

        if (userCredential.user!.phoneNumber == null) {

          phoneNumberCheckpoint();

        }

      });

    } else {

      phoneNumberCheckpoint();

    }

    return SafeArea(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringsResources.applicationName(),
            color: ColorsResources.primaryColor,
            theme: ThemeData(
              fontFamily: 'Ubuntu',
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
              backgroundColor: ColorsResources.dark,
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
                TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
              }),
            ),
            home: Scaffold(
                backgroundColor: ColorsResources.black,
                body: Stack(
                    children: [
                      // Gradient Background
                      Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(17),
                                  topRight: Radius.circular(17),
                                  bottomLeft: Radius.circular(17),
                                  bottomRight: Radius.circular(17)
                              ),
                              color: ColorsResources.black,
                              image: DecorationImage(
                                  image: AssetImage("entry_background.jpg"),
                                  fit: BoxFit.cover
                              )
                          )
                      ),
                      phoneNumberAuthentication
                    ]
                )
            )
        )
    );
  }

  void phoneNumberCheckpoint() async {

    if (firebaseAuthentication.currentUser!.phoneNumber == null) {

      phoneNumberAuthentication = Positioned(
        top: displayHeight(context) / 2,
        left: 13,
        right: 13,
        child: ColoredBox(
          color: Colors.redAccent,
          child: Text(
            "TEST",
            style: TextStyle(
                fontSize: 31
            ),
          ),
        ),
      );

      setState(() {

        phoneNumberAuthentication;

      });

    } else {

      // Navigate To Dashboard

    }

  }

}