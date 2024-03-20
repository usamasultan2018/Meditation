import 'package:flutter/material.dart';
import 'package:meditation/view/signup/sign_up_screen.dart';
import 'package:meditation/view_model/controller/login/login_controller.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<LoginController>(
          builder:
              (BuildContext context, LoginController value, Widget? child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: value.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: TextFormField(
                        controller: value.emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Email",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: value.passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Passwords",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1))),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text("Forgot password",style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity,40),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue, // Text color
                          elevation: 5, // Elevation (shadow)
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          value.validateFormKey(context);
                        },
                        child: value.loading?CircularProgressIndicator():Text("Login"),
                      ),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                          return SignUpScreen();
                        }));
                      },
                      child: Text("No account yet? Register Now",style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
