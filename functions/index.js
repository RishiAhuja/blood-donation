const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();
const database = admin.firestore();

exports.sendNotification = functions.pubsub.schedule('* * * * *').onRun(async (context) => {
    const query = await database.collection("notifications")
        .where("sent", "==", false).get();

    query.forEach(async snapshot => {
    console.log(snapshot.data());
    const payload = {
        notification: {
            title: 'Blood Required!',
            body: "" + snapshot.data().blood + " Blood required for " + snapshot.data().name + "",
            priority: "high",
        },

//        android: {
//                   priority: "high",
//                   notification: {
//                      'channel_id': 'blood',
//                   },
//                 },
        data: {
            click_action: 'FLUTTER_NOTIFICATION_CLICK'
        },
//        to: "/topics/ngo"
    };
        await admin.messaging().sendToTopic('ngo', payload).then((response) => {
            console.log('Successfully sent message:', response);
            admin.firestore().collection('notifications').doc(snapshot.data().id).update({"sent": true,})
            return {success: true};
        }).then(() => {
                    response.end();
                }).catch(error => {
                              return console.log("Error updating database");
                          });

    });

    return console.log('End Of Function');
});

exports.donatePending = functions.pubsub.schedule('* * * * *').onRun(async (context) => {
    const query = await database.collection("pending_donation_request_notification")
        .where("sent", "==", false).get();

    query.forEach(async snapshot => {
    console.log(snapshot.data());
    const payload = {
        notification: {
            title: '' + snapshot.data().name + " wants to donate blood",
            body: "" + snapshot.data().name + " can donate " + snapshot.data().blood + " blood",
            priority: "high",
        },
        data: {
            click_action: 'FLUTTER_NOTIFICATION_CLICK'
        },
//        to: "/topics/ngo"
    };
        await admin.messaging().sendToTopic('ngo', payload).then((response) => {
            console.log('Successfully sent message:', response);
            admin.firestore().collection('pending_donation_request_notification').doc(snapshot.data().id).update({"sent": true,})
            return {success: true};
        }).then(() => {
                    response.end();
                }).catch(error => {
                              return console.log("Error updating database");
                          });

    });

    return console.log('End Of Function');
});