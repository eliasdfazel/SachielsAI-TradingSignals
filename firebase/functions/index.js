const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp({
    credential: admin.credential.applicationDefault(),
});

const firestore = admin.firestore();

const XMLHttpRequest = require("xhr2").XMLHttpRequest;

const runtimeOptions = {
    timeoutSeconds: 512,
}

exports.platinumTier = functions.https.onCall(async (data, context) => {

    var documentSnapshot = await firestore.document('Sachiels/Signals/Platinum/' + data.tradeTimestamp).get();

    const documentData = documentSnapshot.data();

    var signalData = {

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

    return admin.messaging().send(signalData).then((response) => {
        console.log('Successfully Sent ::: ', response);

    }).catch((error) => {
        console.log('Error Sending ::: ', error);

    });

});

exports.goldTier = functions.https.onCall(async (data, context) => {

    var documentSnapshot = await firestore.document('Sachiels/Signals/Gold/' + data.tradeTimestamp).get();

    const documentData = documentSnapshot.data();

    var signalData = {

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

    return admin.messaging().send(signalData).then((response) => {
        console.log('Successfully Sent ::: ', response);

    }).catch((error) => {
        console.log('Error Sending ::: ', error);

    });

});

exports.palladiumTier = functions.https.onCall(async (data, context) => {

    var documentSnapshot = await firestore.document('Sachiels/Signals/Palladium/' + data.tradeTimestamp).get();

    const documentData = documentSnapshot.data();

    var signalData = {

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

    return admin.messaging().send(signalData).then((response) => {
        console.log('Successfully Sent ::: ', response);

    }).catch((error) => {
        console.log('Error Sending ::: ', error);

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
        console.log(err.toString());
    }


    /* Articles - News - Tutorials */
    var postType = "4562";

    if (productCategories.includes("4562")) {

        postType = "Articles";

    } else if (productCategories.includes("1857")) {

        postType = "News";

    } else if (productCategories.includes("4563")) {

        postType = "Tutorials";

    }

    console.log(jsonObject[categoriesKey][0].toString());
    console.log(postId + " Added To " + postType + " | " + productCategory);

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
        console.log("Successfully Added.");

    }).catch(error => {
        console.log("Error: " + error);
    });
    /* End - Document * With Even Directory */

}