
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahioapp_fyp/Buyer_Side/Auth/firebase/login_controller.dart';
import 'package:fahioapp_fyp/Buyer_Side/Auth/valid_forrm.dart';
import 'package:fahioapp_fyp/Buyer_Side/Theme/AppTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bottamnav_scren.dart';
import 'SignUp.dart';
import 'firebase/firebase_auth.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool checkEmail = true;
  bool checkPassword = true;
  bool load = false;

  final userLoogin = Get.put(FirebaseService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:AppBar(
       title: Text('Welcome back!' , style: TextStyle(color: Colors.orange),),
       centerTitle: true,
     ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
        
            // login logo image
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login_logo.png'),
                )
              ),
            ),
        
           //login text field
           Padding(
             padding: EdgeInsets.only(right: 15 , left: 15 , top: 10),
             child: TextFormField(
               controller: _emailController,
               decoration: InputDecoration(
                 label: Text('Enter your Email'),
                 prefixIcon: Icon(Icons.email_outlined , color: ColorTheme.bgcolor,),
                 //fillColor: _emailController.text.isEmpty ? Colors.red : Colors.white,
                 //errorText:  _emailController.text.isEmpty ? "Please Fill The Field" : null,
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(20),
                 ),
               ),
               validator: validateEmail,
             ),
           ),


            //password text field
            Padding(
              padding: EdgeInsets.only(right: 15 , left: 15 , top: 10),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password , color: ColorTheme.bgcolor,),
                    suffix: checkPassword
                    ?
                    IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: (){
                        setState(() {
                          checkPassword = !checkPassword;
                        });
                      },
                    )
                    :
                        IconButton(onPressed: (){
                          setState(() {
                            checkPassword = !checkPassword;
                          });

                        }, icon: Icon(Icons.visibility_off)
                        ),
                    label: Text('Enter your Password'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                ),
                obscureText: checkPassword,
              ),
            ),


            //forget password buttton
            Padding(
              padding: EdgeInsets.only(right: 15 , top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){}, child: Text('Forget Password?' , style: TextStyle(color: Colors.orange),),),
                ],
              ),
            ),
        
            //login Button
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              height: MediaQuery.of(context).size.height*0.06,
              child: ElevatedButton(
                  onPressed: (){
                    print ("Load1 : $load" );
                    setState(() {
                      load = true;
                    });
                    print ("Load2 : $load" );
                    if(_emailController.text.isEmpty && _passwordController.text.isEmpty)
                      {
                        setState(() {
                          load = false;
                        });
                        print ("Load5 : $load" );
                        Get.snackbar("Fashio", "Please Fill all Fields");
                      }else
                        {
                          setState(() {
                            load = true;
                          });
                         // readDataAndSetDataLocally();
                          LoginController().login(
                            context,
                            _emailController.text,
                            _passwordController.text,
                          );

                          //Get.to(LoginPage());
                          setState(() {
                            load = false;
                          });
                        }
                  },
                  child: load
                ?
                      CircularProgressIndicator()
                  :
                  Text('Login' , style: TextStyle(fontSize: 18),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  foregroundColor: Colors.white
                ),
              ),
            ),
        
            //Sign up button
            Container(
              height: MediaQuery.of(context).size.height*0.043,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have account? Click" ),
                  TextButton(
                    onPressed: (){
                    Get.to(SignUp());
                  },
                    child: Text("Sing Up",style: TextStyle(color: Colors.orange),),),
                ],
              ),
            ),
            //guest mode
            Container(
              height: MediaQuery.of(context).size.height*0.04,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Join As" ),
                  TextButton(onPressed: (){
                    Get.to(BottomNavBar(currentIndex: 0,));
                  },
                    child: Text("Guest",style: TextStyle(color: Colors.orange),),),
                ],
              ),
            ),
        
            SizedBox(
              height: MediaQuery.of(context).size.height*0.02,
            ),
            //login other option
            Container(
              height: MediaQuery.of(context).size.height*0.04,
              child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Container(
                   width: MediaQuery.of(context).size.width*0.3,
                   child: Divider(
                     color: Colors.black,
                   ),
                 ),
                  Padding(
                    padding: EdgeInsets.only(left: 10 , right: 10),
                      child: Text("or Login With"),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.3,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
        
            SizedBox(
              height: MediaQuery.of(context).size.height*0.02,
            ),
            //social Login
            Container(
              height: MediaQuery.of(context).size.height*0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google social logo
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.05,
                      width: MediaQuery.of(context).size.width*0.1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Group.png')
                        )
                      ),
                    ),
                  ),
        
                  SizedBox(
                    width: 10,
                  ),
        
                  //facebook social logo
                  Container(
                    width: 48,
                    height: 48,
                    decoration: ShapeDecoration(
                      color: Colors.grey[300],
                      shape: const OvalBorder(),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.facebook,
                        color: Colors.blue,
                        size: 29,
                      ),
                    ),
                  ),
                ],
              ),
            )
         ],
        ),
      ),
    );
  }

  Future<void> readDataAndSetDataLocally() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        String userType = snapshot.data()!["Account Type"];
        print("account type: $userType");
      } else {
        print('failed');
      }
    });
  }
}
