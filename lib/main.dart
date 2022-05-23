import 'package:flutter/material.dart';
import 'package:sachiel/dashboard/ui/interface.dart';
import 'package:sachiel/resources/strings_resources.dart';

void main() {



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: StringsResources.applicationName(),
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const DashboardInterface(),
    );
  }
}

