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

exports.requestApproved = functions.pubsub.schedule('* * * * *').onRun(async (context) => {
    const query = await database.collection("approved_request_notification")
        .where("sent", "==", false).get();

    query.forEach(async snapshot => {
    console.log(snapshot.data());
   const payload = {
       	token: snapshot.data().token,
           notification: {
               title: 'Hey ' + snapshot.data().patient + '! You will be provided blood soon',
               body: "Congratulations! " + snapshot.data().patient + "You are Approved by !" + snapshot.data().ngo,

           },
            android: {
                       priority: "high",
                       notification: {
                          'channel_id': 'blood',
                       },
                     },
           data: {
               click_action: 'FLUTTER_NOTIFICATION_CLICK'
           }
       };
        admin.messaging().send(payload).then((response) => {
                // Response is a message ID string.
                console.log('Successfully sent message:', response);
                admin.firestore().collection('approved_request_notification').doc(snapshot.data().id).update({"sent": true,})
                //changeDataConfirm(snapshot.data().token);
                return {success: true};
            }).then(() => {
                  response.end();
              }).catch(error => {
                            return console.log("Error Sending Message");
                        });

    });

    return console.log('End Of Function');
});

exports.donateApproved = functions.pubsub.schedule('* * * * *').onRun(async (context) => {
    const query = await database.collection("approved_donors_notifications")
        .where("sent", "==", false).get();

    query.forEach(async snapshot => {
    console.log(snapshot.data());
   const payload = {
       	token: snapshot.data().token,
           notification: {
               title: 'Hey ' + snapshot.data().name + '! You request is approved',
               body: "Congratulations! " + snapshot.data().patient + "You are Approved by !" + snapshot.data().ngo,

           },
            android: {
                       priority: "high",
                       notification: {
                          'channel_id': 'blood',
                       },
                     },
           data: {
               click_action: 'FLUTTER_NOTIFICATION_CLICK'
           }
       };
        admin.messaging().send(payload).then((response) => {
                // Response is a message ID string.
                console.log('Successfully sent message:', response);
                admin.firestore().collection('approved_donors_notifications').doc(snapshot.data().id).update({"sent": true,})
                //changeDataConfirm(snapshot.data().token);
                return {success: true};
            }).then(() => {
                  response.end();
              }).catch(error => {
                            return console.log("Error Sending Message");
                        });

    });

    return console.log('End Of Function');
});

exports.approvedNGO = functions.pubsub.schedule('* * * * *').onRun(async (context) => {
    const query = await database.collection("ngo_approved_notification")
        .where("sent", "==", false).get();

    query.forEach(async snapshot => {
    console.log(snapshot.data());
   const payload = {
       	token: snapshot.data().token,
           notification: {
               title: 'Hey ' + snapshot.data().ngo + '! You request is approved',
               body: "Congratulations! Now you can login to use your account..",

           },
            android: {
                       priority: "high",
                       notification: {
                          'channel_id': 'blood',
                       },
                     },
           data: {
               click_action: 'FLUTTER_NOTIFICATION_CLICK'
           }
       };
        admin.messaging().send(payload).then((response) => {
                // Response is a message ID string.
                console.log('Successfully sent message:', response);
                admin.firestore().collection('ngo_approved_notification').doc(snapshot.data().id).update({"sent": true,})
                //changeDataConfirm(snapshot.data().token);
                return {success: true};
            }).then(() => {
                  response.end();
              }).catch(error => {
                            return console.log("Error Sending Message");
                        });

    });

    return console.log('End Of Function');
});