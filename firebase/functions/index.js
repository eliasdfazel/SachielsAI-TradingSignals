const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp({
    credential: admin.credential.applicationDefault(),
    databaseURL: "https://sachiel-s-signals-default-rtdb.firebaseio.com"
});

const firestore = admin.firestore();
const database = admin.database();

const XMLHttpRequest = require("xhr2").XMLHttpRequest;

const runtimeOptions = {
    timeoutSeconds: 512,
}

firestore.settings({ ignoreUndefinedProperties: true })

/* 
 * START - Scheduled Status Functions 
 */
// Schedule At 23:30 Everyday https://crontab.guru/ - (Minute) (Hours) (Day Of Month) (Month) (Day Of Week)
exports.sachielAnalysisStatus = functions.runWith(runtimeOptions).pubsub.schedule('30 23 * * *').timeZone('America/New_York').onRun((context) => {
    console.log('Time; ' + Date.now());

    /* Start - ETHUSD */
    cryptocurrenciesMarketData('ETHUSD');
    /* End - ETHUSD */

    /* Start - EURUSD */
    forexMarketData('EURUSD');
    /* End - EURUSD */

    return null;
});

async function cryptocurrenciesMarketData(marketPairInput) {

    var marketPair = marketPairInput;

    //https://api.polygon.io/v1/indicators/rsi/X:ETHUSD?timespan=day&adjusted=true&window=13&series_type=close&order=desc&limit=1&apiKey=BW99q7QQNIgDVfkyHi1H7SrTSKHZeY9_
    var cryptocurrencyRsiEndpoint = 'https://api.polygon.io/v1/indicators/rsi/'
        + 'X:' + marketPair
        + '?timespan=day&window=13&series_type=close'
        + '&order=desc&limit=1'
        + '&apiKey=BW99q7QQNIgDVfkyHi1H7SrTSKHZeY9_';
    console.log('Cryptocurrency Endpoint; ' + cryptocurrencyRsiEndpoint);

    var xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.open('GET', cryptocurrencyRsiEndpoint, true);
    xmlHttpRequest.setRequestHeader('accept', 'application/json');
    xmlHttpRequest.setRequestHeader('Content-Type', 'application/json');
    xmlHttpRequest.onreadystatechange = function () {
        if (this.readyState == 4) {

        } else {

        }
    };
    xmlHttpRequest.onprogress = function () {

    };
    xmlHttpRequest.onload = function () {
        console.log('JSON Response ::: ' + xmlHttpRequest.responseText);

        var jsonObjectRSI = JSON.parse(xmlHttpRequest.responseText);

        var rsiValue = jsonObjectRSI.results.values[0].value;
        var timestampValue = jsonObjectRSI.results.values[0].timestamp;

        analysisOfRsi(rsiValue, marketPair);

    };
    xmlHttpRequest.send();

}

async function forexMarketData(marketPairInput) {

    var marketPair = marketPairInput;

    //https://api.polygon.io/v1/indicators/rsi/C:EURUSD?timespan=day&adjusted=true&window=13&series_type=close&order=desc&limit=1&apiKey=BW99q7QQNIgDVfkyHi1H7SrTSKHZeY9_
    var forexRsiEndpoint = 'https://api.polygon.io/v1/indicators/rsi/'
        + 'C:' + marketPair
        + '?timespan=day&adjusted=true&window=13&series_type=close'
        + '&order=desc&limit=1'
        + '&apiKey=BW99q7QQNIgDVfkyHi1H7SrTSKHZeY9_';
    console.log('Forex Endpoint; ' + forexRsiEndpoint);

    var xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.open('GET', forexRsiEndpoint, true);
    xmlHttpRequest.setRequestHeader('accept', 'application/json');
    xmlHttpRequest.setRequestHeader('Content-Type', 'application/json');
    xmlHttpRequest.onreadystatechange = function () {
        if (this.readyState == 4) {

        } else {

        }
    };
    xmlHttpRequest.onprogress = function () {

    };
    xmlHttpRequest.onload = function () {
        console.log('JSON Response ::: ' + xmlHttpRequest.responseText);

        var jsonObjectRSI = JSON.parse(xmlHttpRequest.responseText);

        var rsiValue = jsonObjectRSI.results.values[0].value;
        var timestampValue = jsonObjectRSI.results.values[0].timestamp;

        analysisOfRsi(rsiValue, marketPair);

    };
    xmlHttpRequest.send();

}

async function analysisOfRsi(rsiNumber, marketPair) {

    var statusCondition = '\'Platinum\' in topics || \'Gold\' in topics || \'Palladium\' in topics';

    var statusMessage = 'Observing ' + marketPair;

    if (parseInt(rsiNumber) >= 73) {
        console.log("SELL");
       
        statusMessage = 'Sachiel AI is Analysing ' + marketPair + ' to SELL.';

        statusCheckpoint(marketPair, statusMessage, statusCondition);

    } else if (parseInt(rsiNumber) <= 27) {
        console.log("BUY");

        statusMessage = 'Sachiel AI is Analysing ' + marketPair + ' to BUY.';
        
        statusCheckpoint(marketPair, statusMessage, statusCondition);

    } else {
        console.log("Observing");

        statusMessage = 'Observing ' + marketPair + '...' + 'RSI: ' + parseInt(rsiNumber);

        statusCondition = '\'Privileged\' in topics';

        sendNotification(statusMessage, "", statusCondition);

    }

}

async function statusCheckpoint(marketPair, aiStatusMessage, statusCondition) {

    firestore.doc('/Sachiels/AI/Status/' + marketPair).get().then((documentSnapshot) => {

        if (documentSnapshot.exists) {
            console.log("Status Exists");

            const documentData = documentSnapshot.data();

            var lastStatusUpdate = parseInt(documentData.statusTimestamp);

            var nowMillisecond = Date.now();

            var sevenDaysMillisecond = 86400000 * 7;

            if ((nowMillisecond - lastStatusUpdate) > sevenDaysMillisecond) {
                console.log("Status Updating");

                const aiStatus = {
                    statusMessage: aiStatusMessage,
                    statusMarket: marketPair,
                    statusAuth0or: "Sachiels AI",
                    statusTimestamp: nowMillisecond
                };

                firestore.doc('/Sachiels/AI/Status/' + marketPair).set(aiStatus);

                sendNotification(aiStatusMessage, "", statusCondition);

            } else {
                console.log("Status Recently Sent");
            }

        } else {
            console.log("New Status Sending...");

            const aiStatus = {
                statusMessage: aiStatusMessage,
                statusMarket: marketPair,
                statusAuthor: "Sachiels AI",
                statusTimestamp: nowMillisecond
            };

            firestore.doc('/Sachiels/AI/Status/' + marketPair).set(aiStatus);

            sendNotification(aiStatusMessage, "", statusCondition);

        }

    });

}

/* 
 * START - Manual Status From Sachiels Administrators
 */
exports.statusAI = functions.runWith(runtimeOptions).https.onCall(async (data, context) => {
    functions.logger.log("AI Status Message :::", data.statusMessage);

    const statusCondition = '\'Platinum\' in topics || \'Gold\' in topics || \'Palladium\' in topics';

    sendNotification(data.statusMessage, "", statusCondition);

});
/* 
 * END - Manual Status From Sachiels Administrators
 */
/* 
 * END - Scheduled Status Functions 
 */

/* 
 *START - Scheduled Candlestick Indentifier 
 */
// Schedule At 23:30 Everyday https://crontab.guru/ - (Minute) (Hours) (Day Of Month) (Month) (Day Of Week)
exports.dailyMarketIdentifier = functions.runWith(runtimeOptions).pubsub.schedule('13 01 * * *').timeZone('America/New_York').onRun((context) => {

    /* 
     * Start - Forex 
     */
    /* Start - EURUSD */
    forexDailyMarketIdentifier('EURUSD', 'Daily');
    /* End - EURUSD */

    /* Start - GBPJPY */
    forexDailyMarketIdentifier('GBPJPY', 'Daily');
    /* End - GBPJPY */
    /* 
     * End - Forex 
     */

    /* 
     * Start - Cryptocurrency 
     */
    /* Start - ETHUSD */
    cryptocurrenciesDailyMarketIdentifier('ETHUSD', 'Daily');
    /* End - ETHUSD */
    /* 
     * End - Cryptocurrency 
     */

});

async function forexDailyMarketIdentifier(marketPairInput, timeframe) {

    var marketPair = marketPairInput;

    // Yesterday 
    let dateObject = new Date(Date.now() - 86400000);

    var dateMonth = dateObject.getUTCMonth() + 1; // Months 1-12

    if (dateMonth.toString().length == 1) {

        dateMonth = '0' + dateMonth;

    }

    var dateDay = dateObject.getUTCDate();

    if (dateDay.toString().length == 1) {

        dateDay = '0' + dateDay;

    }

    let dateYear = dateObject.getUTCFullYear();

    // YYYY-MM-DD
    var dateTimespan = dateYear + '-' + dateMonth + '-' + dateDay;
    console.log('Date: ' + dateTimespan);

    //https://api.polygon.io/v2/aggs/ticker/C:EURUSD/range/1/day/2023-09-14/2023-09-14?adjusted=true&sort=asc&limit=1&apiKey=BW99q7QQNIgDVfkyHi1H7SrTSKHZeY9_
    var marketEndpoint = 'https://api.polygon.io/v2/aggs/ticker/'
        + 'C:' + marketPair
        + '/range/1/day/'
        + dateTimespan + '/' + dateTimespan
        + '?adjusted=true&sort=asc&limit=1&apiKey=BW99q7QQNIgDVfkyHi1H7SrTSKHZeY9_';
    console.log('Market Identifier Endpoint; ' + marketEndpoint);

    var xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.open('GET', marketEndpoint, true);
    xmlHttpRequest.setRequestHeader('accept', 'application/json');
    xmlHttpRequest.setRequestHeader('Content-Type', 'application/json');
    xmlHttpRequest.onreadystatechange = function () {
        if (this.readyState == 4) {

        } else {

        }
    };
    xmlHttpRequest.onprogress = function () {

    };
    xmlHttpRequest.onload = function () {
        console.log('JSON Response ::: ' + xmlHttpRequest.responseText);

        var jsonObjectPrices = JSON.parse(xmlHttpRequest.responseText);
        
        let openPrice = jsonObjectPrices.results[0].o;
        let closePrice = jsonObjectPrices.results[0].c;

        let highestPrice = jsonObjectPrices.results[0].h;
        let lowestPrice = jsonObjectPrices.results[0].l;
        console.log('Open: ' + openPrice + ' - Close: ' + closePrice + ' - Highest: ' + highestPrice + ' - Lowest: ' + lowestPrice);

        analyseDojiPattern(marketPair, timeframe, openPrice, closePrice, highestPrice, lowestPrice);

        analyseArrowUp(marketPair, timeframe, openPrice, closePrice, highestPrice, lowestPrice);

        analyseArrowDown(marketPair, timeframe, openPrice, closePrice, highestPrice, lowestPrice);

        analyseNarrowArrow(marketPair, timeframe, openPrice, closePrice, highestPrice, lowestPrice);

    };
    xmlHttpRequest.send();

}

async function cryptocurrenciesDailyMarketIdentifier(marketPairInput, timeframe) {

    var marketPair = marketPairInput;

    // Yesterday 
    let dateObject = new Date(Date.now() - 86400000);

    var dateMonth = dateObject.getUTCMonth() + 1; // Months 1-12

    if (dateMonth.toString().length == 1) {

        dateMonth = '0' + dateMonth;

    }

    var dateDay = dateObject.getUTCDate();

    if (dateDay.toString().length == 1) {

        dateDay = '0' + dateDay;

    }

    let dateYear = dateObject.getUTCFullYear();

    // YYYY-MM-DD
    var dateTimespan = dateYear + '-' + dateMonth + '-' + dateDay;
    console.log('Date: ' + dateTimespan);

    //https://api.polygon.io/v2/aggs/ticker/X:ETHUSD/range/1/day/2023-09-14/2023-09-14?adjusted=true&sort=asc&limit=1&apiKey=BW99q7QQNIgDVfkyHi1H7SrTSKHZeY9_
    var marketEndpoint = 'https://api.polygon.io/v2/aggs/ticker/'
        + 'X' + marketPair
        + '/range/1/day/'
        + dateTimespan + '/' + dateTimespan
        + '?adjusted=true&sort=asc&limit=1&apiKey=BW99q7QQNIgDVfkyHi1H7SrTSKHZeY9_';
    console.log('Market Identifier Endpoint; ' + marketEndpoint);

    var xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.open('GET', marketEndpoint, true);
    xmlHttpRequest.setRequestHeader('accept', 'application/json');
    xmlHttpRequest.setRequestHeader('Content-Type', 'application/json');
    xmlHttpRequest.onreadystatechange = function () {
        if (this.readyState == 4) {

        } else {

        }
    };
    xmlHttpRequest.onprogress = function () {

    };
    xmlHttpRequest.onload = function () {
        console.log('JSON Response ::: ' + xmlHttpRequest.responseText);

        var jsonObjectPrices = JSON.parse(xmlHttpRequest.responseText);
        
        let openPrice = jsonObjectPrices.results[0].o;
        let closePrice = jsonObjectPrices.results[0].c;

        let highestPrice = jsonObjectPrices.results[0].h;
        let lowestPrice = jsonObjectPrices.results[0].l;
        console.log('Open: ' + openPrice + ' - Close: ' + closePrice + ' - Highest: ' + highestPrice + ' - Lowest: ' + lowestPrice);

        analyseDojiPattern(marketPair, timeframe, openPrice, closePrice, highestPrice, lowestPrice);

        analyseArrowUp(marketPair, timeframe, openPrice, closePrice, highestPrice, lowestPrice);

        analyseArrowDown(marketPair, timeframe, openPrice, closePrice, highestPrice, lowestPrice);

        analyseNarrowArrow(marketPair, timeframe, openPrice, closePrice, highestPrice, lowestPrice);

    };
    xmlHttpRequest.send();

}

// DOJI
async function analyseDojiPattern(marketPair, timeframe, openPrice, closePrice, highestPrice, lowestPrice) {

    let closePercentage = linearInterpolation(lowestPrice, highestPrice, closePrice);
    let openPercentage = linearInterpolation(lowestPrice, highestPrice, openPrice);

    if (closePercentage <= 55 
        && openPercentage >= 45) { // GREEN

            // Doji
            // To Identify Strength Of Doji, Check Differencial Of xPercentage. Smaller Means Stronger Doji.
            let deltaPercentage = closePercentage - openPercentage; // Smaller Value Means Stronger Doji

            let candlestickName = "DOJI Green"; 
            let candlestickMessage = "DOJI (BULLISH) Candlestick Generated 🟢\n" 
                + "Market: " + marketPair + "\n"
                + "Timeframe: " + timeframe;
            let candlestickImage = "https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FCandlesticks%2FPatterns%2FDoji%20Green.png?alt=media";

            candlestickTopic(candlestickMessage, candlestickImage, candlestickName, timeframe, marketPair);

            storeHistory("DOJI", candlestickImage, "BULLISH", marketPair, timeframe);

    } else if (openPercentage <= 55 
        && closePercentage >= 45) { // RED

            // Doji
            // To Identify Strength Of Doji, Check Differencial Of xPercentage. Smaller Means Stronger Doji.
            let deltaPercentage = closePercentage - openPercentage; // Smaller Value Means Stronger Doji

            let candlestickName = "DOJI Red"; 
            let candlestickMessage = "DOJI (BEARISH) Candlestick Generated 🔴\n" 
                + "Market: " + marketPair + "\n"
                + "Timeframe: " + timeframe;
            let candlestickImage = "https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FCandlesticks%2FPatterns%2FDoji%20Red.png?alt=media";

            candlestickTopic(candlestickMessage, candlestickImage, candlestickName, timeframe, marketPair);

            storeHistory("DOJI", candlestickImage, "BEARISH", marketPair, timeframe);

    } else { // EQUAL



    }

}

// HAMMER - HANGING
async function analyseArrowUp(marketPair, timeframe, openPrice, closePrice, highestPrice, lowestPrice) {

    let closePercentage = linearInterpolation(lowestPrice, highestPrice, closePrice);
    let openPercentage = linearInterpolation(lowestPrice, highestPrice, openPrice);

    if ((openPercentage >= 70 && openPercentage <= 80)
        && (closePercentage >= 85 && closePercentage <= 100)) { // GREEN - HAMMER

            let candlestickName = "HAMMER"; 
            let candlestickMessage = "HAMMER (BULLISH) Candlestick Generated 🟢\n" 
                + "Market: " + marketPair + "\n"
                + "Timeframe: " + timeframe;
            let candlestickImage = "https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FCandlesticks%2FPatterns%2FHammer.png?alt=media";

            candlestickTopic(candlestickMessage, candlestickImage, candlestickName, timeframe, marketPair);

            storeHistory("HAMMER", candlestickImage, "BULLISH", marketPair, timeframe);

    } else if ((closePercentage >= 70 && closePercentage <= 80)
    && (openPercentage >= 85 && openPercentage <= 100)) { // RED - HANGING MAN

        let candlestickName = "HANGING MAN"; 
        let candlestickMessage = "HANGING MAN (BEARISH) Candlestick Generated 🔴\n" 
            + "Market: " + marketPair + "\n"
            + "Timeframe: " + timeframe;
        let candlestickImage = "https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FCandlesticks%2FPatterns%2FHanging.png?alt=media";

        candlestickTopic(candlestickMessage, candlestickImage, candlestickName, timeframe, marketPair);

        storeHistory("HANGING MAN", candlestickImage, "BEARISH", marketPair, timeframe);

    } else { // EQUAL



    }

}

// HAMMER INVERTED - SHOOTING STAR
async function analyseArrowDown(marketPair, timeframe, openPrice, closePrice, highestPrice, lowestPrice) {

    let closePercentage = linearInterpolation(lowestPrice, highestPrice, closePrice);
    let openPercentage = linearInterpolation(lowestPrice, highestPrice, openPrice);

    if ((openPercentage <= 30 && openPercentage >= 20)
        && (closePercentage <= 15 && closePercentage >= 0)) { // RED - SHOOTING STAR

            let candlestickName = "SHOOTING STAR"; 
            let candlestickMessage = "SHOOTING STAR (BEARISH) Candlestick Generated 🔴\n" 
                + "Market: " + marketPair + "\n"
                + "Timeframe: " + timeframe;
            let candlestickImage = "https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FCandlesticks%2FPatterns%2FShooting%20Star.png?alt=media";

            candlestickTopic(candlestickMessage, candlestickImage, candlestickName, timeframe, marketPair);

            storeHistory("SHOOTING STAR", candlestickImage, "BEARISH", marketPair, timeframe);

    } else if ((closePercentage <= 30 && closePercentage >= 20)
    && (openPercentage <= 15 && openPercentage >= 0)) { // GREEN - HAMMER INVERTED

        let candlestickName = "HAMMER INVERTED"; 
        let candlestickMessage = "HAMMER INVERTED (BULLISH) Candlestick Generated 🟢\n" 
            + "Market: " + marketPair + "\n"
            + "Timeframe: " + timeframe;
        let candlestickImage = "https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FCandlesticks%2FPatterns%2FInverted%20Hammer.png?alt=media";

        candlestickTopic(candlestickMessage, candlestickImage, candlestickName, timeframe, marketPair);

        storeHistory("HAMMER INVERTED", candlestickImage, "BULLISH", marketPair, timeframe);

    } else { // EQUAL



    }

}

// DRAGONFLY - GRAVESTONE
async function analyseNarrowArrow(marketPair, timeframe, openPrice, closePrice, highestPrice, lowestPrice) {

    let closePercentage = linearInterpolation(lowestPrice, highestPrice, closePrice);
    let openPercentage = linearInterpolation(lowestPrice, highestPrice, openPrice);

    if (openPercentage >= 90
        && closePercentage >= 90) { // GREEN - DRAGONFLY

            let candlestickName = "DRAGONFLY"; 
            let candlestickMessage = "DRAGONFLY (BULLISH) Candlestick Generated 🟢\n" 
                + "Market: " + marketPair + "\n"
                + "Timeframe: " + timeframe;
            let candlestickImage = "https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FCandlesticks%2FPatterns%2FDragonfly.png?alt=media";
    
            candlestickTopic(candlestickMessage, candlestickImage, candlestickName, timeframe, marketPair);

            storeHistory("DRAGONFLY", candlestickImage, "BULLISH", marketPair, timeframe);

    } else if (openPercentage <= 10
        && closePercentage >= 0) { // RED - GRAVESTONE

            let candlestickName = "GRAVESTONE"; 
            let candlestickMessage = "GRAVESTONE (BEARISH) Candlestick Generated 🔴\n" 
                + "Market: " + marketPair + "\n"
                + "Timeframe: " + timeframe;
            let candlestickImage = "https://firebasestorage.googleapis.com/v0/b/sachiel-s-signals.appspot.com/o/Sachiels%2FCandlesticks%2FPatterns%2FGravestone.png?alt=media";
    
            candlestickTopic(candlestickMessage, candlestickImage, candlestickName, timeframe, marketPair);

            storeHistory("GRAVESTONE", candlestickImage, "BEARISH", marketPair, timeframe);

    } else { // EQUAL

        

    }

}

// Notification Topic Example DOJIGreen4HoursEURUSD
async function candlestickTopic(candlestickMessage, candlestickImage, candlestickName, timeframe, marketPair) {

    var candlestickTopic = candlestickName.replace(" ", "") + timeframe.replace(" ", "") + marketPair.replace(" ", "");

    var notificationMessage = candlestickMessage;

    var candlestickCondition = "\'" + candlestickTopic + "'\' in topics";

    sendNotification(notificationMessage, candlestickImage, candlestickCondition);

}

async function storeHistory(candlestickName, candlestickImage, marketDirection, marketPair, timeframe) {

    // Sachiels/Candlesticks/History/[Milliseconds]
    firestore.doc("Sachiels/Candlesticks/History/" + Date.now().toString()).set({
        timestamp: FieldValue.serverTimestamp(),
        candlestickName: candlestickName,
        candlestickImage: candlestickImage,
        marketDirection: marketDirection,
        marketPair: marketPair,
        timeframe: timeframe,
    });

}
/* 
 * END - Scheduled Candlestick Indentifier 
 */


exports.platinumTier = functions.runWith(runtimeOptions).https.onCall(async (data, context) => {
    functions.logger.log("Receiving Platinum Signal :::", data.tradeTimestamp);

    firestore.doc('/Sachiels/Signals/Platinum/' + data.tradeTimestamp).get().then((documentSnapshot) => {
        functions.logger.log("Platinum Signal Document Snapshot ::: ", documentSnapshot);

        const documentData = documentSnapshot.data();
        functions.logger.log("Platinum Signal Document ::: ", documentData);

        if (tradeMarketType.length == 0) {

            updateMarketType(purchasingTier, data.tradeTimestamp, documentData.tradeMarketPair);

        }

        var notificationColor = "🟢";

        if (documentData.tradeCommand == "Sell") {

            notificationColor = "🔴";

        }

        const signalData = {

            notification: {
                title: notificationColor + " " + documentData.tradeCommand + " ➡️ " + documentData.tradeMarketPair,
                body: "Estimated Profit: " + documentData.tradeProfitAmount + "\n" 
                    + "Trade Accuracy: " + documentData.tradeAccuracyPercentage
            },
    
            android: {
                ttl: (3600 * 1000) * (1), // 1 Hour in Milliseconds
                priority: 'high',
            },
    
            data: {
                "tradeCommand": documentData.tradeCommand,
                "tradeAccuracyPercentage": documentData.tradeAccuracyPercentage,
                "tradeEntryPrice": documentData.tradeEntryPrice,
                "tradeLotSize": documentData.tradeLotSize,
                "tradeMarketPair": documentData.tradeMarketPair,
                "tradeProfitAmount": documentData.tradeProfitAmount,
                "tradeStopLoss": documentData.tradeStopLoss,
                "tradeTakeProfit": documentData.tradeTakeProfit,
                "tradeTimeframe": documentData.tradeTimeframe,
                "tradeTimestamp": documentData.tradeTimestamp,
            },
    
            topic: "Platinum"
        };
    
        admin.messaging().send(signalData).then((response) => {
            functions.logger.log("Successfully Sent ::: ", response);
    
        }).catch((error) => {
            functions.logger.log("Error Sending ::: ", error);
    
        });

    });

});

exports.goldTier = functions.runWith(runtimeOptions).https.onCall(async (data, context) => {
    functions.logger.log("Receiving Gold Signal :::", data.tradeTimestamp);

    firestore.doc('/Sachiels/Signals/Gold/' + data.tradeTimestamp).get().then((documentSnapshot) => {
        functions.logger.log("Gold Signal Document Snapshot ::: ", documentSnapshot);

        const documentData = documentSnapshot.data();
        functions.logger.log("Gold Signal Document ::: ", documentData);

        if (tradeMarketType.length == 0) {

            updateMarketType(purchasingTier, data.tradeTimestamp, documentData.tradeMarketPair);

        }

        var notificationColor = "🟢";

        if (documentData.tradeCommand == "Sell") {

            notificationColor = "🔴";

        }

        var signalData = {
    
            notification: {
                title: notificationColor + " " + documentData.tradeCommand + " ➡️ " + documentData.tradeMarketPair,
                body: "Estimated Profit: " + documentData.tradeProfitAmount + "\n" 
                    + "Trade Accuracy: " + documentData.tradeAccuracyPercentage
            },

            android: {
                ttl: (3600 * 1000) * (1), // 1 Hour in Milliseconds
                priority: 'high',
            },
    
            data: {
                "tradeCommand": documentData.tradeCommand,
                "tradeAccuracyPercentage": documentData.tradeAccuracyPercentage,
                "tradeEntryPrice": documentData.tradeEntryPrice,
                "tradeLotSize": documentData.tradeLotSize,
                "tradeMarketPair": documentData.tradeMarketPair,
                "tradeProfitAmount": documentData.tradeProfitAmount,
                "tradeStopLoss": documentData.tradeStopLoss,
                "tradeTakeProfit": documentData.tradeTakeProfit,
                "tradeTimeframe": documentData.tradeTimeframe,
                "tradeTimestamp": documentData.tradeTimestamp,
            },
    
            topic: "Gold"
        };
    
        admin.messaging().send(signalData).then((response) => {
            functions.logger.log("Successfully Sent ::: ", response);
    
        }).catch((error) => {
            functions.logger.log("Error Sending ::: ", error);
    
        });

    });

});

exports.palladiumTier = functions.runWith(runtimeOptions).https.onCall(async (data, context) => {
    functions.logger.log("Receiving Palladium Signal :::", data.tradeTimestamp);

    firestore.doc("/Sachiels/Signals/Palladium/" + data.tradeTimestamp).get().then((documentSnapshot) => {
        functions.logger.log("Palladium Signal Document Snapshot ::: ", documentSnapshot);

        const documentData = documentSnapshot.data();
        functions.logger.log("Palladium Signal Document ::: ", documentData);
    
        if (tradeMarketType.length == 0) {

            updateMarketType(purchasingTier, data.tradeTimestamp, documentData.tradeMarketPair);

        }

        var notificationColor = "🟢";
        
        if (documentData.tradeCommand == "Sell") {

            notificationColor = "🔴";

        }

        var signalData = {
    
            notification: {
                title: notificationColor + " " + documentData.tradeCommand + " ➡️ " + documentData.tradeMarketPair,
                body: "Estimated Profit: " + documentData.tradeProfitAmount + "\n" 
                    + "Trade Accuracy: " + documentData.tradeAccuracyPercentage
            },
            
            android: {
                ttl: (3600 * 1000) * (1), // 1 Hour in Milliseconds
                priority: 'high',
            },
    
            data: {
                "tradeCommand": documentData.tradeCommand,
                "tradeAccuracyPercentage": documentData.tradeAccuracyPercentage,
                "tradeEntryPrice": documentData.tradeEntryPrice,
                "tradeLotSize": documentData.tradeLotSize,
                "tradeMarketPair": documentData.tradeMarketPair,
                "tradeProfitAmount": documentData.tradeProfitAmount,
                "tradeStopLoss": documentData.tradeStopLoss,
                "tradeTakeProfit": documentData.tradeTakeProfit,
                "tradeTimeframe": documentData.tradeTimeframe,
                "tradeTimestamp": documentData.tradeTimestamp,
            },
    
            topic: "Palladium"
        };
    
        admin.messaging().send(signalData).then((response) => {
            functions.logger.log("Successfully Sent ::: ", response);
    
        }).catch((error) => {
            functions.logger.log("Error Sending ::: ", error);
    
        });

    });

});

exports.transferAcademyContents = functions.runWith(runtimeOptions).https.onRequest(async (req, res) => {

    var numberOfPage = req.query.numberOfPage;

    if (numberOfPage == null) {
        numberOfPage = 1;
    }

    var applicationsEndpoint = 'https://geeksempire.co/wp-json/wp/v2/posts?'
        + '&page=' + numberOfPage
        + '&per_page=99'
        + '&categories=4445'
        + '&orderby=date'
        + '&order=asc';

    var xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.open('GET', applicationsEndpoint, true);
    xmlHttpRequest.setRequestHeader('accept', 'application/json');
    xmlHttpRequest.setRequestHeader('Content-Type', 'application/json');
    xmlHttpRequest.onreadystatechange = function () {
        if (this.readyState == 4) {

        } else {

        }
    };
    xmlHttpRequest.onprogress = function () {

    };
    xmlHttpRequest.onload = function () {

        var jsonArrayParserResponse = JSON.parse(xmlHttpRequest.responseText);

        jsonArrayParserResponse.forEach((jsonObject) => {

            setPostsData(jsonObject);

        });

    };
    xmlHttpRequest.send();

});

async function setPostsData(jsonObject) {

    const categoriesMap = new Map();

    categoriesMap.set("4562", "Articles");
    categoriesMap.set("1857", "News");
    categoriesMap.set("4563", "Tutorials");

    categoriesMap.set("4445", "Financial");
    categoriesMap.set("4508", "Investment");
    categoriesMap.set("4444", "Make Money Online");
    categoriesMap.set("4393", "Trading");

    categoriesMap.set("2485", "Lifestyle");

    const idKey = "id";
    const linkKey = "link";

    const titleKey = "title";
    const excerptKey = "excerpt";

    const categoriesKey = "categories";
    const tagsKey = "tags";

    const imageKey = "jetpack_featured_media_url";

    var postId = jsonObject[idKey];
    var postLink = jsonObject[linkKey];

    var postTitle = jsonObject[titleKey]["rendered"];
    var postSummary = jsonObject[excerptKey]["rendered"];

    var postImage = jsonObject[imageKey];

    var productCategories = jsonObject[categoriesKey].toString();
    var productCategory = "Financial";
    try {
        productCategory = categoriesMap.get(jsonObject[categoriesKey][0].toString());
    } catch (err) {
        functions.logger.log(err.toString());
    }


    /* Articles - News - Tutorials */
    var postType = "Articles";

    if (productCategories.includes("4562")) {

        postType = "Articles";

    } else if (productCategories.includes("1857")) {

        postType = "News";

    } else if (productCategories.includes("4563")) {

        postType = "Tutorials";

    }

    functions.logger.log(jsonObject[categoriesKey][0].toString());
    functions.logger.log(postId + " Added To " + postType + " | " + productCategory);

    /* Start - Document * With Even Directory */
    var firestoreDirectory = '/' + 'Sachiels'
        + '/' + 'Academy'
        + '/' + postType
        + '/' + postId;

    await firestore.doc(firestoreDirectory).set({
        articleCategory: productCategory,
        articleCover: postImage,
        articleLink: postLink,
        articleSummary: postSummary,
        articleTimestamp: Date.now().toString(),
        articleTitle: postTitle,
    }).then(result => {
        functions.logger.log("Successfully Added.");

    }).catch(error => {
        functions.logger.log("Error: " + error);
    });
    /* End - Document * With Even Directory */

}

exports.experiment = functions.runWith(runtimeOptions).https.onRequest(async (req, res) => {
    functions.logger.log("Experiments 🧪");

    analysisOfRsi(73, "MNO");

});

async function updateMarketType(purchasingTier, tradeTimestamp, tradingPair) {

    const reference = database.ref("/SachielsSignals/Markets");

    reference.once("value", function(querySnapshot) {
        
        querySnapshot.forEach((childSnapshot) => {  
            functions.logger.log("🧪 " + childSnapshot.key);

            childSnapshot.forEach((itemSnapshot) => {

                if (itemSnapshot.key == tradingPair) {
                    console.log('Founded Item ::: ' + itemSnapshot.key);

                    firestore.doc("/Sachiels/Signals/" + purchasingTier + "/" + tradeTimestamp)
                        .update({tradeMarketType: childSnapshot.key}).then((documentSnapshot) => {
        
                            

                        });

                }
                
            });
            
        });

    }); 
      
}

/* Utilities */
function sendNotification(statusMessage, notificationImage, statusCondition) {

    if (notificationImage.toString().length === 0) {

        notificationImage = "https://pbs.twimg.com/profile_images/1530852621673811968/uCJBBRJy_400x400.jpg";

    }

    var dataStatusAI = {
        
        notification: {
            title: "Sachiels AI Status 🤖",
            body: statusMessage
        },
        
        android: {
            ttl: (3600 * 1000) * (1), // 1 Hour in Milliseconds
            priority: 'high',
            notification: {
                imageUrl: notificationImage
            }
        },

        apns: {
            fcm_options: {
              image: notificationImage
            }
        },
        

        data: {
            "statusMessage": statusMessage,
        },

        condition: statusCondition
        
    };

    admin.messaging().send(dataStatusAI).then((response) => {
        functions.logger.log("Successfully Sent ::: ", response);

    }).catch((error) => {
        functions.logger.log("Error Sending ::: ", error);

    });

}

function linearInterpolation(firstNumber, lastNumber, inputNumber) {

    var mappedNumber = 0 + (100 / (lastNumber - firstNumber)) * (inputNumber - firstNumber);

    return mappedNumber;
}
/* Utilities */