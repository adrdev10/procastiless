import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

class MockQuerySnapshots extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? _docs;

  MockQuerySnapshots([this._docs]);

  @override
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get docs => _docs ?? [];
}
