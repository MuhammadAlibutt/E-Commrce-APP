import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahioapp_fyp/Buyer_Side/Theme/AppTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Auth/login.dart';
import '../Profile/profile_screen.dart';





class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  String _username = '';
  Future<void> viewValue() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get();
    if (documentSnapshot.exists) {
      final Map<String, dynamic> data =
      documentSnapshot.data() as Map<String, dynamic>;
      final String userName = data['User Name'];
      setState(() {
        _username = userName;
      });

    }
    else{
      Get.snackbar("Fashio", "Some Error occured Please try again");
    }
  }

  @override
  void initState() {
    super.initState();
    viewValue();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: FirebaseAuth.instance.currentUser == null
          ?
          Center(
           child: Container(

             child: ElevatedButton(
               onPressed: (){
                 Get.to(LoginPage());
               },
               child: Text("Sign In"),
               style:ElevatedButton.styleFrom(
                 backgroundColor: ColorTheme.bgcolor,
                     foregroundColor: ColorTheme.btntxtcolor
               )
             ),
           )
          )
          :
      ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 15),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/boy.png')
                    )
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(_username),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: (){
              Get.to(ProfileScreen());
            },
          ),

          ListTile(
            leading: Icon(Icons.file_present),
            title: Text('Terms and Conditions'),
            onTap: (){},
          ),

          ListTile(
            leading: Icon(Icons.policy_outlined),
            title: Text('Privacy Policy'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: (){
              FirebaseAuth.instance.signOut();
              Get.to(LoginPage());
            },
          ),

          ListTile(
            leading: Icon(Icons.policy_outlined),
            title: Text('Switch to Seller'),
            onTap: (){
              Get.to(LoginPage());
            },
          ),
        ],
      ),
    );
  }
}
