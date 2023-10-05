import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:procastiless/components/login/models/user.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoggedIn extends LoginState {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final AccountUser? accountUser;
  LoggedIn(this.accountUser);

  @override
  List<Object?> get props => [auth, accountUser];
}

class LoggedOut extends LoginState {
  const LoggedOut();

  @override
  List<Object?> get props => [];
}

//Initial state. Waiting in the login screen.
//User has not made any actions yet
class WaitingToLogin extends LoginState {
  const WaitingToLogin();

  @override
  List<Object?> get props => [];
}

class InProcessOfLogin extends LoginState {
  const InProcessOfLogin();

  @override
  List<Object?> get props => [];
}

class InProcessOfLogout extends LoginState {
  const InProcessOfLogout();

  @override
  List<Object?> get props => [];
}

class InRegistrationProcess extends LoginState {
  const InRegistrationProcess();

  @override
  List<Object?> get props => [];
}

class RegistrationSuccess extends LoginState {
  const RegistrationSuccess();

  @override
  List<Object?> get props => [];
}

class RegistrationFailure extends LoginState {
  const RegistrationFailure();

  @override
  List<Object?> get props => [];
}
