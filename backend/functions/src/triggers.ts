import { Timestamp } from 'firebase-admin/firestore';
import { admin, firestore, functions } from './global';

import * as vision from '@google-cloud/vision';

export const processLabeledWaste = functions
    .region('us-central1')
    .firestore.document('labeledWaste/{wasteID}')
    .onCreate(async (snapshot) => {
        try {
            const wasteData = snapshot.data();

            if (!wasteData.labels || wasteData.labels.length == 0) {
                throw new functions.https.HttpsError(
                    'unavailable',
                    'Error occurred'
                );
            }

            // Get userID from the image path
            const userID = wasteData.file.split('gs://')[1].split('/')[2];

            // Process image labels
            const textLabels = wasteData.labels.map((label: any) => label.description);
            const labelsWithPreditions = wasteData.labels.map((label: any) => `${label.description}: ${label.score}`);

            // Call Vertex AI to detect objects in the image
            const client = new vision.ImageAnnotatorClient();
            var textObjects: any[] = [];
            var objectsWithPredictions: any[] = [];

            if (client.objectLocalization) {
                const [result] = await client.objectLocalization(wasteData.file);
                const objects = result.localizedObjectAnnotations!;

                textObjects = objects.map((object: any) => object.name);
                objectsWithPredictions = objects.map((object: any) => `${object.name}: ${object.score}`)
            }

            await firestore.collection('analyzedWaste').add({
                'labeledWasteID': snapshot.id,
                'imageUrl': wasteData.file,
                'userID': userID,
                'labels': textLabels,
                'objects': textObjects,
                'labelsString': labelsWithPreditions.join(', '),
                'objectsString': objectsWithPredictions.length == 0 ? 'Unknown object: 0.99' : objectsWithPredictions.join(', '),
                'date': Timestamp.now()
            });
        } catch (error) {
            throw new functions.https.HttpsError('internal', 'Error processing labeled waste');
        }
    });

export const processAnalyzedWaste = functions
    .region('us-central1')
    .firestore.document('analyzedWaste/{wasteID}')
    .onUpdate(async (snapshot) => {
        try {
            const analyzedWaste = snapshot.after.data();

            if (!analyzedWaste.advice) {
                throw new functions.https.HttpsError(
                    'unavailable',
                    'Error occurred'
                );
            }

            // Gather and filter AI-generated content by removing the tags
            const regexObjectName = new RegExp(/<object-name>(.*?)<\/object-name>/);
            const regexObjectMaterial = new RegExp(/<object-material>(.*?)<\/object-material>/);
            const regexTips = new RegExp(/<tips>(.*?)<\/tips>/s);
            const regexRecyclable = new RegExp(/<object-recyclable>(.*?)<\/object-recyclable>/s);

            const objectNameMatch = analyzedWaste.advice.match(regexObjectName);
            const objectName: string | undefined = objectNameMatch ? objectNameMatch[1] : null;

            const objectMaterialMatch = analyzedWaste.advice.match(regexObjectMaterial);
            const objectMaterial: string | undefined = objectMaterialMatch ? objectMaterialMatch[1] : null;

            const tipsMatch = analyzedWaste.advice.match(regexTips);
            const tips: string | undefined = tipsMatch ? tipsMatch[1] : null;

            const recyclableMatch = analyzedWaste.advice.match(regexRecyclable);
            const recyclable: string | undefined = recyclableMatch ? recyclableMatch[1] : null;

            // Return an error if either object name or material were not generated
            if (!objectName || !objectMaterial) {
                throw new functions.https.HttpsError(
                    'unavailable',
                    'Error occurred'
                );
            }

            const filteredAdvice = analyzedWaste.advice
                .replace(regexObjectName, '')
                .replace(regexObjectMaterial, '')
                .replace(regexTips, '')
                .replace(regexRecyclable, '');

            // Update analyzedWaste document
            await firestore.collection('analyzedWaste').doc(snapshot.after.id).update({
                'advice': filteredAdvice,
                'name': objectName,
                'material': objectMaterial,
                'tips': tips,
                'recyclable': recyclable?.toLowerCase() === 'true',
            });

            // Increment user stats values
            const increment = admin.firestore.FieldValue.increment(1);
            const typeIncrement = admin.firestore.FieldValue.increment(1);

            const materialTypes = ['plastic', 'glass', 'electronics', 'paper'];
            let type = 'other';

            const lowerCaseMaterial = objectMaterial.toLowerCase();

            for (const materialType of materialTypes) {
                if (lowerCaseMaterial.includes(materialType)) {
                    type = materialType;
                    break;
                }
            }

            const updateData = {
                total: increment,
                [type]: typeIncrement
            };

            await firestore.collection('userStats')
                .doc(analyzedWaste.userID)
                .set(updateData, { merge: true });

            // Update challenge progress
            const challenges = await firestore.collection('challenges')
                .where('material', '==', lowerCaseMaterial)
                .where('users', 'array-contains', analyzedWaste.userID).get();

            for (const challenge of challenges.docs) {
                firestore.doc(`challenges/${challenge.id}/stats/${analyzedWaste.userID}`).update({ progress: increment });
            }

        } catch (error) {
            console.error('Error:', error);
            throw new functions.https.HttpsError('internal', 'Error processing analyzed waste');
        }
    });

export const updateChallengeOnJoin = functions.firestore
    .document('challenges/{challengeID}/stats/{userID}')
    .onCreate(async (snapshot, context) => {
        const challengeID = context.params.challengeID;
        const userStatsSnapshot = snapshot.data();

        await firestore
            .collection('challenges')
            .doc(challengeID)
            .update({ users: admin.firestore.FieldValue.arrayUnion(userStatsSnapshot.id) })
    })

export const updateChallengeOnQuit = functions.firestore
    .document('challenges/{challengeID}/stats/{userID}')
    .onDelete(async (snapshot, context) => {
        const challengeID = context.params.challengeID;
        const userStatsSnapshot = snapshot.data();

        await firestore
            .collection('challenges')
            .doc(challengeID)
            .update({ users: admin.firestore.FieldValue.arrayRemove(userStatsSnapshot.id) })
    })

export const updateUsersPercentile = functions
    .region('us-central1')
    .firestore.document('userStats/{userID}')
    .onUpdate(async (snapshot) => {
        try {
            const newValue = snapshot.after.data();
            const previousValue = snapshot.before.data();

            if (newValue.total === previousValue.total) {
                return;
            }

            // Query the userStats collection to get all users
            const userStatsCollection = firestore.collection('userStats');

            const userStatsSnapshot = await userStatsCollection.get();
            const userStatsDocs = userStatsSnapshot.docs.map(doc => ({
                id: doc.id,
                total: doc.data().total,
            }));

            // Sort the userStats documents by total wealth
            const sortedUserStats = userStatsDocs.slice().sort((a, b) => b.total - a.total);
            const totalUsers = sortedUserStats.length;

            // Update the documents with calculated percentiles
            const batch = firestore.batch();

            sortedUserStats.forEach((userStat, index) => {
                const percentile = ((index + 1) / totalUsers) * 100;

                const userStatRef = userStatsCollection.doc(userStat.id);
                batch.update(userStatRef, { rank: percentile });
            });

            // Commit the batch update
            await batch.commit();
        } catch (error) {
            console.error('Error:', error);
            throw new functions.https.HttpsError('internal', 'Error updating percentiles');
        }
    });

export const onDeleteUser = functions.auth.user().onDelete(async (user) => {
    // Delete analyzed waste
    const userWasteQuery = firestore.collection('analyzedWaste').where('userID', '==', user.uid);
    userWasteQuery.get().then(function (wasteSnapshot) {
        wasteSnapshot.forEach(function (doc) {
            doc.ref.delete();
        });
    });

    // Delete user content from Storage
    await admin.storage().bucket().deleteFiles({
        prefix: `users/${user.uid}/`
    });

    await admin.storage().bucket().deleteFiles({
        prefix: `items/${user.uid}/`
    });
});
