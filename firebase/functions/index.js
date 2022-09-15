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

});