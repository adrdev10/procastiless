import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:procastiless/components/login/bloc/login_event.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/login/models/user.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState);
  FirebaseFirestore store = FirebaseFirestore.instance;
  @override
  Stream<LoginState> mapEventToState(LoginEvents event) async* {
    List<LoginState> states = <LoginState>[];
    switch (event.runtimeType) {
      case SignInEvent:
        _signInEvent(states);
        break;
      case SignUpWithGoogleAuthEvent:
        _signInWithGoogleEvent(states);
        break;
      case LogOutEvent:
        _singoutEvent(states);
        break;
      case SignUpEvent:
        break;
    }

    for (LoginState state in states) {
      yield state;
    }
  }

  void _signInEvent(List<LoginState> states) {
    states.add(InProcessOfLogin());
    trySignInWithAsAnou();
    states.add(LoggedIn(null));
  }

  void _singoutEvent(List<LoginState> states) {
    logoutFromAccount();
    states.add(InProcessOfLogout());
    states.add(WaitingToLogin());
  }

  void _signInWithGoogleEvent(List<LoginState> states) async {
    try {
      emit(InProcessOfLogin());
      var user = await signinWithGoogle();
      if (user != null) {
        emit(LoggedIn(user));
      } else {
        states.add(WaitingToLogin());
      }
    } catch (e) {
      print(e);
      states.add(WaitingToLogin());
    }
  }

  ///Signs annonimous account.Once you sign out and sign back in as Announimous
  ///a new account is created.
  void logoutFromAccount() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<AccountUser?> signinWithGoogle() async {
    var userInCollection;
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    try {
      var authresult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      //Check if user exists in DB
      userInCollection = await isUserInCollection(authresult);
      if (userInCollection == null) {
        //Create new user in DB and update the bloc state
        userInCollection = addUser(authresult);
      }
      return userInCollection;
    } catch (e) {
      return null;
    }
  }

  Future<AccountUser?> addUser(UserCredential auth) async {
    try {
      await store.collection('users').doc(auth.user?.uid).set({
        'avatarUrl': '',
        'email': auth.user?.email,
        'exp': 0,
        'name': auth.user?.displayName,
        'uuid': auth.user?.uid
      });
      return AccountUser(
          auth.user?.displayName, auth.user?.email, "", auth.user?.uid, 0);
    } catch (e) {
      print(e);
    }
  }

  Future<AccountUser?> isUserInCollection(UserCredential auth) async {
    final cRef = await store.collection('users').doc(auth.user?.uid).get();
    try {
      if (cRef.exists) {
        final user = AccountUser.fromJson(cRef.data());
        return user;
      }
    } catch (e) {
      print(e);
    }
    return null;
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
