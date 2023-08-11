import { Timestamp } from 'firebase-admin/firestore';
import { firestore, functions } from './global';

import * as vision from '@google-cloud/vision';

export const processLabeledWaste = functions
    .region('us-central1')
    .firestore.document('labeledWaste/{wasteID}')
    .onCreate(async (snapshot) => {
        const wasteData = snapshot.data();

        if (!wasteData.labels || wasteData.labels.length == 0) {
            throw new functions.https.HttpsError(
                'unavailable',
                'Error occurred'
            );
        }

        const userID = wasteData.file.split('gs://')[1].split('/')[2];

        const textLabels = wasteData.labels.map((label: any) => label.description);
        const labelsWithPreditions = wasteData.labels.map((label: any) => `${label.description}: ${label.score}`);

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
            'userID': userID,
            'labels': textLabels,
            'objects': textObjects,
            'labelsString': labelsWithPreditions.join(', '),
            'objectsString': objectsWithPredictions.join(', '),
            'date': Timestamp.now()
        });
    });

export const processAnalyzedWaste = functions
    .region('us-central1')
    .firestore.document('analyzedWaste/{wasteID}')
    .onUpdate(async (snapshot) => {
        const analyzedWaste = snapshot.after.data();

        if (!analyzedWaste.advice) {
            throw new functions.https.HttpsError(
                'unavailable',
                'Error occurred'
            );
        }

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

        await firestore.collection('analyzedWaste').doc(snapshot.after.id).update({
            'advice': filteredAdvice,
            'name': objectName,
            'material': objectMaterial,
            'tips': tips,
            'recyclable': recyclable?.toLowerCase() === 'true',
        });
    });


