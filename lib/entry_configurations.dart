/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/11/22, 4:17 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/authentication/authentication_process.dart';
import 'package:sachiel/utils/ui/system_bars.dart';

class EntryConfigurations extends StatefulWidget {

  const EntryConfigurations({Key? key}) : super(key: key);

  @override
  State<EntryConfigurations> createState() => _EntryConfigurationsState();
}
class _EntryConfigurationsState extends State<EntryConfigurations> with AuthenticationsCallback {

  AuthenticationsProcess authenticationsProcess = AuthenticationsProcess();

  FirebaseAuth firebaseAuthentication = FirebaseAuth.instance;

  TextEditingController phoneNumberController = TextEditingController();

  Widget phoneNumberAuthentication = Container();

  String? warningNoticePhoneNumber;

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
      debugPrint("Google Not Authenticated");

      Future.delayed(const Duration(milliseconds: 1357), () async {
        debugPrint("Google Authenticated");

        UserCredential userCredential = await authenticationsProcess.startGoogleAuthentication();

        if (userCredential.user!.phoneNumber == null) {
          debugPrint("Phone Number Not Authenticated");

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
                resizeToAvoidBottomInset: false,
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
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 31, 0, 13),
                              child: Image(
                                image: AssetImage("logo.png"),
                                height: 339,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            phoneNumberAuthentication,
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 13, 0, 73),
                              child: InkWell(
                                onTap: () {

                                  if (phoneNumberController.text.isNotEmpty) {

                                    authenticationsProcess.startPhoneNumberAuthentication(phoneNumberController.text, this);

                                  } else {

                                    setState(() {

                                      warningNoticePhoneNumber = StringsResources.warningEmptyText();

                                    });

                                  }

                                },
                                child: const Image(
                                  image: AssetImage("entrance_next.png"),
                                  height: 239,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]
                )
            )
        )
    );
  }

  @override
  void authenticationWithPhoneCompleted() {

    Future.delayed(const Duration(milliseconds: 379), () {
      debugPrint("Authentication With Phone Number Completed");

      print(">>> >> > Finished");
      // navigateTo(context, const DashboardInterface());

    });

  }

  void phoneNumberCheckpoint() {

    if (firebaseAuthentication.currentUser!.phoneNumber == null) {
      debugPrint("Phone Number Not Authenticated");

      phoneNumberAuthentication = SizedBox(
          height: 113,
          width: 373,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 37,
                  width: 137,
                  child: Stack(
                      children: [
                        Blur(
                          blur: 5,
                          blurColor: ColorsResources.dark,
                          colorOpacity: 0.1,
                          borderRadius: BorderRadius.circular(9),
                          child: const SizedBox(
                            height: 37,
                            width: 137,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(9),
                                  topRight: Radius.circular(9),
                                  bottomLeft: Radius.circular(9),
                                  bottomRight: Radius.circular(9)
                              ),
                              border: Border.all(
                                color: ColorsResources.black,
                                width: 2,
                              ),
                              color: ColorsResources.dark.withOpacity(0.37)
                          ),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                StringsResources.phoneNumber(),
                                style: const TextStyle(
                                    color: ColorsResources.premiumLight,
                                    fontSize: 19
                                ),
                              )
                          ),
                        )
                      ]
                  )
              ),
              SizedBox(
                  height: 73,
                  width: 373,
                  child: Stack(
                      children: [
                        Blur(
                          blur: 7,
                          blurColor: ColorsResources.dark,
                          colorOpacity: 0.1,
                          borderRadius: BorderRadius.circular(17),
                          child: const SizedBox(
                            height: 72,
                            width: 373,
                          ),
                        ),
                        TextField(
                          controller: phoneNumberController,
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 1,
                          cursorColor: ColorsResources.primaryColor,
                          autofocus: false,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                              color: ColorsResources.light,
                              fontSize: 37.0,
                              shadows: [
                                Shadow(
                                    color: ColorsResources.primaryColorLighter.withOpacity(0.71),
                                    blurRadius: 17,
                                    offset: const Offset(0.0, 3.0)
                                )
                              ]
                          ),
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 3.0),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(17),
                                    topRight: Radius.circular(17),
                                    bottomLeft: Radius.circular(17),
                                    bottomRight: Radius.circular(17)
                                ),
                                gapPadding: 5
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 3.0),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(17),
                                    topRight: Radius.circular(17),
                                    bottomLeft: Radius.circular(17),
                                    bottomRight: Radius.circular(17)
                                ),
                                gapPadding: 5
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 3.0),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(17),
                                    topRight: Radius.circular(17),
                                    bottomLeft: Radius.circular(17),
                                    bottomRight: Radius.circular(17)
                                ),
                                gapPadding: 5
                            ),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 3.0),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(17),
                                    topRight: Radius.circular(17),
                                    bottomLeft: Radius.circular(17),
                                    bottomRight: Radius.circular(17)
                                ),
                                gapPadding: 5
                            ),
                            errorText: warningNoticePhoneNumber,
                            contentPadding: const EdgeInsets.fromLTRB(19, 21, 19, 21),
                            hintText: StringsResources.phoneNumberHint(),
                          ),
                          onSubmitted: (phoneNumber) {

                            if (phoneNumberController.text.isNotEmpty) {

                              authenticationsProcess.startPhoneNumberAuthentication(phoneNumberController.text, this);

                            } else {

                              setState(() {

                                warningNoticePhoneNumber = StringsResources.warningEmptyText();

                              });

                            }

                          },
                        )
                      ]
                  )
              )
            ],
          )
      );

      setState(() {

        phoneNumberAuthentication;

      });

    } else {
      debugPrint("Authentication With Phone Number Completed");

      // navigateTo(context, const DashboardInterface());

    }

  }

}