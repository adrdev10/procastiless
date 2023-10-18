import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

import 'MockCollectionReference.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {
  final MockCollectionReference _data;
  MockFirebaseFirestore(this._data);
  @override
  CollectionReference<Map<String, dynamic>> collection(String collectionPath) {
    return super.noSuchMethod(
      Invocation.method(#collection, [collectionPath]),
      returnValue: _data,
      returnValueForMissingStub: _data,
    );
  }
}
