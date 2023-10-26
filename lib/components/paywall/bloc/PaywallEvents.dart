import 'package:equatable/equatable.dart';

abstract class PaywallEvents extends Equatable {}

class CheckSubscription extends PaywallEvents {
  @override
  List<Object?> get props => [];
}

class GetPaywallOfferEvent extends PaywallEvents {
  @override
  List<Object?> get props => [];
}

class RegisterUserToPaywall extends PaywallEvents {
  final String offerId;
  RegisterUserToPaywall(this.offerId);

  @override
  List<Object?> get props => [this.offerId];
}

class CancelUserFromPaywall extends PaywallEvents {
  @override
  List<Object?> get props => [];
}

class RenewUserToPaywall extends PaywallEvents {
  @override
  List<Object?> get props => [];
}
