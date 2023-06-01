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

exports.statusAI = functions.runWith(runtimeOptions).https.onCall(async (data, context) => {
    functions.logger.log("AI Status Message :::", data.statusMessage);

    const statusCondition = '\'Platinum\' in topics || \'Gold\' in topics || \'Palladium\' in topics';

    var dataStatusAI = {
    
        notification: {
            title: "Sachiels Signals | AI Status 🤖",
            body: data.statusMessage
        },
        
        android: {
            ttl: (3600 * 1000) * (1), // 1 Hour in Milliseconds
            priority: 'high',
        },

        data: {
            "statusMessage": data.statusMessage,
        },

        condition: statusCondition
        
    };

    admin.messaging().send(dataStatusAI).then((response) => {
        functions.logger.log("Successfully Sent ::: ", response);

    }).catch((error) => {
        functions.logger.log("Error Sending ::: ", error);

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