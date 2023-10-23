import 'package:equatable/equatable.dart';
import 'package:procastiless/components/paywall/models/Offer.dart';

abstract class PaywallState extends Equatable {}

class PaywallIdleState extends PaywallState {
  @override
  List<Object?> get props => [];
}

class PaywallOffersLoading extends PaywallState {
  @override
  List<Object?> get props => [];
}

class PaywallOfferLoaded extends PaywallState {
  final List<Offer> offers;
  PaywallOfferLoaded(this.offers);

  @override
  List<Object?> get props => [this.offers];
}

class PaywallError extends PaywallState {
  final String errorMessage;
  PaywallError(this.errorMessage);

  @override
  List<Object?> get props => [this.errorMessage];
}

class UserInProcessOfPaywall extends PaywallState {
  @override
  List<Object?> get props => [];
}

class UserRegisteredToPaywalled extends PaywallState {
  @override
  List<Object?> get props => [];
}

class UserNotRegisteredToPaywalled extends PaywallState {
  @override
  List<Object?> get props => [];
}
