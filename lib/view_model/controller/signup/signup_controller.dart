import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meditation/model/user_model.dart';
import 'package:meditation/repository/sign_up_repository.dart';
import 'package:meditation/view/login/login_screen.dart';

import '../../../utils/utils.dart';

class SignUpController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SignUpRepository repository = SignUpRepository();

  //Firebase auth and firestore..
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //For Loading....
  bool _loading = false;

  bool get loading => _loading;

  //For Password Hide and UnHide...
  bool _showPassword = false;

  bool get showPassword => _showPassword;

  //Toggle password..
  setShowPassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
  }


  validateFormKey(BuildContext context) {
    if (formKey.currentState!.validate()) {
       createAccount(context);
       notifyListeners();
    }
  }

  Future<void> createAccount(BuildContext context) async {
    setLoading(true);
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),);
      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        username: usernameController.text,
        email: emailController.text,
        profileUrl: "",
      );
      await repository.createUser(userCredential.user!.uid, userModel).then((value){
        setLoading(false);
        Navigator.pop(context);
        usernameController.clear();
        emailController.clear();
        passwordController.clear();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_){
          return LoginScreen();
        }), (route) => false);
        Utils.flushBarDoneMessage(
            "Account Created Successfully, we have send verification",
            context,
            10);
        SignUpController().dispose();
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.flushBarErrorMessage(error.toString(), context);
      });
    }
    on FirebaseAuthException catch(e){
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
    }
    catch(e){
      setLoading(false);
      Utils.flushBarErrorMessage(e.toString(), context);
    }
  }
}