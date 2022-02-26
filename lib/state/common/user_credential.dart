import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserCredentialProvider extends ChangeNotifier {
  UserCredential? userCredential;

  setUserCredential(UserCredential userCredential) {
    this.userCredential = userCredential;
  }
}
