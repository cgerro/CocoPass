import 'package:flutter/material.dart';

class UserProfile with ChangeNotifier {
  String _userProfileImageUrl = 'assets/user_icons/default_user_icon.png';

  String get userProfileImageUrl => _userProfileImageUrl;

  void setProfileImage(String imageUrl) {
    _userProfileImageUrl = imageUrl;
    notifyListeners();
  }
}
