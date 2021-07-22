abstract class LoginState {
  const LoginState();
}

class LoggedIn extends LoginState {
  const LoggedIn();
}

class LoggedOut extends LoginState {
  const LoggedOut();
}

//Initial state. Waiting in the login screen.
//User has not made any actions yet
class WaitingToLogin extends LoginState {
  const WaitingToLogin();
}

class InProcessOfLogin extends LoginState {
  const InProcessOfLogin();
}

class InProcessOfLogout extends LoginState {
  const InProcessOfLogout();
}

class InRegistrationProcess extends LoginState {
  const InRegistrationProcess();
}

class RegistrationSuccess extends LoginState {
  const RegistrationSuccess();
}

class RegistrationFailure extends LoginState {
  const RegistrationFailure();
}
