import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/paywall/bloc/PaywallEvents.dart';
import 'package:procastiless/components/paywall/bloc/PaywallState.dart';
import 'package:procastiless/components/paywall/models/Offer.dart';

class PaywallBloc extends Bloc<PaywallEvents, PaywallState> {
  final FirebaseFirestore firestore;
  PaywallBloc(this.firestore, initialState) : super(initialState);

  @override
  Stream<PaywallState> mapEventToState(PaywallEvents event) async* {
    switch (event.runtimeType) {
      case GetPaywallOfferEvent:
        yield* _getPaywallOfferFromDB();
        break;
      case RegisterUserToPaywall:
        break;
      case CancelUserFromPaywall:
        break;
      case RenewUserToPaywall:
        break;
    }
  }

  Stream<PaywallState> _getPaywallOfferFromDB() async* {
    yield PaywallOffersLoading();
    try {
      var paywallOffers = await fetchPaywallOffersForUser();
      yield PaywallOfferLoaded(paywallOffers);
    } catch (e) {
      yield PaywallError(e.toString());
    }
  }

  Future<List<Offer>> fetchPaywallOffersForUser() async {
    try {
      var queryDocs = await firestore.collection("offers").get();
      var offers = queryDocs.docs
          .map((responseDoc) => Offer.offerFromJson(responseDoc.data()))
          .toList();
      return offers;
    } catch (e) {
      throw e;
    }
  }

  Offer processAllOffers(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return Offer.offerFromJson(doc.data());
  }
}
