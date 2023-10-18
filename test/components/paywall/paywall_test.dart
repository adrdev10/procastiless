import 'package:flutter_test/flutter_test.dart';
import 'package:procastiless/components/paywall/bloc/PaywallBloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:procastiless/components/paywall/bloc/PaywallEvents.dart';
import 'package:procastiless/components/paywall/bloc/PaywallState.dart';
import 'package:procastiless/components/paywall/models/Offer.dart';
import 'mocks/MockCollectionReference.dart';
import 'mocks/MockFirebaseFirestore.dart';
import 'mocks/MockQueryDocumentSnapshot.dart';
import 'mocks/MockQuerySnapshots.dart';

void main() {
  group("PaywallBloc test class", () {
    late MockFirebaseFirestore mockFirebaseFirestore;
    late MockCollectionReference mockCollectionReference;
    late MockQuerySnapshots mockQuerySnapshot;
    late MockQueryDocumentSnapshot mockQueryDocumentSnapshot;
    late PaywallBloc paywallBloc;

    void setupMockQueryDocumentSnapshot(Map<String, dynamic> data) {
      mockQueryDocumentSnapshot = MockQueryDocumentSnapshot(data);

      var mockDocsList = List.generate(1, (index) => mockQueryDocumentSnapshot);

      // Update the MockQuerySnapshots instance with the mockDocsList
      mockQuerySnapshot = MockQuerySnapshots(mockDocsList);
      mockCollectionReference = MockCollectionReference(mockQuerySnapshot);
      mockFirebaseFirestore = MockFirebaseFirestore(mockCollectionReference);
    }

    setUp(() {
      setupMockQueryDocumentSnapshot({
        'bulletInfo': ['value 1'],
        'description': 'value 2',
        'name': 'value 3',
        'offerId': 'value 4',
        'price': 5
      });
      // mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
      // Mock behavior
      paywallBloc = PaywallBloc(mockFirebaseFirestore, PaywallIdleState());
    });

    tearDown(() => paywallBloc.close());

    test(
        "when user sees app for the first time, then state must be initial/idle state ",
        () {
      expect(paywallBloc.state, PaywallIdleState());
    });

    blocTest<PaywallBloc, PaywallState>(
      "when user activates paywall, then verify bloc emits [PaywallOffersLoading, PaywallOfferLoaded]",
      build: () {
        return paywallBloc;
      },
      act: (bloc) => bloc.add(GetPaywallOfferEvent()),
      expect: () => [
        PaywallOffersLoading(),
        PaywallOfferLoaded([
          Offer(['value 1'], 'value 2', 'value 3', 'value 4', 5),
        ])
      ],
    );

    blocTest<PaywallBloc, PaywallState>(
      "when data for offers is incorrect, then verify parsing error occurs and bloc emits [PaywallOffersLoading, PaywallError] 2",
      build: () {
        setupMockQueryDocumentSnapshot({
          'efr': ['value 1'],
          'description': 'value 2',
          'name': 'value 3',
          'offerId': 'value 4',
          'price': 10
        });
        paywallBloc = PaywallBloc(mockFirebaseFirestore, PaywallIdleState());
        return paywallBloc;
      },
      act: (bloc) => bloc.add(GetPaywallOfferEvent()),
      expect: () => [
        PaywallOffersLoading(),
        PaywallError("type 'Null' is not a subtype of type 'List<String>'")
      ],
    );
  });
}
