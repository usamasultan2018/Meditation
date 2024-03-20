import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';

class SignUpRepository {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("Users");

  Future<void> createUser(String id,UserModel userModel) async {
    _userCollection.doc(id).set(userModel.toMap());
  }
}
