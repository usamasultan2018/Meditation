import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../../view/bottomBar/bottom_nav_bar.dart';

class LoginController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // For Loading
  bool _loading = false;

  bool get loading => _loading;

  // For Password Hide and UnHide
  bool _showPassword = false;

  bool get showPassword => _showPassword;

  // Toggle password
  void setShowPassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void validateFormKey(BuildContext context) {
    if (formKey.currentState!.validate()) {
      print(emailController.text);
      print(passwordController.text);
      loginUser(context);
      notifyListeners();
    }
  }

  Future<void> loginUser(BuildContext context) async {
    setLoading(true);
    try {
     await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx){
       return BottomNavBar();
     }), (route) => false);
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      if (e.code == 'email-already-in-use') {
        Utils.flushBarErrorMessage(e.message.toString(), context);
      } else if (e.code == 'missing-email') {
        Utils.flushBarErrorMessage('Email address not found', context);
      } else if (e.code == 'wrong-password') {
        Utils.flushBarErrorMessage(e.message.toString(), context);
      } else if (e.code == 'user-not-found') {
        Utils.flushBarErrorMessage(e.message.toString(), context);
      } else {
        Utils.flushBarErrorMessage(e.message.toString(), context);
      }
    } catch (e) {
      setLoading(false);
      Utils.flushBarErrorMessage(e.toString(), context);
    }
  }
}
