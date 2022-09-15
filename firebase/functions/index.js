const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp({
    credential: admin.credential.applicationDefault(),
});

const firestore = admin.firestore();

const xmlHttpRequest = require("xmlhttprequest").XMLHttpRequest;

const runtimeOptions = {
    timeoutSeconds: 512,
}

exports.platinumListener = functions.firestore
    .document('Sachiels/Signals/Platinum/{tradeTimestamp}')
    .onCreate((documentSnapshot, context) => {

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

exports.goldListener = functions.firestore
    .document('Sachiels/Signals/Platinum/{tradeTimestamp}')
    .onCreate((documentSnapshot, context) => {

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

exports.palladiumListener = functions.firestore
    .document('Sachiels/Signals/Platinum/{tradeTimestamp}')
    .onCreate((documentSnapshot, context) => {

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