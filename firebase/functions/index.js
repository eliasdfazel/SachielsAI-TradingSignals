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

      const tradeCommand = documentData.tradeCommand;

//var message = {
//
//        android: {
//            ttl: (3600 * 1000) * (1), // 1 Hour in Milliseconds
//
//            priority: 'high',
//        },
//
//        data: {
//            "selfDisplayName": selfDisplayName,
//            "selfUid": selfUid,
//            "publicCommunityAction": publicCommunityAction,
//            "nameOfCountry": nameOfCountry,
//            "vicinityLatitude": vicinityLatitude,
//            "vicinityLongitude": vicinityLongitude,
//            "publicCommunityName": publicCommunityName,
//            "notificationLargeIcon": notificationLargeIcon,
//            "messageContent": messageContent,
//            "imageMessage": '' + imageMessage
//        },
//
//        topic: notificationTopic
//    };
//
//    return admin.messaging().send(message).then((response) => {
//        console.log('Successfully Sent ::: ', response);
//    }).catch((error) => {
//        console.log('Error Sending Message ::: ', error);
//    });

});