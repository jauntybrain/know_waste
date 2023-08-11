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

  Future<T?> futureSingle(String id) async {
    try {
      return (await withConverter.doc(id).get()).data();
    } catch (err) {
      return null;
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

  Stream<T?> streamAll() async* {
    final StreamController<T?> streamController = StreamController();

    try {
      final snapshots = withConverter.snapshots();

      snapshots.listen(
        (snapshot) {
          for (var document in snapshot.docs) {
            streamController.add(document.data());
          }
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

  Future<Map<String, T>> futureAll([String? orderBy, bool desc = false]) async {
    List<QueryDocumentSnapshot<T>> docs;

    docs = orderBy != null ? (await this.orderBy(orderBy, desc).get()).docs : (await withConverter.get()).docs;

    return {for (QueryDocumentSnapshot<T> doc in docs) doc.id: doc.data()};
  }

  Query<T> whereEqual(String field, String value) {
    return withConverter.where(field, isEqualTo: value);
  }
}
