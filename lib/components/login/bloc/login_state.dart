import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:procastiless/components/login/models/user.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoggedIn extends LoginState {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AccountUser? accountUser;
  LoggedIn(this.accountUser);

  @override
  // TODO: implement props
  List<Object?> get props => [auth, accountUser];
}

class LoggedOut extends LoginState {
  const LoggedOut();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//Initial state. Waiting in the login screen.
//User has not made any actions yet
class WaitingToLogin extends LoginState {
  const WaitingToLogin();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InProcessOfLogin extends LoginState {
  const InProcessOfLogin();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InProcessOfLogout extends LoginState {
  const InProcessOfLogout();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InRegistrationProcess extends LoginState {
  const InRegistrationProcess();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegistrationSuccess extends LoginState {
  const RegistrationSuccess();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegistrationFailure extends LoginState {
  const RegistrationFailure();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
