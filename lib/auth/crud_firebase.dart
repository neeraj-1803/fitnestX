import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnestx_flutter/helper/heper_methods.dart';
import 'package:flutter/material.dart';

Future<void> createUserDocument(
    UserCredential? userCredential, Map<String, dynamic> data) async {
  if (userCredential != null && userCredential.user != null) {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential.user!.email)
        .set(data);
  }
}

Future<void> updateUserDocument(
    Map<Object, Object?> data, context, pathName) async {
  showLoading();
  User? userCredential = FirebaseAuth.instance.currentUser;
  if (userCredential != null && userCredential.email != null) {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential.email)
        .update(data);
  }
  dismissLoading();
  if (context.mounted && pathName != null) {
    Navigator.of(context).pushNamed(pathName);
  }
}
