import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import './database.dart';

abstract class BaseAuth {
  Future<FirebaseUser> signIn(String email, String password);

  Future<FirebaseUser> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();

  Future<bool> isEmailVerified();

  Future<void> reloadUser();

  Future<void> updateUserProfile({displayName, photoUrl});
  Future<void> deleteUserProfile();

  Future<FirebaseUser> anonymousSignIn();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final FacebookLogin _facebookLogin = FacebookLogin();

  DatabaseService _dbService = DatabaseService();

  Future<FirebaseUser> signIn(String email, String password) async {
    try {
      AuthResult user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    // await _dbService.saveDeviceToken();
    return user.user;
    } catch (e) {
    }
  }

  Future<FirebaseUser> signUp(String email, String password) async {
    AuthResult user;
    try {
      user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _dbService.saveDeviceToken();

      return user.user;
    } catch (e) {
      print(e);
      
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    try {
      FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
    } catch (e) {
    }
  }

  Future<void> signOut() async {
    try {
      _firebaseAuth.signOut();
      // _googleSignIn.disconnect();
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendEmailVerification() async {
  
    

    try {
      FirebaseUser user = await _firebaseAuth.currentUser();
      user.sendEmailVerification();
      
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserProfile({displayName, photoUrl}) async {
    print([displayName, photoUrl]);
    FirebaseUser user = await _firebaseAuth.currentUser();

    UserUpdateInfo updateUser = UserUpdateInfo();
    updateUser.displayName = await displayName;

    await user.updateProfile(updateUser);
    await user.reload();
  }

  Future<void> deleteUserProfile() async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    await user.delete();

    await user.reload();
  }

  Future<void> sendPasswordResetEmail(email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<bool> isEmailVerified() async {
    try {
      FirebaseUser user = await _firebaseAuth.currentUser();

    return user.isEmailVerified;
    } catch (e) {
    }
  }

  Future<FirebaseUser> facebookLogin() async {
    // final FacebookLoginResult results =
    //     await _facebookLogin.logInWithReadPermissions(['email']);
    // _facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    // print('================> ${results.errorMessage}');
    // final AuthCredential _credential = FacebookAuthProvider.getCredential(
    //   accessToken: results.accessToken.token,
    // );
    // final AuthResult _firebaseUser =
    //     await _firebaseAuth.signInWithCredential(_credential);

    // await _dbService.saveDeviceToken();

    // return _firebaseUser.user;
  }

  Future<void> reloadUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.reload();
  }

  Future<FirebaseUser> anonymousSignIn() async {
    var auth = await _firebaseAuth.signInAnonymously();
    await _dbService.saveDeviceToken();
    return auth.user;
  }
}
