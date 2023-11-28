
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahioapp_fyp/Buyer_Side/bottamnav_scren.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        // User is verified, now fetch additional information from Firestore
        DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
            .instance
            .collection('Users')
            .doc(user.uid)
            .get();

        if (userData.exists) {
          // Assuming there is a field called 'accountType' in the user document
          String accountType = userData.get('Account_Typ');

          // Perform actions based on the account type
          if (accountType == 'user') {
            // Redirect to admin page
             Get.to(() => BottomNavBar(currentIndex: 0,));
            print('Accoount type user: $accountType');
          } else {
            print('Accoount type: $accountType');
            // Redirect to user page or do other action
          }
        } else {
          Get.snackbar('Fashio', 'User data not found');
        }
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


// Future<void> readDataAndSetDataLocally(User currentUser, BuildContext context) async {
  //   await FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(currentUser.uid)
  //       .get()
  //       .then((snapshot) async {
  //     if (snapshot.exists) {
  //       String userType = snapshot.data()!["Account Type"];
  //       print("account type: $userType");
  //
  //       if (userType == "user") {
  //         // Navigate to user screen
  //        // Get.to(() => UserScreen());
  //         print('user');
  //       } else if (userType == "business") {
  //         // Navigate to business screen
  //         //Get.to(() => BusinessScreen());
  //         print('business');
  //       } else {
  //         print('Unknown account type');
  //       }
  //     } else {
  //       print('User data not found');
  //     }
  //   });
  // }

}
