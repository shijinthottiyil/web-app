import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

class HomeController with ChangeNotifier {
  bool isLoading = false;
  Future<void> googleSignIn() async {
    isLoading = true;
    notifyListeners();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> storeData(
      String userName, String age, String batchNum, String course) async {
    isLoading = true;
    notifyListeners();
    try {
      String uuid = Uuid().v1();
      UserModel userModel = UserModel(
          name: userName,
          age: age,
          batchNum: batchNum,
          course: course,
          docId: uuid);
      await FirebaseFirestore.instance.collection('users').doc(uuid).set(
            userModel.toJson(),
          );
    } catch (e) {
      log(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateData(String docId, UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .update(userModel.toJson());
  }

  Future<void> deleteData(
    String docId,
  ) async {
    await FirebaseFirestore.instance.collection('users').doc(docId).delete();
  }
}
