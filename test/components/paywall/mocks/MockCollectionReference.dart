import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

import 'MockQuerySnapshots.dart';

// ignore: subtype_of_sealed_class, must_be_immutable
class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {
  final MockQuerySnapshots _data;
  MockCollectionReference(this._data);
  @override
  Future<QuerySnapshot<Map<String, dynamic>>> get([GetOptions? options]) {
    return super.noSuchMethod(Invocation.method(#get, [], {#options: options}),
        returnValue: Future.value(_data), // Return a mocked QuerySnapshot
        returnValueForMissingStub: Future.value(_data));
  }
}
