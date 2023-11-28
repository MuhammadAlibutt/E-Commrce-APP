import 'package:fahioapp_fyp/Buyer_Side/Theme/AppTheme.dart';
import 'package:fahioapp_fyp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase/firebase_auth.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final saveUserData = Get.put(FirebaseService());
  bool load = false;
  String account = 'user';
  bool _user = false;
  bool showPassword = true;
  bool confirmshowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Welcome to Fashio" , style: TextStyle(color: ColorTheme.bgcolor),),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Get.to(LoginPage());
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*0.25,
                width: MediaQuery.of(context).size.width*0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/applogo.png')
                  )
                ),
              ),
                Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_3, color: ColorTheme.bgcolor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        hintText: 'Username',
                      ),
                      //validator: validateUsername,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_rounded, color: ColorTheme.bgcolor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        hintText: 'Email',
                      )
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone, color: ColorTheme.bgcolor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: 'Phone Number ',
                        )
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                        controller: _addressController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                            hintText: 'Address',
                          prefixIcon: Icon(Icons.location_history, color: ColorTheme.bgcolor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                        )
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_rounded, color: ColorTheme.bgcolor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                        suffixIcon: showPassword == true
                            ? IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        )
                            : IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                        hintText: 'Password',
                      ),
                      obscureText: showPassword,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_rounded , color: ColorTheme.bgcolor,),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                        suffixIcon: confirmshowPassword == true
                            ? IconButton(
                          onPressed: () {
                            setState(() {
                              confirmshowPassword = !confirmshowPassword;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        )
                            : IconButton(
                          onPressed: () {
                            setState(() {
                              confirmshowPassword = !confirmshowPassword;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                        hintText: 'Confirm Password',
                      ),
                      obscureText: confirmshowPassword,
                    ),
                    SizedBox(height: 5),
                   // ask user if he want to create a business account
                    Row(
                      children: [
                        Checkbox(
                          value: _user,
                          onChanged: (value) {
                            setState(() {
                              _user == false
                                  ? account = 'business'
                                  : account = 'user';
                              _user = value!;
                            });
                          },
                        ),
                        Text(
                          'Create a business account',
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),


                //login button
                TextButton(
                  onPressed: () {

                    Get.to(const LoginPage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                      ),
                  Text(
                            'Login',
                            style: TextStyle(
                              color: ColorTheme.bgcolor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),


                InkWell(
                  onTap: () async {
                    if(_usernameController.text.isNotEmpty || _emailController.text.isNotEmpty || _passwordController.text.isNotEmpty)
                      {
                        if(_passwordController.text == _confirmPasswordController.text)
                          {
                            saveUserData.registerUser(_usernameController.text , _emailController.text ,
                            _passwordController.text , _phoneController.text, _addressController.text , account
                            );
                          }
                        else{
                          Get.snackbar("Fashio", 'Passwords Not Matched' , colorText: Colors.red, icon: const Icon(Icons.error),);

                        }
                      }else{
                      Get.snackbar("Fashio", 'Please fill all field' , colorText: Colors.red, icon: const Icon(Icons.error),);
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorTheme.bgcolor
                    ),
                    child: load
                        ? const CircularProgressIndicator(
                      color: Colors.yellow,
                    )
                        : Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18, color: ColorTheme.btntxtcolor),
                    ),
                  ),
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  //
  // saveDataToFireStore()  async{
  //   final userData = UserModel(
  //       userName: _usernameController.text,
  //       userEmail: _emailController.text,
  //       userPassword: _passwordController.text,
  //       userPhoneNumber: _phoneController.text ,
  //       type: account
  //   );
  // }
  //
  //
  // Future<void> createUser(UserModel user)
  // async {
  //   await userRepo.CreatUser(user);
  //
  // }

//   signupFormValidation() async{
//
//     String userName = _usernameController.text;
//     String userEmail = _emailController.text;
//     String userPassword = _passwordController.text;
//
//     User? user = await auth.signupWithEmailPasswordService(userEmail, userPassword);
//
//
//     if(user != null)
// {
//   Get.to(()=>const LoginPage());
//
//   Get.snackbar("Fashio", 'User Login Successful' , colorText: Colors.blue, icon: const Icon(Icons.add_alert),);
// }else {
//       Get.snackbar("Fashio", 'User Login UnSuccessful' , colorText: Colors.blue, icon: const Icon(Icons.add_alert),);
//     }
//   }
}
