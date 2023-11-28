import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahioapp_fyp/Buyer_Side/Theme/AppTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bottamnav_scren.dart';
import 'edit_profile_screen.dart';




class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = '';
  String _userEmail = '';
  String _userContact = '';
  String _userAddress = '';

  Future<void> viewValue() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get();
    if (documentSnapshot.exists) {
      final Map<String, dynamic> data =
      documentSnapshot.data() as Map<String, dynamic>;
      final String email = data['User_Email'];
      final String userName = data['User Name'];
      final String contact = data['User_Phone'];
      final String address = data['User_Address'];
      setState(() {
        _userEmail = email;
        _username = userName;
        _userContact = contact;
        _userAddress = address;
      });
      print("1$_userEmail");
      print("2$_username");
      print("3$_userContact");
      print("4$_userAddress");
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile' , style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Get.to(BottomNavBar(currentIndex: 0,));
          },
          icon: Icon(Icons.arrow_back_ios, color: ColorTheme.bgcolor),
        ),
        actions: [
          IconButton(
              onPressed: (){
              Get.to(EditProfile());
              },
              icon: Icon(Icons.mode_edit_outline_sharp , color: ColorTheme.bgcolor,)
          ),
        ],
      ),
      body:  Column(
        children:  [
          SizedBox(
            height:MediaQuery.of(context).size.height*0.03,
          ),
          CircleAvatar(
            radius: 80,
            child: Container(
              height: MediaQuery.of(context).size.height*0.2,
              width: MediaQuery.of(context).size.width*0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/boy.png')
                  )
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: MediaQuery.of(context).size.height*0.073,
                width: MediaQuery.of(context).size.width*0.9,
                child: InputDecorator(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined,color: ColorTheme.bgcolor),
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                  child: Text(_userEmail),
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.073,
              width: MediaQuery.of(context).size.width*0.9,
              child: InputDecorator(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_3, color: ColorTheme.bgcolor),
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                child: Text(_username),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.073,
              width: MediaQuery.of(context).size.width*0.9,
              child: InputDecorator(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone , color: ColorTheme.bgcolor,),
                    labelText: 'Contact',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                child: Text(_userContact),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.2,
              width: MediaQuery.of(context).size.width*0.9,
              child: InputDecorator(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on_outlined , color: ColorTheme.bgcolor),
                    labelText: 'Address',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                child: Text(_userAddress),
              ),
            ),
          ),
        ],
      )
    );
  }
}


