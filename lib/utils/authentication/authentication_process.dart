/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/9/22, 8:30 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationsCallback {
  void authenticationCompleted();
}

class AuthenticationsProcess {

  Future<UserCredential> startGoogleAuthentication() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuthentication = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuthentication?.accessToken,
      idToken: googleAuthentication?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future startPhoneNumberAuthentication(String enteredPhoneNumber, AuthenticationsCallback authenticationsCallback) async {

    String phoneNumber = "+${enteredPhoneNumber}";

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {

        authenticationsCallback.authenticationCompleted();

      },
      verificationFailed: (FirebaseAuthException exception) {



      },
      codeSent: (String verificationId, int? resendToken) {



      },
      codeAutoRetrievalTimeout: (String verificationId) {



      },
    );

  }

}