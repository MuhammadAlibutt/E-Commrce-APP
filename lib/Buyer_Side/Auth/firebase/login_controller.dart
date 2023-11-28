
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../bottamnav_scren.dart';

class LoginController {
  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        Get.snackbar(
            'Fashio', 'Please check your email to verify your account');
      } else if (user != null && user.emailVerified) {
        Get.to(() => BottomNavBar(currentIndex: 0,));
        Get.snackbar('Fashio', 'Login Successful');
      } else {
        Get.snackbar('Fashio', 'Login Failed');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Failed',
          'No user found for that email.',
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Failed',
          'Wrong password provided for that user.',
        );
      } else {
        Get.snackbar(
          'Failed',
          e.message!.substring(30),
        );
      }
    }
  }
}
