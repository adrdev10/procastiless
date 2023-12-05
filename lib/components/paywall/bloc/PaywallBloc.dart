import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/login/bloc/login_block.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/paywall/bloc/PaywallEvents.dart';
import 'package:procastiless/components/paywall/bloc/PaywallState.dart';
import 'package:procastiless/components/paywall/models/Offer.dart';
import 'package:procastiless/components/paywall/models/UserToOffer.dart';

class PaywallBloc extends Bloc<PaywallEvents, PaywallState> {
  final FirebaseFirestore firestore;
  final LoginBloc loginBloc;
  PaywallBloc(this.firestore, this.loginBloc, initialState)
      : super(initialState);

  Future<String?> _getUserId() async {
    var lastLoggedInState = loginBloc.stream.last;
    if (lastLoggedInState is LoggedIn) {
      var value = await lastLoggedInState;
      return (value as LoggedIn).accountUser?.uuid;
    }
    return "";
  }

  @override
  Stream<PaywallState> mapEventToState(PaywallEvents event) async* {
    switch (event.runtimeType) {
      case GetPaywallOfferEvent:
        yield* _getPaywallOfferFromDB();
        break;
      case RegisterUserToPaywall:
        yield* _subcribeUserToPaywall((event as RegisterUserToPaywall).offerId);
        break;
      case CancelUserFromPaywall:
        break;
      case RenewUserToPaywall:
        break;
      case CheckSubscription:
        break;
    }
  }

  Stream<PaywallState> _subcribeUserToPaywall(String offerId) async* {
    yield UserInProcessOfPaywall();
    try {
      final userId = await _getUserId();
      final paywall = await firestore
          .collection("paywall")
          //We want to check that the user has a valid id. Add some validation here
          .add(UserToOffer(offerId, userId ?? "", Timestamp.now()).toJson());

      final wasDocCreated = paywall.id.isNotEmpty;
      if (wasDocCreated) {
        UserRegisteredToPaywalled();
      }
    } catch (e) {
      yield PaywallError(e.toString());
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
