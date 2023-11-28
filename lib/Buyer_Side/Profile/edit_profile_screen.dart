import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahioapp_fyp/Buyer_Side/Profile/profile_screen.dart';
import 'package:fahioapp_fyp/Buyer_Side/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../Auth/firebase/firebase_auth.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final updatController = Get.put(FirebaseService());
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userController = TextEditingController();
  final _contactController = TextEditingController();
  final _addressController = TextEditingController();
  final _imagePicker = ImagePicker();
  File? _selectedImage;
  bool _showPassword = true;
  bool load = false;

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery, // You can also use ImageSource.camera
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.to(ProfileScreen());
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: _selectedImage != null
                    ? FileImage(_selectedImage!)
                    : AssetImage('assets/images/boy.png')
                        as ImageProvider<Object>?,
                child: _selectedImage == null
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.2,
                        padding: EdgeInsets.only(left: 90, top: 110),
                        // decoration: BoxDecoration(
                        //   color: Colors.black.withOpacity(0.4),
                        // ),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          size: 30,
                          color: ColorTheme.bgcolor,
                        ),
                      )
                    : Container(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: ColorTheme.bgcolor,
                    ),
                    //label: Text('Email'),
                    hintText: "Enter new email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.password,
                    color: ColorTheme.bgcolor,
                  ),
                  hintText: "Enter new Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  suffixIcon: _showPassword == true
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: Icon(
                            Icons.visibility_off,
                            color: ColorTheme.bgcolor,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: Icon(
                            Icons.visibility,
                            color: ColorTheme.bgcolor,
                          ),
                        ),
                ),
                obscureText: _showPassword,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _userController,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_3,
                      color: ColorTheme.bgcolor,
                    ),
                    //label: Text('UserName'),
                    hintText: "Pleas enter new username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _contactController,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: ColorTheme.bgcolor,
                    ),
                    // label: Text('Contact'),
                    hintText: "please enter your new contact number ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _addressController,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: ColorTheme.bgcolor,
                    ),
                    // label: Text('Address'),
                    hintText: "Please add your new address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  load = true;
                });
                // updatController.updateUserData(_emailController.text, _userController.text, _contactController.text, _addressController.text);
                if (_emailController.text.isEmpty ||
                    _passwordController.text.isEmpty ||
                    _userController.text.isEmpty ||
                    _contactController.text.isEmpty ||
                    _addressController.text.isEmpty) {
                  Get.snackbar("Fahio", 'Please Fill All Fields');
                  setState(() {
                    load = false;
                  });
                } else {
                  updatController.updateUserData(
                      _passwordController.text,
                      _userController.text,
                      _contactController.text,
                      _addressController.text,
                      _selectedImage as File);
                  setState(() {
                    load = false;
                  });

                  Get.snackbar("Fashio", "Details Updated Successfull");
                }
              },
              child:
                  load ? CircularProgressIndicator() : Text("Update Details"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorTheme.bgcolor,
                  foregroundColor: ColorTheme.btntxtcolor),
            )
          ],
        ),
      ),
    );
  }
}
