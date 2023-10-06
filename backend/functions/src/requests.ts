import { admin, firestore, functions } from './global';
import { getAuth, signInWithEmailAndPassword } from "firebase/auth";

export const deleteAccount = functions.https.onRequest(async (req, res) => {
    if (!req.body['email'] || req.body['password']) {
        res.status(400).send({
            'error': 'Invalid credentials'
        });
        return;
    }

    try {
        const result = await signInWithEmailAndPassword(getAuth(), req.body['email'], req.body['password']);
        const userID = result.user.uid;

        // Delete analyzed waste
        const userWasteQuery = firestore.collection('analyzedWaste').where('userID', '==', userID);
        userWasteQuery.get().then(function (wasteSnapshot) {
            wasteSnapshot.forEach(function (doc) {
                doc.ref.delete();
            });
        });

        // Delete user content from Storage
        await admin.storage().bucket().deleteFiles({
            prefix: `users/${userID}/`
        });

        await admin.storage().bucket().deleteFiles({
            prefix: `items/${userID}/`
        });

        // Delete user from Auth
        await result.user.delete();

    } catch (e) {
        res.status(400).send({
            'error': e
        });
    }
});