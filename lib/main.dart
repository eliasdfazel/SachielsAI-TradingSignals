import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:sachiel/dashboard/ui/interface.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:status_bar_control/status_bar_control.dart';

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await StatusBarControl.setColor(ColorsResources.primaryColorDarkest, animated: true);
  await StatusBarControl.setNavigationBarColor(ColorsResources.primaryColorDarkest, animated: true);

  runApp(
      Phoenix(
          child: const MaterialApp(
              home: EntryConfigurations()
          )
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

    Future.delayed(const Duration(milliseconds: 1357), () {

      FlutterNativeSplash.remove();

    });

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
                  ),
                ),
                OutlinedButton(
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardInterface()),
                    );

                  },
                  child: Text(
                    "Enter Modern Monetary"
                  ),
                )
              ],
            )
          )
        )
    );
  }

}
