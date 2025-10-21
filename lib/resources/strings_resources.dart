/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 12/12/22, 7:26 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

class StringsResources {

  static String applicationName() {

    return "Sachiel's Signals";
  }

  static String applicationSummary() {

    return "Trading Signals With Up to 99% Accuracy from Advanced AI & Teams Of 6 Figures Traders.";
  }

  static String applicationLink() {

    return "https://play.google.com/store/apps/details?id=co.geeksempire.sachiel.signals";
  }

  static String twitterLink() {

    return "https://twitter.com/SachielsAI";
  }

  static String facebookLink() {

    return "https://facebook.com/SachielsAI";
  }

  static String instagramLink() {

    return "https://instagram.com/SachielsAI";
  }

  static String sachielsAI() {

    return "Sachiels AI";
  }

  static String shareSachiel() {

    return "Share Sachiel's Signal";
  }

  static String termService() {

    return "Terms Of Services. Agree By Login In...";
  }

  static String noInternetConnection() {

    return "No Internet Connection...";
  }

  static String warningEmptyText() {

    return "You Didn't Entered Text | Error Occurred";
  }

  static String agree() {

    return "Agree";
  }

  static String read() {

    return "Read";
  }

  static String ok() {

    return "Ok";
  }

  static String errorNoSignalText(String marketType) {

    return "No Trading Signals For $marketType";
  }

  static String subscriptionExpired() {

    return "Subscription Expired. Purchase Now Or Contact Support@GeeksEmpire.co";
  }

  static String accuracyText() {

    return "Accuracy";
  }

  static String lotSizeText() {

    return "Lot Size";
  }

  static String earningsText() {

    return "Earnings";
  }

  static String takeProfitText() {

    return "Take Profit";
  }

  static String stopLossText() {

    return "Stop Loss";
  }

  static String entryPriceText() {

    return "Entry Price";
  }

  static String profileTitle() {

    return "Profile";
  }

  static String historyTitle() {

    return "Histories";
  }

  static String storeTitle() {

    return "Store";
  }

  static String detailsTitle() {

    return "Details";
  }

  static String academyInformation() {

    return "Information";
  }

  static String academyTitle() {

    return "Academy";
  }

  static String academyTutorialsTitle() {

    return "Tutorials";
  }

  static String academyArticlesTitle() {

    return "Articles";
  }

  static String academyNewsTitle() {

    return "News";
  }

  static String brokersTitle() {

    return "Brokers";
  }

  static String onlineCoursesTitle() {

    return "Online Courses";
  }

  static String confirm() {

    return "Confirm";
  }

  static String analyseNow() {

    return 'Analyse Now';
  }

  /*
   * Start - Authentications
   */
  static String phoneNumber() {

    return "Phone Number";
  }

  static String phoneNumberHint() {

    return "+1 666 975 3333";
  }

  static String enterCode() {

    return "Enter Code";
  }

  static String enterCodeHint() {

    return "951370";
  }

  static String signOutNotice() {

    return "Sign Out & Uninstall Sachiel";
  }
  /*
   * End - Authentications
   */

  static String sliderOneContent() {

    return "<p>The Biggest Risk Is<br/>Not To Take <b>Any Risks</b>.<br/><br/><br/> Money Grows On The Tree Of <b>Persistence</b>.</p>";
  }

  static String sliderTwoContent() {

    return "<p>The Only Thing You Can Buy For Free Is... <br/> <b>Misery</b>. <br/><br/> <b>Make More Money To Change Your Life</b>.</p>";
  }

  static String sliderThreeContent() {

    return "<p>Wealth Is Your Dreams. <br/><br/>🟡 Modern Life <br/>🟡 Modern Work <br/>🟡 Modern Hopes</p>";
  }

  static String marketChartLink(String marketPair) {

    return "https://www.tradingview.com/chart/?aff_id=136528&symbol=${marketPair}";
  }

  static String fileSliderTime = "SliderTime";
  static String filePurchasingPlan = "PurchasingPlan";
  static String filePurchasingTime = "PurchasingTime";

  static List<String> marketsTypes() {

    List<String> allMarketsTypes = [];
    allMarketsTypes.add("ForeignExchange");
    allMarketsTypes.add("Cryptocurrency");
    allMarketsTypes.add("Stock Markets");
    allMarketsTypes.add("Indices");
    allMarketsTypes.add("Bonds");
    allMarketsTypes.add("Energy");
    allMarketsTypes.add("Metal");

    return allMarketsTypes;
  }

  static List<String> marketPairs() {

    List<String> allMarketPairs = [];
    allMarketPairs.add("EURUSD");
    allMarketPairs.add("USDJPY");
    allMarketPairs.add("GBPJPY");

    allMarketPairs.add("BTCUSD");
    allMarketPairs.add("XRPUSD");

    allMarketPairs.add("XAUUSD");

    return allMarketPairs;
  }

}