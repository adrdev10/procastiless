import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/login/bloc/login_event.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState);
  @override
  Stream<LoginState> mapEventToState(LoginEvents event) async* {
    List<LoginState> states = <LoginState>[];
    switch (event.runtimeType) {
      case SignInEvent:
        _signInEvent(states);
        break;
      case LogOutEvent:
        _singoutEvent(states);
        break;
      case SignUpEvent:
        break;
      case SignUpWithGoogleAuthEvent:
        break;
    }

    for (LoginState state in states) {
      yield state;
    }
  }

  void _signInEvent(List<LoginState> states) {
    states.add(InProcessOfLogin());
    trySignInWithAsAnou();
    states.add(LoggedIn());
  }

  void _singoutEvent(List<LoginState> states) {
    logoutFromAccount();
    states.add(InProcessOfLogout());
    states.add(WaitingToLogin());
  }

  ///Signs annonimous account.Once you sign out and sign back in as Announimous
  ///a new account is created.
  void logoutFromAccount() async {
    await FirebaseAuth.instance.signOut();
  }

  void trySignInWithAsAnou() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      print("Anonymous accounts are not enabled in Firebase system");
      print('Error: ${e.message} \nError type: ${e.runtimeType}');
    } catch (e) {
      print('Error: $e \n Error: ${e.runtimeType}');
    }
  }

  @override
  void onTransition(Transition<LoginEvents, LoginState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  void onChange(Change<LoginState> change) {
    super.onChange(change);
    print(change);
  }
}
