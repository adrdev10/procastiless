import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

// ignore: subtype_of_sealed_class
class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {
  final Map<String, dynamic> _data;

  MockQueryDocumentSnapshot(this._data);

  @override
  Map<String, dynamic> data() {
    return _data;
  }
}
