import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahioapp_fyp/Buyer_Side/bottamnav_scren.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Theme/AppTheme.dart';

class CardScreen extends StatefulWidget {
  const CardScreen(
      {Key? key,

      })
      : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  Map<String, dynamic>? paymentIntent;
  // final student_Name = const FlutterSecureStorage();
  // final tutorName = const FlutterSecureStorage();
  // Future<void> saveDataInFireStore() async {
  //   String courseTitle = widget.courseName;
  //   String courseTutorName = widget.tutorName;
  //   String coursePrice = widget.price;
  //   String courseImage = widget.imageUrl;
  //
  //   tutorName.write(key: 'Tutor_Name', value: courseTutorName);
  //
  //   print('teacher name1 : $courseTutorName');
  //
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   await FirebaseFirestore.instance
  //       .collection('Student_Enrolled_Courses')
  //       .doc(uid)
  //       .collection('Enrolled_Courses')
  //       .add({
  //     "Tutor_Name": courseTutorName,
  //     "Course_Name": courseTitle,
  //     "Course_Price": coursePrice,
  //     "Course_Image": courseImage,
  //   });
  //   // _showSnackBar('Transaction Successful2');
  // }

  // Future<void> newCollectionOfEnrolledCourses() async {
  //   String courseTitle = widget.courseName;
  //   String courseTutorName = widget.tutorName;
  //   String coursePrice = widget.price;
  //   String courseImage = widget.imageUrl;
  //
  //   tutorName.write(key: 'Tutor_Name', value: courseTutorName);
  //   String? studentName = await student_Name.read(key: 'studentName');
  //   print('teacher name1 : $courseTutorName');
  //
  //   // String uid = FirebaseAuth.instance.currentUser!.uid;
  //   await FirebaseFirestore.instance
  //       .collection('Course_Enrolled_By_Student')
  //       .doc(courseTutorName)
  //       .collection('Enrolled_Courses')
  //       .add({
  //     "Student_Name": studentName,
  //     "Course_Name": courseTitle,
  //     "Course_Price": coursePrice,
  //     "Course_Image": courseImage,
  //   });
  //   // _showSnackBar('Transaction Successful');
  // }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();
      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: 'USD',
        currencyCode: "USD",
        testEnv: true,
      );
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!["client_secret"],
            style: ThemeMode.light,
            merchantDisplayName: "Test",
            googlePay: gpay,
          ));
      print('okey22');
      dislayPaymentSheet();
    } catch (e) {
      print("error: $e");
    }
  }

  void dislayPaymentSheet() async {
    try {
      print('okeeyy33');
      await Stripe.instance.presentPaymentSheet();
      print("Done");
    } catch (e) {
      print("Failed");
    }
  }

  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {"amount": '250', "currency": "USD"};
      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            'Authorization':
            'Bearer sk_test_51OHKw4IX7xZrgGeBs98g9m4KNXMfOwNrzZYc1izpPgP0fTn0ptZNTBllR9qsYQYYQXpzSOyixsJWr1sIVXVNVjcX006zXVLWVc',
            'Content-Type': 'application/x-www-form-urlencoded',
          });
      print('okey');
      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.bgcolor,
        title: const Text('Amount to Pay'),
        centerTitle: true,
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: (){
            Get.to(()=> BottomNavBar(currentIndex: 3,));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorTheme.bgcolor,
              minimumSize: const Size(250, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Pay Here !',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              makePayment();
              // newCollectionOfEnrolledCourses();
              // saveDataInFireStore();
            },
          )),
    );
  }
}