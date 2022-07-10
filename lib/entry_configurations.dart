
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/authentication/google_authentication.dart';
import 'package:sachiel/utils/ui/system_bars.dart';

class EntryConfigurations extends StatefulWidget {

  const EntryConfigurations({Key? key}) : super(key: key);

  @override
  State<EntryConfigurations> createState() => _EntryConfigurationsState();
}
class _EntryConfigurationsState extends State<EntryConfigurations> {

  GoogleAuthentication googleAuthentication = GoogleAuthentication();

  FirebaseAuth firebaseAuthentication = FirebaseAuth.instance;

  Widget contentView = Container(color: ColorsResources.primaryColor);

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.primaryColorDarkest, ColorsResources.primaryColorDarkest);

    firebaseAuthentication.currentUser?.reload();

    if (firebaseAuthentication.currentUser == null) {

      Future.delayed(const Duration(milliseconds: 1357), () async {

        googleAuthentication.startProcess();

      });

    } else {



    }

    setupWelcomeView();

  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(milliseconds: 1357), () {

      FlutterNativeSplash.remove();

    });

    return contentView;
  }

  void setupWelcomeView() {

    contentView = MaterialApp(
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
            backgroundColor: ColorsResources.primaryColorDarkest,
            body:Stack(
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
                          gradient: LinearGradient(
                              colors: [
                                ColorsResources.primaryColorDarkest,
                                ColorsResources.primaryColorDarkest,
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              transform: GradientRotation(45),
                              tileMode: TileMode.clamp
                          ),
                          image: DecorationImage(
                              image: AssetImage("entry_background.jpg"),
                              fit: BoxFit.cover
                          )
                      )
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 79,
                          child: ColoredBox(color: Colors.redAccent),
                        )
                      ]
                  )
                ]
            )
        )
    );

    setState(() {

      contentView;

    });

  }

}