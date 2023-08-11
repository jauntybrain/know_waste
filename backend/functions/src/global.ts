// Node libraries
import * as querystring from 'querystring';

// Firebase
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp({
    // serviceAccountId:
    //     'firebase-adminsdk-prpim@emaan-dev.iam.gserviceaccount.com',
});

const firestore = admin.firestore();
const fcm = admin.messaging();
firestore.settings({ ignoreUndefinedProperties: true });

// export const flavor = process.env.FLAVOR;

export {
    querystring,
    functions,
    admin,
    firestore,
    fcm,
};
