

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahioapp_fyp/Buyer_Side/Auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../bottamnav_scren.dart';

class FirebaseService extends GetxController{


  Future registerUser(String username , String email , String password, String phone, String address , String type) async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = await FirebaseAuth.instance.currentUser;

    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((signedUser) =>
      {
        FirebaseFirestore.instance.collection('Users').doc(signedUser.user!.uid).set({
          'User Name': username,
      'User_Email': email,
      'User_Password': password,
      'User_Phone': phone,
      'User_Address' : address,
          'Account_Typ': type,
          'Image' : ''
        }).then((signedIn) => {
          print("user reegisterd Successfull"),
      Get.snackbar("Fashio", 'User Registered Successful' , colorText: Colors.blue, icon: const Icon(Icons.add_alert),),
          Get.to(LoginPage()),
      })
      });
    }catch(e){
      print(e);

    }

  }

  //
  Future updateUserData ( String password, String username , String contact , String address , File img)
  async
  {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    await user?.reload();
    await user?.updatePassword(password);
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({
      'User Name': username,
      'User_Address': address,
      'User_Password' : password,
      'User_Phone' : contact,
      'Image' : img,
    });
  }
}