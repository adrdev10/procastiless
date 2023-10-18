import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginEvents {}

class SignInEvent extends LoginEvents {}

class LogOutEvent extends LoginEvents {}

class SignUpEvent extends LoginEvents {}

class SetUpAvatarEvent extends LoginEvents {}

class SignUpWithGoogleAuthEvent extends LoginEvents {}

class DeleteAccountEvent extends LoginEvents {}

class CheckIfAccountExist extends LoginEvents {
  final String uid;
  CheckIfAccountExist(this.uid);
}
