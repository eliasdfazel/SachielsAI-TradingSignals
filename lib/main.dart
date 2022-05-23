import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:status_bar_control/status_bar_control.dart';

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await StatusBarControl.setColor(ColorsResources.black, animated: true);
  await StatusBarControl.setNavigationBarColor(ColorsResources.black, animated: true);

  runApp(
      Phoenix(
          child: const MaterialApp(home: EntryConfigurations())
      )
  );

}

class EntryConfigurations extends StatefulWidget {
  const EntryConfigurations({Key? key}) : super(key: key);

  @override
  State<EntryConfigurations> createState() => _EntryConfigurationsState();
}

class _EntryConfigurationsState extends State<EntryConfigurations> {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: StringsResources.applicationName(),
          color: ColorsResources.primaryColor,
          theme: ThemeData(
            fontFamily: 'Sans',
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: ColorsResources.primaryColor),
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            }),
          ),
          home: Stack(
            children: [
              // Gradient Background
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(17),
                      topRight: Radius.circular(17),
                      bottomLeft: Radius.circular(17),
                      bottomRight: Radius.circular(17)),
                  gradient: LinearGradient(
                      colors: [
                        ColorsResources.light,
                        ColorsResources.lightestBlue,
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      transform: GradientRotation(45),
                      tileMode: TileMode.clamp),
                ),
              ),
              // Rounded Borders
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17)),
                    border: Border(
                        top: BorderSide(
                          color: Colors.black,
                          width: 7,
                        ),
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 7,
                        ),
                        left: BorderSide(
                          color: Colors.black,
                          width: 7,
                        ),
                        right: BorderSide(
                          color: Colors.black,
                          width: 7,
                        )
                    ),
                    color: Colors.transparent
                ),
                child: ,
              ),
            ],
          ),
        ));
  }
}
