import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

// const db = admin.firestore();
const fcm = admin.messaging();
export const notifyuser = functions.firestore.document('Employees/{uid}').onWrite(async snapshot => {
    if(snapshot.after.get('covid')['testResult'] == true){
        const tokens: string | any[] = [];
        snapshot.after.get('contactHistory').forEach((data: { [x: string]: any; }) => {
           tokens.push(data['fcm']);
       });
       const payload :admin.messaging.MessagingPayload = {
           notification: {
               title: 'Covid Positive!',
               body: 'Your recent contact was just diagnosed with Covid Positive',
               icon: 'https://firebasestorage.googleapis.com/v0/b/kkm-beacon.appspot.com/o/logo.png?alt=media&token=4ae91f94-fd6d-466a-8b30-f31cf970dcdf',
               clickAction:'FLUTTER_NOTIFICATION_CLICK',
           }
       }
    return fcm.sendToDevice(tokens,payload);
    }
   else{
       return null;
   }
});
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
