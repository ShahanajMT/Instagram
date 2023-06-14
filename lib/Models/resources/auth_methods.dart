import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:instagram_flutter/Models/resources/storage_methods.dart';
import 'package:instagram_flutter/Models/user_models.dart' as model;

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  //SignUp User
  Future<String> signUpUser({
    required Uint8List file,
    required String username,
    required String email,
    required String password,
    required String bio,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        //register User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        log(cred.user!.uid);

        // ImageUpload
        String photoUrl = await StorageMethod()
            .uploadImageToStorage("profilePics", file, false);

        //Another Method to access data without "uid"
        // await _firestore.collection("users").add({
        //   "username": username,
        //   "uid": cred.user!.uid,
        //   "email": email,
        //   "bio": bio,
        //   "followers": [],
        //   "following": [],
        // });

        //
        model.User user = model.User(
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          username: username,
          bio: bio,
          followers: [],
          following: [],
        );

        //add User to DB
        await _firestore.collection("users").doc(cred.user!.uid).set(user.toJson(),);
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //logging User
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "please enter all the feilds";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
