/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 12/12/22, 4:54 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marquee/marquee.dart';
import 'package:sachiel/academy/data/articles_data_structure.dart';
import 'package:sachiel/academy/utils/measurements.dart';
import 'package:sachiel/dashboard/ui/sections/purchase_plan_picker.dart';
import 'package:sachiel/in_application_browser/ui/sachiel_academy_browser.dart';
import 'package:sachiel/resources/colors_resources.dart';
import 'package:sachiel/resources/strings_resources.dart';
import 'package:sachiel/utils/data/numbers.dart';
import 'package:sachiel/utils/navigations/navigation_commands.dart';
import 'package:sachiel/utils/ui/display.dart';
import 'package:sachiel/utils/ui/system_bars.dart';
import 'package:sachiel/utils/widgets/gradient_text/gradient.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_mask/widget_mask.dart';

class AcademyArchivesInterface extends StatefulWidget {

  const AcademyArchivesInterface({Key? key}) : super(key: key);

  @override
  State<AcademyArchivesInterface> createState() => _AcademyArchivesInterfaceState();

}
class _AcademyArchivesInterfaceState extends State<AcademyArchivesInterface> {

  ScrollController scrollController = ScrollController();

  Widget tutorialsAcademy = Container(
    alignment: Alignment.center,
    child: LoadingAnimationWidget.staggeredDotsWave(
      colorOne: ColorsResources.premiumLight,
      colorTwo: ColorsResources.primaryColor,
      size: 73,
    ),
  );

  Widget articlesAcademy = Container();

  Widget newsAcademy = Container();

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    navigatePop(context);

    return true;
  }

  @override
  void dispose() {

    BackButtonInterceptor.remove(aInterceptor);

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(aInterceptor);

    changeColor(ColorsResources.black, ColorsResources.black);

    retrieveAcademyTutorials();

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringsResources.applicationName(),
        color: ColorsResources.primaryColor,
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
          }),
        ),
        home: Scaffold(
            backgroundColor: ColorsResources.black,
            body: Stack(
              children: [

                /* Start - Gradient Background - Dark */
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17)
                    ),
                    border: Border(
                        top: BorderSide(
                          color: ColorsResources.black,
                          width: 7,
                        ),
                        bottom: BorderSide(
                          color: ColorsResources.black,
                          width: 7,
                        ),
                        left: BorderSide(
                          color: ColorsResources.black,
                          width: 7,
                        ),
                        right: BorderSide(
                          color: ColorsResources.black,
                          width: 7,
                        )
                    ),
                    gradient: LinearGradient(
                        colors: [
                          ColorsResources.premiumDark,
                          ColorsResources.black,
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        transform: GradientRotation(-45),
                        tileMode: TileMode.clamp
                    ),
                  ),
                ),
                /* End - Gradient Background - Dark */

                /* Start - Branding Transparent */
                Align(
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: 0.1,
                    child: Transform.scale(
                      scale: 1.7,
                      child: const Image(
                        image: AssetImage("assets/logo.png"),
                      )
                    )
                  ),
                ),
                /* End - Branding Transparent */

                /* Start - Gradient Background - Golden */
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(17),
                              topRight: Radius.circular(17),
                              bottomLeft: Radius.circular(17),
                              bottomRight: Radius.circular(17)
                          ),
                          gradient: RadialGradient(
                            radius: 1.1,
                            colors: <Color> [
                              ColorsResources.primaryColorLighter.withOpacity(0.51),
                              Colors.transparent,
                            ],
                            center: const Alignment(0.79, -0.87),
                          )
                      ),
                      child: SizedBox(
                        height: calculatePercentage(99, displayHeight()),
                        width: calculatePercentage(99, displayWidth()),
                      ),
                    )
                ),
                /* End - Gradient Background - Golden */

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                  child: ListView(
                      padding: const EdgeInsets.fromLTRB(0, 103, 0, 37),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: [

                        tutorialsAcademy,

                        const Divider(
                          height: 51,
                          color: Colors.transparent,
                        ),

                        articlesAcademy,

                        const Divider(
                          height: 51,
                          color: Colors.transparent,
                        ),

                        newsAcademy

                      ]
                  )
                ),

                /* Start - Back */
                Row(
                  children: [

                    /* Start - Back */
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(19, 19, 0, 0),
                            child: SizedBox(
                                height: 59,
                                width: 59,
                                child: InkWell(
                                  onTap: () {

                                    navigatePop(context);

                                  },
                                  child: const Image(
                                    image: AssetImage("assets/back_icon.png"),
                                  ),
                                )
                            )
                        )
                    ),
                    /* End - Back */

                    /* Start - Title */
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(19, 19, 0, 0),
                            child: SizedBox(
                                height: 59,
                                width: 155,
                                child: Stack(
                                  children: [
                                    WidgetMask(
                                      blendMode: BlendMode.srcATop,
                                      childSaveLayer: true,
                                      mask /* Original Image */: Container(
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  ColorsResources.premiumDark,
                                                  ColorsResources.black,
                                                ],
                                                transform: GradientRotation(45)
                                            )
                                        ),
                                      ),
                                      child: const Image(
                                        image: AssetImage("assets/rectircle_shape.png"),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                            padding: const EdgeInsets.all(1.9),
                                            child: WidgetMask(
                                                blendMode: BlendMode.srcATop,
                                                childSaveLayer: true,
                                                mask /* Original Image */: Container(
                                                  decoration: const BoxDecoration(
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            ColorsResources.black,
                                                            ColorsResources.premiumDark,
                                                          ],
                                                          transform: GradientRotation(45)
                                                      )
                                                  ),
                                                ),
                                                child: const Image(
                                                  image: AssetImage("assets/rectircle_shape.png"),
                                                )
                                            )
                                        )
                                    ),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                            child: Text(
                                                StringsResources.academyTitle(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: ColorsResources.premiumLight,
                                                    fontSize: 19
                                                )
                                            )
                                        )
                                    )
                                  ],
                                )
                            )
                        )
                    ),
                    /* End - Title */

                  ],
                ),
                /* End - Back */

                /* Start - Purchase Plan Picker */
                const Positioned(
                    right: 19,
                    top: 19,
                    child: PurchasePlanPicker()
                ),
                /* End - Purchase Plan Picker */

                /* Start - Reserve Appointment for Online Course*/
                Positioned(
                  bottom: 37,
                  left: 19,
                  right: 19,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                          onTap: () {

                            launchUrl(Uri.parse("https://GeeksEmpire.co/Sachiels/OnlineCourses"));

                          },
                          child: SizedBox(
                              height: 59,
                              width: 155,
                              child: Stack(
                                children: [
                                  WidgetMask(
                                    blendMode: BlendMode.srcATop,
                                    childSaveLayer: true,
                                    mask /* Original Image */: Container(
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                ColorsResources.premiumDark,
                                                ColorsResources.black,
                                              ],
                                              transform: GradientRotation(45)
                                          )
                                      ),
                                    ),
                                    child: const Image(
                                      image: AssetImage("assets/rectircle_shape.png"),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                          padding: const EdgeInsets.all(1.9),
                                          child: WidgetMask(
                                              blendMode: BlendMode.srcATop,
                                              childSaveLayer: true,
                                              mask /* Original Image */: Container(
                                                decoration: const BoxDecoration(
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          ColorsResources.black,
                                                          ColorsResources.premiumDark,
                                                        ],
                                                        transform: GradientRotation(45)
                                                    )
                                                ),
                                              ),
                                              child: const Image(
                                                image: AssetImage("assets/rectircle_shape.png"),
                                              )
                                          )
                                      )
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                          child: Marquee(
                                              text: StringsResources.onlineCoursesTitle(),
                                              accelerationDuration: const Duration(seconds: 3),
                                              startAfter: const Duration(milliseconds: 777),
                                              pauseAfterRound: const Duration(milliseconds: 777),
                                              accelerationCurve: Curves.easeInOutCirc,
                                              numberOfRounds: 7,
                                              blankSpace: 37,
                                              fadingEdgeStartFraction: 0.19,
                                              fadingEdgeEndFraction: 0.19,
                                              style: const TextStyle(
                                                  color: ColorsResources.premiumLight,
                                                  fontSize: 19
                                              )
                                          )
                                      )
                                  )
                                ],
                              )
                          )
                      )
                  ),
                )
                /* End - Reserve Appointment for Online Course*/

              ],
            )
        )
    );
  }

  /* Start - Tutorials */
  void retrieveAcademyTutorials() {
    debugPrint("Retrieve Latest Signals Details");

    /* Start - Academy Tutorials */
    FirebaseFirestore.instance
        .collection("/Sachiels/Academy/Tutorials")
        .limit(13)
        .orderBy("articleTimestamp")
        .get().then((QuerySnapshot querySnapshot) {

      List<ArticlesDataStructure> articlesDataStructure = [];

      for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

        articlesDataStructure.add(ArticlesDataStructure(queryDocumentSnapshot, ArticlesDataStructure.tutorialPostType));

      }

      if (articlesDataStructure.isNotEmpty) {

        prepareAcademyTutorials(articlesDataStructure);

      }

      retrieveAcademyArticles();

    },
        onError: (e) => {

        });
    /* End - Academy Tutorials */

  }

  void prepareAcademyTutorials(List<ArticlesDataStructure> articlesDataStructure) {

    List<Widget> aAcademyArticle = <Widget>[];

    for (var articlesDataStructureItem in articlesDataStructure) {

      aAcademyArticle.add(academyTutorialsItem(articlesDataStructureItem));

    }

    setState(() {

      tutorialsAcademy = Column(
          children: [

            Padding(
                padding: const EdgeInsets.fromLTRB(19, 0, 0, 17),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringsResources.academyTutorialsTitle(),
                      style: TextStyle(
                          fontSize: 37,
                          letterSpacing: 1.7,
                          color: ColorsResources.premiumLight,
                          shadows: [
                            Shadow(
                                color: ColorsResources.black.withOpacity(0.13),
                                blurRadius: 13,
                                offset: const Offset(0, 7)
                            )
                          ]
                      ),
                    )
                )
            ),

            Padding(
                padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                child: SizedBox(
                    height: 303,
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                      physics: const PageScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: scrollController,
                      children: aAcademyArticle,
                    )
                )
            ),

          ]
      );

    });

  }

  Widget academyTutorialsItem(ArticlesDataStructure articlesDataStructure) {
    debugPrint("Academy Article: ${articlesDataStructure.articleTitle()}");

    return InkWell(
        onTap: () {

          navigateTo(context, SachielAcademyBrowser(articlesDataStructure: articlesDataStructure));

        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 19, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Blur(
              blur: 7,
              blurColor: ColorsResources.dark,
              colorOpacity: 0.1,
              overlay: Container(
                  height: 301,
                  width: 337,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.7,
                      color: ColorsResources.dark.withOpacity(0.73),
                    ),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17)
                    ),
                  ),
                  child: Stack(
                      children: [

                        /* Start - Article Cover */
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              height: 199,
                              width: 313,
                              padding: const EdgeInsets.fromLTRB(0, 19, 0, 0),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(17),
                                  topRight: Radius.circular(17),
                                  bottomRight: Radius.circular(11),
                                  bottomLeft: Radius.circular(11),
                                ),
                                child: Image.network(
                                  articlesDataStructure.articleCover(),
                                  alignment: Alignment.center,
                                  fit: BoxFit.cover,
                                ),
                              )
                          )
                        ),
                        /* End - Article Cover */

                        /* Start - Article Text */
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 19),
                            child: Container(
                                height: 119,
                                width: 279,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(17),
                                    topRight: Radius.circular(17),
                                    bottomRight: Radius.circular(17),
                                    bottomLeft: Radius.circular(17),
                                  ),
                                  color: ColorsResources.dark.withOpacity(0.91),
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorsResources.premiumDark.withOpacity(0.37),
                                        blurRadius: 13,
                                        offset: const Offset(0, 3)
                                    )
                                  ]
                                ),
                                padding: const EdgeInsets.fromLTRB(19, 13, 19, 13),
                                child: GradientText(
                                  articlesDataStructure.articleTitle(),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.fade,
                                  maxLinesNumber: 3,
                                  style: TextStyle(
                                      fontSize: 19,
                                      decoration: TextDecoration.none,
                                      shadows: [
                                        Shadow(
                                            color: ColorsResources.black.withOpacity(0.57),
                                            blurRadius: 7,
                                            offset: const Offset(0.0, 3.0)
                                        )
                                      ]
                                  ),
                                  colors: const <Color> [
                                    ColorsResources.premiumLight,
                                    ColorsResources.white,
                                  ],
                                )
                            )
                          )
                        )
                        /* End - Article Text */

                      ]
                  )
              ),
              child: const SizedBox(
                height: 301,
                width: 337,
              ),
            ),
          )
        )
    );
  }
  /* End - Tutorials */

  /* Start - Articles */
  void retrieveAcademyArticles() {
    debugPrint("Retrieve Latest Signals Details");

    /* Start - Academy Articles */
    FirebaseFirestore.instance
        .collection("/Sachiels/Academy/Articles")
        .limit(7)
        .orderBy("articleTimestamp")
        .get().then((QuerySnapshot querySnapshot) {

          List<ArticlesDataStructure> articlesDataStructure = [];

          for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

            articlesDataStructure.add(ArticlesDataStructure(queryDocumentSnapshot, ArticlesDataStructure.articlePostType));

          }

          if (articlesDataStructure.isNotEmpty) {

            prepareAcademyArticles(articlesDataStructure);

          }

          retrieveAcademyNews();

        },
        onError: (e) => {

        });
    /* End - Academy Articles */

  }

  void prepareAcademyArticles(List<ArticlesDataStructure> articlesDataStructure) {

    List<Widget> aAcademyArticle = <Widget>[];

    for (var articlesDataStructureItem in articlesDataStructure) {

      aAcademyArticle.add(academyArticlesItem(articlesDataStructureItem));

    }

    int gridColumnCount = (displayLogicalWidth(context) / 199).round();

    setState(() {

      articlesAcademy = Column(
          children: [

            Padding(
                padding: const EdgeInsets.fromLTRB(19, 0, 0, 17),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringsResources.academyArticlesTitle(),
                      style: TextStyle(
                          fontSize: 37,
                          letterSpacing: 1.7,
                          color: ColorsResources.premiumLight,
                          shadows: [
                            Shadow(
                                color: ColorsResources.black.withOpacity(0.13),
                                blurRadius: 13,
                                offset: const Offset(0, 7)
                            )
                          ]
                      ),
                    )
                )
            ),

            Padding(
                padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                child: SizedBox(
                  height: gridHeight(303, aAcademyArticle.length, gridColumnCount),
                  width: double.infinity,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridColumnCount,
                      childAspectRatio: 0.61,
                      mainAxisSpacing: 37.0,
                      crossAxisSpacing: 19.0,
                    ),
                    padding: const EdgeInsets.fromLTRB(19, 0, 19, 13),
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    controller: scrollController,
                    children: aAcademyArticle,
                  )
                )
            ),

          ]
      );

    });

  }

  Widget academyArticlesItem(ArticlesDataStructure articlesDataStructure) {
    debugPrint("Academy Article: ${articlesDataStructure.articleTitle()}");

    return InkWell(
        onTap: () {

          navigateTo(context, SachielAcademyBrowser(articlesDataStructure: articlesDataStructure));

        },
        child: Container(
          width: 199,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: ColorsResources.primaryColorLightest.withOpacity(0.09),
                    blurRadius: 11,
                    offset: const Offset(0, 3)
                )
              ]
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17)
                    ),
                    gradient: LinearGradient(
                      colors: [
                        ColorsResources.dark.withOpacity(0.73),
                        ColorsResources.premiumDark,
                      ],
                      transform: const GradientRotation(-45),
                    ),
                  ),
                  child: Stack(
                      children: [

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            /* Start - Article Cover */
                            SizedBox(
                                height: 117,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(17),
                                    topRight: Radius.circular(17),
                                    bottomRight: Radius.circular(11),
                                    bottomLeft: Radius.circular(11),
                                  ),
                                  child: Image.network(
                                    articlesDataStructure.articleCover(),
                                    alignment: Alignment.center,
                                    fit: BoxFit.cover,
                                  ),
                                )
                            ),
                            /* End - Article Cover */

                            /* Start - Article Text */
                            SizedBox(
                                height: 67,
                                child: Container(
                                  color: Colors.transparent,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(13, 11, 13, 0),
                                      child: GradientText(
                                        articlesDataStructure.articleTitle(),
                                        textAlign: TextAlign.start,
                                        maxLinesNumber: 3,
                                        style: TextStyle(
                                            fontSize: 15,
                                            decoration: TextDecoration.none,
                                            shadows: [
                                              Shadow(
                                                  color: ColorsResources.black.withOpacity(0.57),
                                                  blurRadius: 7,
                                                  offset: const Offset(0.0, 3.0)
                                              )
                                            ]
                                        ),
                                        colors: const <Color> [
                                          ColorsResources.premiumLight,
                                          ColorsResources.white,
                                        ],
                                      )
                                  )
                                )
                            ),
                            /* End - Article Text */

                            /* Start - Summary Text */
                            SizedBox(
                                height: 87,
                                child: Container(
                                    color: Colors.transparent,
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(3, 0, 3, 3),
                                        child: Html(
                                            data: articlesDataStructure.articleSummary(),
                                            style: {
                                              '#': Style(
                                                  padding: HtmlPaddings(left: HtmlPadding(1), top: HtmlPadding(0), right: HtmlPadding(1), bottom: HtmlPadding(0)),
                                                  color: ColorsResources.premiumLightTransparent,
                                                  maxLines: 5,
                                                  fontSize: FontSize(11),
                                                  wordSpacing: 1.3
                                              )
                                            }
                                        )
                                    )
                                )
                            )
                            /* End - Summary Text */

                          ],
                        ),

                        const Positioned(
                          left: 0,
                          top: 0,
                          child: SizedBox(
                            height: 21,
                            width: 79,
                            child: Blur(
                                blur: 3,
                                blurColor: ColorsResources.premiumDark,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(17),
                                  topRight: Radius.circular(7),
                                  bottomRight: Radius.circular(17),
                                  bottomLeft: Radius.circular(7),
                                ),
                                colorOpacity: 0.07,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 21,
                                  width: 73,
                                )
                            ),
                          ),
                        ),
                        Positioned(
                            left: 0,
                            top: 0,
                            child: SizedBox(
                                height: 21,
                                width: 79,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      articlesDataStructure.articleCategory().split(" ").last,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: ColorsResources.premiumLight
                                      ),
                                    )
                                )
                            )
                        )

                      ]
                  )
              )
          ),
        )
    );
  }
  /* End - Articles */

  /* Start - News */
  void retrieveAcademyNews() {
    debugPrint("Retrieve Latest Signals Details");

    /* Start - Academy News */
    FirebaseFirestore.instance
        .collection("/Sachiels/Academy/News")
        .limit(13)
        .orderBy("articleTimestamp")
        .get().then((QuerySnapshot querySnapshot) {

      List<ArticlesDataStructure> articlesDataStructure = [];

      for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

        articlesDataStructure.add(ArticlesDataStructure(queryDocumentSnapshot, ArticlesDataStructure.newsPostType));

      }

      if (articlesDataStructure.isNotEmpty) {

        prepareAcademyNews(articlesDataStructure);

      }

    },
        onError: (e) => {

        });
    /* End - Academy News */

  }

  void prepareAcademyNews(List<ArticlesDataStructure> articlesDataStructure) {

    List<Widget> aAcademyArticle = <Widget>[];

    for (var articlesDataStructureItem in articlesDataStructure) {

      aAcademyArticle.add(academyNewsItem(articlesDataStructureItem));

    }

    int gridColumnCount = (displayLogicalWidth(context) / 199).round();

    setState(() {

      newsAcademy = Column(
          children: [

            Padding(
                padding: const EdgeInsets.fromLTRB(19, 0, 0, 17),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringsResources.academyNewsTitle(),
                      style: TextStyle(
                          fontSize: 37,
                          letterSpacing: 1.7,
                          color: ColorsResources.premiumLight,
                          shadows: [
                            Shadow(
                                color: ColorsResources.black.withOpacity(0.13),
                                blurRadius: 13,
                                offset: const Offset(0, 7)
                            )
                          ]
                      ),
                    )
                )
            ),

            Padding(
                padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                child: SizedBox(
                    height: gridHeight(291, aAcademyArticle.length, gridColumnCount),
                    width: double.infinity,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridColumnCount,
                        childAspectRatio: 0.73,
                        mainAxisSpacing: 37.0,
                        crossAxisSpacing: 19.0,
                      ),
                      padding: const EdgeInsets.fromLTRB(19, 0, 19, 13),
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      controller: scrollController,
                      children: aAcademyArticle,
                    )
                )
            ),

          ]
      );

    });

  }

  Widget academyNewsItem(ArticlesDataStructure articlesDataStructure) {
    debugPrint("Academy Article: ${articlesDataStructure.articleTitle()}");

    return InkWell(
        onTap: () {

          navigateTo(context, SachielAcademyBrowser(articlesDataStructure: articlesDataStructure));

        },
        child: Container(
          width: 199,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: ColorsResources.primaryColorLightest.withOpacity(0.09),
                    blurRadius: 11,
                    offset: const Offset(0, 3)
                )
              ]
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17)
                    ),
                    gradient: LinearGradient(
                      colors: [
                        ColorsResources.dark.withOpacity(0.73),
                        ColorsResources.premiumDark,
                      ],
                      transform: const GradientRotation(-45),
                    ),
                  ),
                  child: Stack(
                      children: [

                        /* Start - Article Cover */
                        SizedBox(
                          height: 251,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(17),
                              topRight: Radius.circular(17),
                              bottomRight: Radius.circular(17),
                              bottomLeft: Radius.circular(17),
                            ),
                            child: Image.network(
                              articlesDataStructure.articleCover(),
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                            ),
                          )
                        ),
                        /* End - Article Cover */

                        /* Start - Article Text */
                        Positioned(
                          bottom: 7,
                          left: 7,
                          right: 7,
                          child: Blur(
                            blur: 3,
                            blurColor: ColorsResources.premiumDark,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(17),
                                topRight: Radius.circular(17),
                                bottomRight: Radius.circular(17),
                                bottomLeft: Radius.circular(17),
                              ),
                            colorOpacity: 0.07,
                            alignment: Alignment.center,
                            overlay: Container(
                                color: Colors.transparent,
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(13, 7, 13, 7),
                                    child: Text(
                                      articlesDataStructure.articleTitle(),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.fade,
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: ColorsResources.light,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none,
                                          shadows: [
                                            Shadow(
                                                color: ColorsResources.black.withOpacity(0.37),
                                                blurRadius: 7,
                                                offset: const Offset(0.0, 3.0)
                                            )
                                          ]
                                      ),
                                    )
                                )
                            ),
                            child: const SizedBox(
                              height: 79,
                              width: double.infinity,
                            )
                          )
                        ),
                        /* End - Article Text */

                        /* Start - Article Category */
                        Positioned(
                          left: 7,
                          top: 7,
                          child: SizedBox(
                            height: 21,
                            width: 73,
                            child: Blur(
                                blur: 3,
                                blurColor: ColorsResources.premiumDark,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(17),
                                  topRight: Radius.circular(17),
                                  bottomRight: Radius.circular(17),
                                  bottomLeft: Radius.circular(17),
                                ),
                                colorOpacity: 0.07,
                                alignment: Alignment.center,
                                overlay: SizedBox(
                                    height: 21,
                                    width: 73,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          articlesDataStructure.articleCategory(),
                                          style: const TextStyle(
                                            color: ColorsResources.light,
                                            fontSize: 13,
                                          ),
                                        )
                                    )
                                ),
                                child: const SizedBox(
                                  height: 21,
                                  width: 73,
                                )
                            ),
                          ),
                        ),
                        /* End - Article Category */

                      ]
                  )
              )
          ),
        )
    );
  }
  /* End - News */

}