// Node libraries
import * as querystring from 'querystring';

// Firebase
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

const app = admin.initializeApp();

const firestore = admin.firestore();
const fcm = admin.messaging();
firestore.settings({ ignoreUndefinedProperties: true });

export {
    querystring,
    functions,
    admin,
    firestore,
    fcm,
    app
};
