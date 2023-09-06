import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile with ChangeNotifier {
  late String _userProfileImageUrl;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get userProfileImageUrl => _userProfileImageUrl;

  Future<void> fetchProfileImage() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      String userID = currentUser.uid;

      final doc = await _firestore.collection('users').doc(userID).get();
      final data = doc.data() as Map<String, dynamic>;

      // Mettre à jour l'URL de l'image de profil
      _userProfileImageUrl = data['profileImageUrl'] ?? 'assets/user_icons/default_user_icon.png';
      notifyListeners();
    }
  }

  void setProfileImage(String imageUrl) async {
    _userProfileImageUrl = imageUrl;

    // Mise à jour de Firestore
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      String userID = currentUser.uid;
      await _firestore.collection('users').doc(userID).update({
        'profileImageUrl': imageUrl,
      }).catchError((error) {
        log("Failed to update user: $error");
      });
    }
    notifyListeners();
  }
}