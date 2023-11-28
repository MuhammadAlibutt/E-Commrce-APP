import 'dart:async';
import 'package:fahioapp_fyp/Buyer_Side/Auth/login.dart';
import 'package:fahioapp_fyp/Buyer_Side/Page/Products/Prooduct_detail.dart';
import 'package:fahioapp_fyp/Buyer_Side/bottamnav_scren.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailsController());

    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4),
    () {
      FirebaseAuth.instance.currentUser == null

      ?
          Get.to(LoginPage())
      :
      Get.to( BottomNavBar(currentIndex: 0,));
    }
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         //crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Container(
             height: MediaQuery.of(context).size.height*0.8,
             width: MediaQuery.of(context).size.width*1,
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: AssetImage('assets/images/applogo.png'),
               )
             ),
           ),
           Text("Version 1.0" , style: TextStyle(fontSize: 20 , color: Colors.grey[500]),)
         ],
       ),
    );
  }
}


