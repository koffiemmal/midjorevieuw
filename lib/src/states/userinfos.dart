import 'package:flutter/material.dart';
import 'package:midjo/src/services/firebase_service.dart';

class UserDataProvider with ChangeNotifier {
  Map<String, dynamic>? _userData;

  Map<String, dynamic>? get userData => _userData;

  Future<void> loadUserData() async {
    try {
      await clearUserData();
      final data = await AuthFirebase.getUserByUid();
      if (data != null) {
        _userData = data;
        notifyListeners();
      } else {
        print("No data found for user UID");
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  Future<void> updateUserDataNom(String nom) async {
    if (_userData != null) {
      _userData!['Nom'] =
          nom; // Ensure the key matches the one used in the widget
      await AuthFirebase.updateUserDataNom(nom: nom);
      notifyListeners();
    }
  }

  Future<void> updateUserDataNumero(String numero) async {
    if (_userData != null) {
      _userData!['phoneNumber'] =
          numero; // Ensure the key matches the one used in the widget
      await AuthFirebase.updateUserDataNumero(numero: numero);
      notifyListeners();
    }
  }

  Future<void> updateUserDataEmail(String email) async {
    if (_userData != null) {
      _userData!['email'] =
          email; // Ensure the key matches the one used in the widget
      await AuthFirebase.updateUserDataEmail(email: email);
      notifyListeners();
    }
  }

  Future<void> clearUserData() async {
    _userData = null;
    notifyListeners();
  }
}
