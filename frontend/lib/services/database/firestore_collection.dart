import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCollection<T> {
  FirestoreCollection();

  final String path = '';

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference<T> get withConverter => throw UnimplementedError();

  T streamAllFiltered() => throw UnimplementedError();

  Query<T> orderBy(String field, [bool desc = false]) {
    return withConverter.orderBy(field, descending: desc);
  }

  Future<T?> futureSingleByID(String id) async {
    try {
      return (await withConverter.doc(id).get()).data();
    } catch (err) {
      return null;
    }
  }

  Future<T?> futureSingleWhereEqual(String field, dynamic value) async {
    try {
      final query = withConverter.where(field, isEqualTo: true).orderBy('date', descending: true).limit(1);

      return (await query.get()).docs.firstOrNull?.data();
    } catch (err) {
      rethrow;
    }
  }

  Stream<T?> streamSingle(String? id) async* {
    if (id == null) {
      yield* const Stream.empty();
    } else {
      final StreamController<T?> streamController = StreamController();

      try {
        final snapshots = withConverter.doc(id).snapshots();

        snapshots.listen(
          (snapshot) {
            streamController.add(snapshot.data());
          },
          onError: (e) {
            streamController.addError(e);
            streamController.close();
          },
        );
      } catch (e) {
        streamController.addError(e);
        streamController.close();
      }

      yield* streamController.stream;
    }
  }

  Stream<List<T>> streamAllWhereIn(Object field, List<String> array) async* {
    if (array.isEmpty) {
      yield* Stream.value([]);
    } else {
      final StreamController<List<T>> streamController = StreamController();

      try {
        final snapshots = withConverter.where(field, whereIn: array).snapshots();

        snapshots.listen(
          (snapshot) {
            streamController.add(snapshot.docs.map((e) => e.data()).toList());
          },
          onError: (e) {
            streamController.addError(e);
            streamController.close();
          },
        );
      } catch (e) {
        streamController.addError(e);
        streamController.close();
      }

      yield* streamController.stream;
    }
  }

  Future<List<T>> futureAll([String? orderBy, bool desc = false]) async {
    List<QueryDocumentSnapshot<T>> docs;

    docs = orderBy != null ? (await this.orderBy(orderBy, desc).get()).docs : (await withConverter.get()).docs;

    return docs.map((doc) => doc.data()).toList();
  }

  Query<T> whereEqual(String field, dynamic value) {
    return withConverter.where(field, isEqualTo: value);
  }
}
